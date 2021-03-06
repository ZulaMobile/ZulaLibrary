//
//  SMHomePageControllerViewController.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMBaseComponentViewController.h"


@class SMHomePage, SMLinks, SMImageView;

/**
 Home Page Component automatically displays all registered components 
 in order (if menu is not hidden)
 */
@interface SMHomePageViewController : SMBaseComponentViewController

/**
 The optional logo image
 */
@property (nonatomic, strong) SMImageView *logoView;

/**
 Buttons/links container. Depending on the configuration, this object
 can display buttons in different listing style (grid, tabular, etc) or
 not displaying them at all
 */
@property (nonatomic, strong) SMLinks *linksView;

@end
