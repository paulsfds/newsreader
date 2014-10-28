//
//  NewsClient.m
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "NewsClient.h"
#import "AFHTTPRequestOperationManager.h"

@interface NewsClient ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

@end

@implementation NewsClient

- (instancetype)initWithBaseURL:(NSString *)baseURL {
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:baseURL];
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    
    return self;
}

- (void)fetchNewsWithSuccess:(NewsSuccessBlock)success failure:(NewsFailureBlock)failure {
    [self.manager GET:@"newsfeed" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)fetchNewsDetailsWithID:(NSString *)uuid success:(NewsDetailsSuccessBlock)success failure:(NewsDetailsFailureBlock)failure {
    NSString *urlString = [NSString stringWithFormat:@"newsitems/%@/content", uuid];
    
    [self.manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)fetchMoreNewsWithIDs:(NSString *)ids success:(NewsSuccessBlock)success failure:(NewsFailureBlock)failure {
    NSDictionary *params = @{ @"uuid": ids };
    
    [self.manager GET:@"newsitems" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
