//
//  NewsDetailParser.m
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "NewsDetailParser.h"

@interface NewsDetailParser ()

@property (strong, nonatomic) NSDictionary *response;

@end

@implementation NewsDetailParser

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.response = response;
    }
    
    return self;
}

- (NSString *)getHTML {
    NSDictionary *result = [self.response objectForKey:@"result"];
    NSDictionary *content = [result objectForKey:@"content"];
    
    NSString *contentHTML = @"Error loading story.";
    if (![content isEqual:[NSNull null]]) {
        contentHTML = [content objectForKey:@"content"];
    }
    
    return contentHTML;
}

@end
