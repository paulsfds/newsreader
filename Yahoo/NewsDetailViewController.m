//
//  NewsDetailViewController.m
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsClient.h"
#import "Constants.h"
#import "NewsDetailParser.h"
#import "NewsItem.h"

@interface NewsDetailViewController ()

@property (strong, nonatomic) NewsClient *newsClient;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = self.newsItem.title;
    
    self.newsClient = [[NewsClient alloc] initWithBaseURL:kNewsBaseURL];
    
    [self refresh];
}

- (void)refresh
{
    [self.newsClient fetchNewsDetailsWithID:self.newsItem.newsId success:^(NSDictionary *responseObject) {
        NewsDetailParser *newsDetailParser = [[NewsDetailParser alloc] initWithResponse:responseObject];
        NSString *contentHTML = [newsDetailParser getHTML];
        
       [self.webView loadHTMLString:contentHTML baseURL:[NSURL URLWithString:self.newsItem.link]]; 
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
