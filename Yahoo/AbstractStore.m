//
//  AbstractStore.m
//  WarriorsFan
//
//  Created by Paul Wong on 2/16/13.
//
//

#import "AbstractStore.h"

@interface AbstractStore ()

@property (nonatomic, strong) NSMutableOrderedSet *allItems;

@end

@implementation AbstractStore

- (instancetype)init {
    self = [super init];
    if (self) {
        self.allItems = [[NSMutableOrderedSet alloc] initWithCapacity:5];
    }
    
    return self;
}

- (void)addItem:(id)item {
    [self.allItems addObject:item];
}

- (void)addItem:(id)item atIndex:(NSUInteger)atIndex {
    [self.allItems insertObject:item atIndex:atIndex];
}

- (void)addItems:(NSArray *)items {
    [self.allItems addObjectsFromArray:items];
}

- (void)removeItem:(id)item {
    [self.allItems removeObject:item];
}

- (void)removeAll {
    [self.allItems removeAllObjects];
}

- (void)removeItemsAtIndexes:(NSIndexSet *)indexSet {
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [self removeItem:[self.allItems objectAtIndex:idx]];
    }];
}

- (void)removeItems:(NSArray *)items {
    [self.allItems removeObjectsInArray:items];
}

- (BOOL)isEmpty {
    return self.allItems.count == 0;
}

- (BOOL)doesItemExist:(id)item {
    return [self.allItems containsObject:item];
}

- (id)getItemAtIndex:(NSUInteger)atIndex {
    return [self.allItems objectAtIndex:atIndex];
}

- (int)count {
    return self.allItems.count;
}

- (BOOL)containsObject:(id)object {
    return [self.allItems containsObject:object];
}

- (NSArray *)getItems {
    return [self.allItems array];
}

- (NSArray *)getItemsAtIndexes:(NSIndexSet *)indexSet {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [items addObject:[self getItemAtIndex:idx]];
    }];
    
    return items;
}

@end

