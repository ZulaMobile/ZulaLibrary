//
//  SMComponentModuleManager.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 31/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMBaseComponentViewController;

/**
 *  Responsible for adding modules to components
 */
@interface SMComponentModuleManager : NSObject

+ (NSArray *)modulesForComponent:(SMBaseComponentViewController *)component;

@end
