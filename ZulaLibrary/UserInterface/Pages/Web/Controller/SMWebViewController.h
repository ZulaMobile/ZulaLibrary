//
//  SMWebViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/12/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"

@class SMWeb, SMWebView;

@interface SMWebViewController : SMBaseComponentViewController <UIWebViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) SMWebView *webView;

@end
