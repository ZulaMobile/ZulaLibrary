//
//  SMContentViewController.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMBaseComponentViewController.h"

@class SMImageView, SMLabel, SMMultipleImageView, SMWebView;

/**
 Content page is a simple page consist of title, text and image
 
 @discussion
 The image is optional and if not set, title and text will go up to its place
 The component supports scrolling.
 
 @see SMContentPage model class for the component data to fetch for this page
 */
@interface SMContentViewController : SMBaseComponentViewController <UIWebViewDelegate>

/**
 web view to show html content
 */
@property (nonatomic, strong) SMWebView *webView;

/**
 The 320x160 image view.
 If there is no image set, this view will disappear
 */
@property (nonatomic, strong) SMMultipleImageView *imageView;

@end
