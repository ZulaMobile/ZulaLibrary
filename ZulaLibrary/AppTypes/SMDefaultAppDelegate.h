//
//  SMDefaultAppDelegate.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMAppDelegate.h"
#import "SMPreloaderComponentViewController.h"

/**
 Base App Delegate: Provides basic structure to start the zula app
 All the app type delegates must derive from this class
 */
@interface SMDefaultAppDelegate : UIResponder <UIApplicationDelegate, SMAppDelegate, SMPreloaderComponentDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 Reloads the app with app descriptors.
 This means that any appearance setting will be refreshed.
 Keep in mind that, Regular component refreshing will only refresh the component data, not the appearance descriptions
 */
- (void)refreshApp;
- (void)refreshAppWithCompletion:(void(^)(NSError *))completion;

/**
 Common operations prior to loading the app
 i.e. Starting loggers and background timers.
 */
- (void)prepareApp;

@end
