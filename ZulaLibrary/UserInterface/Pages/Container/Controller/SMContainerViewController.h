//
//  SMContainerViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"

@class SDSegmentedControl, SMContainer;

/**
 Container page is a container of Component Pages. It can display any component whose description is added
 to `components` attribute on `SMContainer` model. 
 
 It displays a menu to choose between them. 
 */
@interface SMContainerViewController : SMBaseComponentViewController

/**
 Model class
 */
@property (nonatomic, strong) SMContainer *container;

/**
 Submenu view contains the buttons for sub-components
 */
@property (nonatomic, strong) SDSegmentedControl *subMenu;

@end
