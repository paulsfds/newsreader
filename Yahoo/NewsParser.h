//
//  NewsParser.h
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsParser : NSObject

- (instancetype)initWithResponse:(NSDictionary *)response;
- (NSArray *)getItems;
- (NSArray *)getMoreItems;

@end
