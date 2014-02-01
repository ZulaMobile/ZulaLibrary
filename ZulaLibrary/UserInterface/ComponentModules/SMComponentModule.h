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
 *  A component module is a delegate class that is attached to a
 *  component and notified when certain events happen.
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
