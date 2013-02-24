//
//  SMProgressHUD.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/24/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Use for displaying stateless ui element as preloader
 Initially it is a wrapper for SVProgressHUD
 This encapsulation will allow us to override HUD
 */
@interface SMProgressHUD : NSObject

+ (void)show;
+ (void)showWithStatus:(NSString*)status;

+ (void)showProgress:(CGFloat)progress;
+ (void)showProgress:(CGFloat)progress status:(NSString*)status;

+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing

// stops the activity indicator, shows a glyph + status, and dismisses HUD 1s later
+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showErrorWithStatus:(NSString *)string;

+ (void)dismiss;

+ (BOOL)isVisible;


@end
