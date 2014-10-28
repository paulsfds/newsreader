//
//  MoreNewsStore.h
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "AbstractStore.h"

@interface MoreNewsStore : AbstractStore

+ (MoreNewsStore *)defaultStore;
- (NSArray *)getNItems:(NSUInteger)n;

@end
