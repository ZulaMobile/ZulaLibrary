//
//  UIViewController+SMAdditions.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 08/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SMAdditions)

- (void)displayError:(NSError *)error;
- (void)displayErrorString:(NSString *)string;

@end
