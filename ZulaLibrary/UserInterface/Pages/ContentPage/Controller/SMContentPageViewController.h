//
//  SMContentPageViewController.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMBaseComponentViewController.h"

@class SMImageView, SMLabel, SMWebView;

/**
 Content page is a simple page consist of title, text and image
 
 @discussion
 The image is optional and if not set, title and text will go up to its place
 The component supports scrolling.
 
 @see SMContentPage model class for the component data to fetch for this page
 */
@interface SMContentPageViewController : SMBaseComponentViewController <UIWebViewDelegate>

/**
 Title label
 See label appearance attributes
 */
@property (nonatomic, strong) SMLabel *titleView;

/**
 web view to show html content
 */
@property (nonatomic, strong) SMWebView *webView;

/**
 The 320x150 image view.
 If there is no image set, this view will disappear
 */
@property (nonatomic, strong) SMImageView *imageView;

@end
