//
//  SMPreloaderComponentViewController.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMPreloaderComponentDelegate <NSObject>
/**
 Triggered when error button tapped
 */
- (void)preloaderOnErrButton;
@end

@interface SMPreloaderComponentViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<SMPreloaderComponentDelegate> delegate;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

- (void)onAppFail;

@end
