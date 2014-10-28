//
//  AbstractStore.h
//  WarriorsFan
//
//  Created by Paul Wong on 2/16/13.
//
//

#import <Foundation/Foundation.h>

@interface AbstractStore : NSObject

- (void)addItem:(id)item;
- (void)addItem:(id)item atIndex:(NSUInteger)atIndex;
- (void)addItems:(NSArray *)items;
- (void)removeItem:(id)item;
- (void)removeAll;
- (void)removeItemsAtIndexes:(NSIndexSet *)indexSet;
- (void)removeItems:(NSArray *)items;
- (BOOL)isEmpty;
- (BOOL)doesItemExist:(id)item;
- (id)getItemAtIndex:(NSUInteger)atIndex;
- (int)count;
- (BOOL)containsObject:(id)object;
- (NSArray *)getItems;
- (NSArray *)getItemsAtIndexes:(NSIndexSet *)indexSet;

@end

