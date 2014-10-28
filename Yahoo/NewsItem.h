//
//  NewsItem.h
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (copy, nonatomic) NSString *featured;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *summarySource;
@property (copy, nonatomic) NSString *link;
@property (strong, nonatomic) NSArray *images;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *published;
@property (copy, nonatomic) NSString *summary;
@property (strong, nonatomic) NSArray *entities;
@property (copy, nonatomic) NSString *author;
@property (copy, nonatomic) NSString *hostedType;
@property (copy, nonatomic) NSString *newsId;
@property (copy, nonatomic) NSString *publisher;
@property (copy, nonatomic) NSString *uuid;
@property (nonatomic) BOOL isDeleted;

- (instancetype)initWithFeatured:(NSString *)featured title:(NSString *)title link:(NSString *)link images:(NSArray *)images type:(NSString *)type summary:(NSString *)summary hostedType:(NSString *)hostedType newsId:(NSString *)newsId publisher:(NSString *)publisher uuid:(NSString *)uuid;
+ (instancetype)newsItemWithDict:(NSDictionary *)dict;
- (instancetype)initWithFeatured:(NSString *)featured newsId:(NSString *)newsId;

@end
