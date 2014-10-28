//
//  MoreNewsStore.m
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "MoreNewsStore.h"

static MoreNewsStore *sharedInstance = nil;

@implementation MoreNewsStore

+ (MoreNewsStore *)defaultStore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MoreNewsStore alloc] init];
        // Do any other initialization stuff here
    });
    
    return sharedInstance;
}

// Returns N items in order. If N is greater than the Store's count, then just
// just return the entire Store.
- (NSArray *)getNItems:(NSUInteger)n {
    NSIndexSet *indexSet;
    if ([self count] > n) {
        indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, n)];
    } else {
        indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, [self count])];
    }
    
    return [self getItemsAtIndexes:indexSet];
}

@end
