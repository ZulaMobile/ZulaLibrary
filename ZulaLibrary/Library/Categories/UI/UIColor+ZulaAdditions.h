//
//  UIColor+ZulaAdditions.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZulaAdditions)

/**
 Creates and returns lighter version from the uicolor
 */
- (UIColor *)lighterColor;

/**
 Creates and returns darker version from the uicolor
 */
- (UIColor *)darkerColor;

/**
 Returns YES if the color is bright, No if it's dark
 */
- (BOOL)isBright;

/**
 Returns YES if the color is dark, No if it's bright
 */
- (BOOL)isDark;

/**
 Returns YES if the color is white
 */
- (BOOL)isWhite;

/**
 Returns YES if the color is black
 */
- (BOOL)isBlack;

@end