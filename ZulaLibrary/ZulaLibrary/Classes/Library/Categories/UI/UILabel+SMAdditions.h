//
//  UILabel+SMAdditions.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SMAdditions)

/**
 Adds a glow effect to the text.
 The glow color is determined automatically as the 
 contrast color of the text. i.e. if text is bright, the glow
 color will be black, otherwise it'll be black
 */
- (void)addGlow;

/**
 Adds glow under the text.
 */
- (void)addGlow:(UIColor *)glowColor;

@end
