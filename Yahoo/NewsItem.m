//
//  NewsItem.m
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "NewsItem.h"

@interface NewsItem ()

@end

@implementation NewsItem

- (instancetype)initWithFeatured:(NSString *)featured title:(NSString *)title link:(NSString *)link images:(NSArray *)images type:(NSString *)type summary:(NSString *)summary hostedType:(NSString *)hostedType newsId:(NSString *)newsId publisher:(NSString *)publisher uuid:(NSString *)uuid {
    self = [super init];
    if (self) {
        self.featured = featured;
        self.title = title;
        self.link = link;
        self.images = images;
        self.type = type;
        self.summary = summary;
        self.hostedType = hostedType;
        self.newsId = newsId;
        self.publisher = publisher;
        self.uuid = uuid;
        self.isDeleted = NO;
    }
    
    return self;
}

- (instancetype)initWithFeatured:(NSString *)featured newsId:(NSString *)newsId {
    self = [super init];
    if (self) {
        self.featured = featured;
        self.newsId = newsId;
    }
    
    return self;
}

+ (instancetype)newsItemWithDict:(NSDictionary *)dict {
    return [[NewsItem alloc] initWithFeatured:[dict objectForKey:@"featured"] title:[dict objectForKey:@"title"] link:[dict objectForKey:@"link"] images:[dict objectForKey:@"images"] type:[dict objectForKey:@"type"] summary:[dict objectForKey:@"summary"] hostedType:[dict objectForKey:@"hostedType"] newsId:[dict objectForKey:@"id"] publisher:[dict objectForKey:@"publisher"] uuid:[dict objectForKey:@"uuid"]];
}

- (BOOL)isEqual:(id)object {
    NewsItem *aNewsItem = (NewsItem *)object;
    return [self.newsId isEqualToString:aNewsItem.newsId];
}

- (NSUInteger)hash {
    return [self.newsId hash];
}

@end
