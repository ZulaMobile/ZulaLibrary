//
//  SMNavigation.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMNavigationApperanceManager, SMBaseComponentViewController, SMComponentDescription;
@protocol SMNavigation <NSObject>

@property (nonatomic, strong) SMNavigationApperanceManager *apperanceManager;

/**
 Component Descriptions array, avoid to use it directly. Rather use messages in this protocol.
 */
@property (nonatomic, strong) NSArray *componentDescriptions;

// @deprecated
//@property (nonatomic, strong) NSArray *components;

// Deprecated
//- (void)addChildComponent:(UIViewController *)component;

/**
 Adds the component description to the navigation stack. These component descriptions
 are going to be used for creating component instances, and displaying component buttons.
 
 The navigation class should add only components who are available for navigation, 
 i.e. navbar component shouldn't add HomePageComponent
 */
- (void)addChildComponentDescription:(SMComponentDescription *)componentDescription;

/**
 Gets the component description from AppDescription, 
 create its component and returns it
 
 Raises an exception if component is not found at index
 */
- (SMBaseComponentViewController *)componentAtIndex:(NSInteger)index;

/**
 Present the component using an approptiate way. Using the optional fromCompoonent if needed.
 @discussion
 Tabbar navigation should only change tabs to present component
 Navbar navigation should push the component to the navigation stack
 */
- (void)navigateComponent:(UIViewController *)toComponent fromComponent:(UIViewController *)fromComponent;

@end
