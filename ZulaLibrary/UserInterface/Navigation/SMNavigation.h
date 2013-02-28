//
//  SMNavigation.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMNavigationApperanceManager.h"

@protocol SMNavigation <NSObject>

@property(nonatomic, strong) NSArray *components;

@property(nonatomic, strong) SMNavigationApperanceManager *apperanceManager;

- (void)addChildComponent:(UIViewController *)component;

/**
 Present the component using an approptiate way. Using the optional fromCompoonent if needed.
 @discussion
 Tabbar navigation should only change tabs to present component
 Navbar navigation should push the component to the navigation stack
 */
- (void)navigateComponent:(UIViewController *)toComponent fromComponent:(UIViewController *)fromComponent;

@end
