//
//  NewsStore.m
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "NewsStore.h"
#import "NewsItem.h"

static NewsStore *sharedInstance = nil;

@implementation NewsStore

+ (NewsStore *)defaultStore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NewsStore alloc] init];
        // Do any other initialization stuff here
    });
    
    return sharedInstance;
}

// Override to make sure no duplicates are entered.
- (void)addItems:(NSArray *)items {
    for (NewsItem *newsItem in items) {
        if (![self containsObject:newsItem]) {
            [self addItem:newsItem];
        }
    }
}

@end
