//
//  SMProductDetailViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/30/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"

@class SMProductDetail, SMLabel, SMWebView, SMMultipleImageView;

@interface SMProductDetailViewController : SMBaseComponentViewController <UIWebViewDelegate>

/**
 Model instance
 */
@property (nonatomic, strong) SMProductDetail *productDetail;

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
