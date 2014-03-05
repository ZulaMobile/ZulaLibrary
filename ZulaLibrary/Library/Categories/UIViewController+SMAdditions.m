//
//  UIViewController+SMAdditions.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 08/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "UIViewController+SMAdditions.h"

@implementation UIViewController (SMAdditions)

- (void)displayError:(NSError *)error {
	if (!error) {
		return;
	}
	
	[self displayErrorString:[error localizedDescription]];
}


- (void)displayErrorString:(NSString *)string {
	if (!string || [string length] < 1) {
		return;
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                    message:string
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Close", nil)
                                          otherButtonTitles:nil];
	[alert show];
}

@end
