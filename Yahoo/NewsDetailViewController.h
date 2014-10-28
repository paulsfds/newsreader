//
//  NewsDetailViewController.h
//  Yahoo
//
//  Created by Paul Wong on 12/18/13.
//  Copyright (c) 2013 PP Productions LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsItem;

@interface NewsDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NewsItem *newsItem;

@end
