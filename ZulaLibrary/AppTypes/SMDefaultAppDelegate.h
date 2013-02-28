//
//  SMDefaultAppDelegate.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMAppDelegate.h"

/**
 Base App Delegate: Provides basic structure to start the zula app
 All the app type delegates must derive from this class
 */
@interface SMDefaultAppDelegate : UIResponder <SMAppDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
