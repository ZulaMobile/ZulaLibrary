//
//  SMHomePageControllerViewController.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMBaseComponentViewController.h"

#import "SMImageView.h"

/**
 Home Page Component automatically displays all registered components 
 in order (if menu is not hidden)
 */
@interface SMHomePageViewController : SMBaseComponentViewController

@property (nonatomic, strong) SMImageView *logoView;

@end
