//
//  NewsItemCell.m
//  Yahoo
//
//  Created by Paul Wong on 2/11/14.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import "NewsItemCell.h"
#import "NewsItem.h"

@implementation NewsItemCell

- (void)setNewsItem:(NewsItem *)newsItem {
    self.textLabel.text = newsItem.title;
}

- (void)setNewsImage:(UIImage *)image {
    self.imageView.image = image;
    [self setNeedsLayout];
}


@end
