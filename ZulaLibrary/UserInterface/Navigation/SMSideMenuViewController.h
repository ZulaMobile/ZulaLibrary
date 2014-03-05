//
//  SMSideMenuViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 13/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSideMenuViewController : UITableViewController

- (instancetype)initWithComponentDesciptions:(NSArray *)componentDescriptions;

- (void)transitionToViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
