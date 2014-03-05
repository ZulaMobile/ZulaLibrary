//
//  SMBaseComponentViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SMComponentNavigationDelegate;
@class SMComponentDescription, SMImageView, SMModel;

/**
 Base component provides the common functionality for all components.
 Concrete components must derive from this class
 */
@interface SMBaseComponentViewController : UIViewController 

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
 *  Collection of `SMComponentModule` instances. These objects will be notified
 *  when certain events occur. 
 *  Modules are attached on initialization but can be modified anytime in the life cycle.
 */
@property (nonatomic, strong) NSArray *modules;

/**
 *  The default model of the component. A component is considered to have one main model object.
 */
@property (nonatomic, strong) SMModel *model;

/**
 Initializer (constructor) that must be used to initialize a component instance
 */
- (id)initWithDescription:(SMComponentDescription *)description;

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

/**
 *  Determines wheather it is necessary to fetch contents.
 *  if the contents are up to date, this will return NO
 *
 *  @return 
 */
- (BOOL)shouldFetchContents;

@end

/**
 Component navigation delegate controls when a navigation happens
 This delegate will be used by components who requires sub navigation
 */
@protocol SMComponentNavigationDelegate <NSObject>

@optional
- (void)component:(SMBaseComponentViewController *)component willShowViewController:(UIViewController *)controller animated:(BOOL)animated;

@end


//
//

@interface SMBaseComponentViewController (ModuleAdditions)

/**
 *  Removes a module by its class.
 *
 *  @param cls
 */
- (void)removeModuleByClass:(Class)cls;

/**
 *  Add a module by its class. It creates the module for you.
 *
 *  @param cls
 */
- (void)addModuleByClass:(Class)cls;

/**
 *  Add a module to the modules array
 *
 *  @param module 
 */
- (void)addModule:(id)module;

@end
