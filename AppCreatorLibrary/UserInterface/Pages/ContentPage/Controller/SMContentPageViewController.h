//
//  SMContentPageViewController.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Content page is a simple page consist of title, text and image
 The image is optional and if not set, title and text will go up to its place
 
 @see SMContentPage model class for the component data to fetch for this page
 */
@interface SMContentPageViewController : UIViewController

/**
 
 */
@property (nonatomic, strong) UILabel *titleView;

/**
 
 */
@property (nonatomic, strong) UIWebView *textView;

/**
 
 */
@property (nonatomic, strong) UIImageView *imageView;

@end
