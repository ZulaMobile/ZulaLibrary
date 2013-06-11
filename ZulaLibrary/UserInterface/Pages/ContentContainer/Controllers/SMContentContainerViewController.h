//
//  SMContentContainerViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"

@class SMContentContainer, SMSubMenuView, SDSegmentedControl;

/**
 Content Container page is a container of Content Pages. It displays a menu to choose between them. 
 When tapping on a submenu button, it navigates to its `SMContentViewController` instance.
 
 @see http://wiki.zulamobile.com/Content%20Component%20Component
 */
@interface SMContentContainerViewController : SMBaseComponentViewController

/**
 Model attribute that holds the data
 */
@property (nonatomic, strong) SMContentContainer *contentContainer;

/**
 Submenu view contains the buttons for sub-components
 */
@property (nonatomic, strong) SDSegmentedControl *subMenu;

@end
