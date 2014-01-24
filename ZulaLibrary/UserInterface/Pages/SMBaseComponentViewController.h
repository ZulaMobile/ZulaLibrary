//
//  SMBaseComponentViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMSwipeComponentStrategy.h"

@protocol SMComponentNavigationDelegate;
@class SMComponentDescription, SMImageView;

/**
 Base component provides the common functionality for all components.
 Concrete components must derive from this class
 */
@interface SMBaseComponentViewController : UIViewController <SMSwipeComponentStrategyDelegate>

/**
 Description file, provides title and slug that the user set
 and appearance dict for view elements.
 */
@property (nonatomic, strong) SMComponentDescription *componentDesciption;

/**
 Background image view, set by the [[App Wide Appearances]] and can be
 overridden by the subclasses
 */
@property (nonatomic, strong) SMImageView *backgroundImageView;

/**
 Component navigation delegate fires event when navigation changes
 */
@property (nonatomic, weak) id<SMComponentNavigationDelegate> componentNavigationDelegate;

/**
 Default padding for the main view
 Default value is 10.0
 */
@property (nonatomic) CGPoint padding;

/**
 Initializer (constructor) that must be used to initialize a component instance
 */
- (id)initWithDescription:(SMComponentDescription *)description;

/**
 Swipe strategy to control swiping gestures
 */
@property (nonatomic, strong) SMSwipeComponentStrategy *swipeStrategy;

/**
 Downloads the contents from the server and set the view files.
 Must be overridden by the subclasses
 */
- (void)fetchContents;

/**
 Sets fetched content data to the views
 */
- (void)applyContents;

/**
 Sets navbar icon 
 */
- (void)applyNavbarIconWithUrl:(NSURL *)navbarIconUrl;

@end

/**
 Component navigation delegate controls when a navigation happens
 This delegate will be used by components who requires sub navigation
 */
@protocol SMComponentNavigationDelegate <NSObject>

@optional
- (void)component:(SMBaseComponentViewController *)component willShowViewController:(UIViewController *)controller animated:(BOOL)animated;

@end
