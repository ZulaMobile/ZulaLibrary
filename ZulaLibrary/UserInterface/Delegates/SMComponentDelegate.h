//
//  SMComponentDelegate.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/27/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMBaseComponentViewController;

@protocol SMComponentStrategy <NSObject>

@property (nonatomic, weak) SMBaseComponentViewController *component;

- (id)initWithComponent:(SMBaseComponentViewController *)component;

@end
