//
//  NewsParser.m
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "NewsParser.h"
#import "NewsItem.h"

@interface NewsParser ()

@property (strong, nonatomic) NSDictionary *response;

- (NSDictionary *)getResult;

@end

@implementation NewsParser

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.response = response;
    }
    
    return self;
}

- (NSArray *)getItems {
    NSMutableArray *newsItems = [[NSMutableArray alloc] init];
    NSDictionary *result = [self getResult];
    NSArray *items = [result objectForKey:@"items"];
    
    // parse the items
    for (NSDictionary *item in items) {
        NewsItem *newsItem = [NewsItem newsItemWithDict:item];
        [newsItems addObject:newsItem];
    }
    
    return newsItems;
}

- (NSArray *)getMoreItems {
    NSMutableArray *moreNewsItems = [[NSMutableArray alloc] init];
    NSDictionary *result = [self getResult];
    NSArray *moreItems = [result objectForKey:@"more_items"];
    
    // parse the more items
    for (NSDictionary *moreItem in moreItems) {
        NewsItem *moreNewsItem = [NewsItem newsItemWithDict:moreItem];
        [moreNewsItems addObject:moreNewsItem];
    }
    
    return moreNewsItems;
}

- (NSDictionary *)getResult {
    return [self.response objectForKey:@"result"];
}

@end
