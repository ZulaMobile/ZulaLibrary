//
//  UILabel+SMAdditions.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "UILabel+SMAdditions.h"
#import "UIColor+ZulaAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UILabel (SMAdditions)

- (void)addGlow:(UIColor *)glowColor
{
    self.layer.shadowColor = [glowColor CGColor];
    self.layer.shadowRadius = 4.0f;
    self.layer.shadowOpacity = .9;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.masksToBounds = NO;
}

- (void)addGlow
{
    if ([self.textColor isBright]) {
        [self addGlow:[UIColor blackColor]];
    } else {
        [self addGlow:[UIColor whiteColor]];
    }
}

@end
