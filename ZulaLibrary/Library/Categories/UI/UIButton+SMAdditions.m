//
//  UIButton+SMAdditions.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "UIButton+SMAdditions.h"
#import "UILabel+SMAdditions.h"

@implementation UIButton (SMAdditions)

- (void)addGlow:(UIColor *)glowColor
{
    [self.titleLabel addGlow:glowColor];
}

@end
