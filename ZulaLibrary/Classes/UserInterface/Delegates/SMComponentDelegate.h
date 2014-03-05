//
//  SMComponentDelegate.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/27/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMBaseComponentViewController;

/**
 *  Component strategies are delegate objects that should be used in a component as class member.
 *  Unlike `SMComponentModule` objects, strategies aren't loaded for each component. They offer
 *  a functionality that is specific to controllers and most likely have tighter coupling with other
 *  objects in the component. For example, a strategy class can be used as a delegator for a view object
 *  or manage/modify a particular object in a component.
 *
 *  A strategy can modify an existing behavior of the component
 *
 *  @see SMComponentModule for more generalized behaviors.
 */
@protocol SMComponentStrategy <NSObject>

@property (nonatomic, weak) SMBaseComponentViewController *component;

- (id)initWithComponent:(SMBaseComponentViewController *)component;

@end
