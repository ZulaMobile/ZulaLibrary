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
 *  Returns the component for the given description
 *
 *  @param componentDescription
 *
 *  @return
 */
+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription;

/**
 *  Returns the component for the given description and navigation
 *
 *  @param componentDescription
 *  @param navigationDescription
 *
 *  @return
 */
+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription
                                 forNavigation:(SMNavigationDescription *)navigationDescription;

/**
 *  Sub component for the given description. Sub components are displayed as it is in an another component
 *
 *  @param componentDescription
 *  @param navigationDescription
 *
 *  @return
 */
+ (UIViewController *)subComponentWithDescription:(SMComponentDescription *)componentDescription
                                    forNavigation:(SMNavigationDescription *)navigationDescription;

@end
