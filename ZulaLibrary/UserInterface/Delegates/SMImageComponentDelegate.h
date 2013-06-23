//
//  SMImageComponentDelegate.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMBaseComponentViewController.h"
#import "SMImageView.h"
#import "MWPhotoBrowser.h"

@interface SMImageComponentDelegate : NSObject <SMImageViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, weak) SMBaseComponentViewController *component;

- (id)initWithComponent:(SMBaseComponentViewController *)component;

@end
