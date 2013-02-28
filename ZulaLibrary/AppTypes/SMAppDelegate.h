//
//  SMAppDelegate.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMNavigation.h"

@protocol SMAppDelegate <NSObject>

/**
 The navigation component is on the heap to prevent memory issues
 */
@property (nonatomic, strong) UIViewController<SMNavigation> *navigationComponent;

@end
