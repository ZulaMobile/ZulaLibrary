//
//  SMComponentModule.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 31/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMBaseComponentViewController, SMModel;

/**
 *  A component module is a delegate object that is attached to a
 *  component and notified when certain events happen.
 *
 *  Unlike `SMComponentStrategy`, a module has looser coupling with component objects.
 *  Modules are supposed to be interchangable during the runtime and offers a general
 *  behavior to the components.
 *
 *  In principle, it is discouraged for a module to modify a component member object.
 *  In other words, modules are meanth to add functionality, not modify or remove existing ones.
 *  To do those, see `SMComponentStrategy`
 */
@protocol SMComponentModule <NSObject>

@property (nonatomic, weak) SMBaseComponentViewController *component;

- (id)initWithComponent:(SMBaseComponentViewController *)component;

@optional

- (void)componentViewDidLoad;
- (BOOL)componentShouldFetchContents;
- (void)componentWillFetchContents;
- (void)componentDidFetchContent:(SMModel *)model;

@end
