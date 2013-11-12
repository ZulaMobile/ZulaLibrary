//
//  SMComponentFactory.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMBaseComponentViewController.h"
#import "SMComponentDescription.h"
#import "SMNavigationDescription.h"

@interface SMComponentFactory : NSObject

/**
 Returns the component for the given description
 */
+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription;

/**
 Returns the component for the given description and navigation
 */
+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription
                                 forNavigation:(SMNavigationDescription *)navigationDescription;

@end
