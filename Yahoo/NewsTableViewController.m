//
//  NewsTableViewController.m
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsStore.h"
#import "MoreNewsStore.h"
#import "NewsItem.h"
#import "NewsDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "NewsClient.h"
#import "NewsParser.h"
#import "NewsItemCell.h"
#import "Constants.h"

// how many more items to load when the user loads more items
static int kGetMoreItemsMax = 5;

@interface NewsTableViewController ()

@property (strong, nonatomic) MNMBottomPullToRefreshManager *pullToRefreshManager;
@property (strong, nonatomic) NewsClient *newsClient;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // add the refresh header view
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]
                                           initWithString:@"Updating..."];
    
    self.pullToRefreshManager = [[MNMBottomPullToRefreshManager alloc]
                                 initWithPullToRefreshViewHeight:60.0f
                                 tableView:self.tableView
                                 withClient:self];
    
    self.newsClient = [[NewsClient alloc] initWithBaseURL:kNewsBaseURL];
    
    [self refresh];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.pullToRefreshManager relocatePullToRefreshView];
}

- (void)refresh {
    [self.refreshControl beginRefreshing];
    
    [self.newsClient fetchNewsWithSuccess:^(NSDictionary *responseObject) {
        [self fetchSuccess:responseObject];
    } failure:^(NSError *error) {
        [self fetchFailed:error];
    }];
}

- (void)fetchSuccess:(NSDictionary *)responseObject {
    NewsParser *newsParser = [[NewsParser alloc] initWithResponse:responseObject];

    NSArray *newsItems = [newsParser getItems];
    NSArray *moreNewsItems = [newsParser getMoreItems];
    [[NewsStore defaultStore] addItems:newsItems];
    [[MoreNewsStore defaultStore] addItems:moreNewsItems];
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)fetchFailed:(NSError *)error {
    [self.refreshControl endRefreshing];
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)loadMoreNewsItems {
    // get N more items defined by a constant
    NSArray *moreItems = [[MoreNewsStore defaultStore] getNItems:kGetMoreItemsMax];

    // create a comma delimited string of all the moreItems' newsIds to use as
    // a query param
    NSString *idList = [[moreItems valueForKey:@"newsId"] componentsJoinedByString:@","];
    NSLog(@"idLIst: %@", idList);
    
    [self.newsClient fetchMoreNewsWithIDs:idList success:^(NSDictionary *responseObject) {
        NewsParser *newsParser = [[NewsParser alloc] initWithResponse:responseObject];
        NSArray *newsItems = [newsParser getItems];
        
        // move items from MoreNewsStore to NewsStore
        [[NewsStore defaultStore] addItems:newsItems];
        [[MoreNewsStore defaultStore] removeItems:moreItems];
        
        [self.pullToRefreshManager tableViewReloadFinished];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.pullToRefreshManager tableViewReloadFinished];
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[NewsStore defaultStore] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsItemCell";
    NewsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[NewsItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NewsItem *newsItem = [[NewsStore defaultStore] getItemAtIndex:indexPath.row];
    [cell setNewsItem:newsItem];
    
    // get the first image and use it as the cell image.
    NSDictionary *firstImage = newsItem.images.firstObject;
    NSString *imageUrl = [firstImage objectForKey:@"url"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    
    __weak NewsItemCell *weakCell = cell;
    [cell.imageView setImageWithURLRequest:urlRequest placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [weakCell setNewsImage:image];
    } failure:nil];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // handle the uitableviewcell selection/tap
    if ([[segue identifier] isEqualToString:@"NewsDetailSegue"]) {
        NewsDetailViewController *destination = (NewsDetailViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destination.newsItem = [[NewsStore defaultStore] getItemAtIndex:indexPath.row];
    }
}

#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshManagerClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewScrolled]
 *
 * Tells the delegate when the user scrolls the content view within the receiver.
 *
 * @param scrollView: The scroll-view object in which the scrolling occurred.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pullToRefreshManager tableViewScrolled];
}

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewReleased]
 *
 * Tells the delegate when dragging ended in the scroll view.
 *
 * @param scrollView: The scroll-view object that finished scrolling the content view.
 * @param decelerate: YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.pullToRefreshManager tableViewReleased];
}

/**
 * Tells client that refresh has been triggered
 * After reloading is completed must call [MNMBottomPullToRefreshManager tableViewReloadFinished]
 *
 * @param manager PTR manager
 */
- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
    [self performSelector:@selector(loadMoreNewsItems) withObject:nil afterDelay:1.0f];
}

@end
