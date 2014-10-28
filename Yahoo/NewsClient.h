//
//  NewsClient.h
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsClient : NSObject

typedef void (^NewsSuccessBlock)(id);
typedef void (^NewsFailureBlock)(NSError *);

typedef void (^NewsDetailsSuccessBlock)(id);
typedef void (^NewsDetailsFailureBlock)(NSError *);

- (instancetype)initWithBaseURL:(NSString *)baseURL;
- (void)fetchNewsWithSuccess:(NewsSuccessBlock)success failure:(NewsFailureBlock)failure;
- (void)fetchNewsDetailsWithID:(NSString *)uuid success:(NewsDetailsSuccessBlock)success failure:(NewsDetailsFailureBlock)failure;
- (void)fetchMoreNewsWithIDs:(NSString *)ids success:(NewsSuccessBlock)success failure:(NewsFailureBlock)failure;

@end
