//
//  SMBaseComponentViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMComponentDescription;

/**
 Base component provides the common functionality for all components.
 Concrete components must derive from this class
 */
@interface SMBaseComponentViewController : UIViewController
{
    /**
     Default padding for the main view
     Default value is 10.0
     */
    float padding;
}

/**
 Description file, provides title and slug that the user set
 and appearance dict for view elements.
 */
@property (nonatomic, strong) SMComponentDescription *componentDesciption;

/**
 Initializer (constructor) that must be used to initialize a component instance
 */
- (id)initWithDescription:(SMComponentDescription *)description;

@end
