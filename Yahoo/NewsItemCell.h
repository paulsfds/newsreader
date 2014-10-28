//
//  NewsItemCell.h
//  Yahoo
//
//  Created by Paul Wong on 2/11/14.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsItem;

@interface NewsItemCell : UITableViewCell

- (void)setNewsItem:(NewsItem *)newsItem;
- (void)setNewsImage:(UIImage *)image;

@end
