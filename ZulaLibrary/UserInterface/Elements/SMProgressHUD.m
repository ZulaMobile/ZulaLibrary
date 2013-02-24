//
//  SMProgressHUD.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/24/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMProgressHUD.h"
#import "SVProgressHUD.h"

@implementation SMProgressHUD

+ (void)show
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

+ (void)showWithStatus:(NSString*)status
{
    [SVProgressHUD showWithStatus:status];
}

+ (void)showProgress:(CGFloat)progress
{
    [SVProgressHUD showProgress:progress];
}

+ (void)showProgress:(CGFloat)progress status:(NSString*)status
{
    [SVProgressHUD showProgress:progress status:status];
}

// change the HUD loading status while it's showing
+ (void)setStatus:(NSString*)string
{
    [SVProgressHUD setStatus:string];
}

// stops the activity indicator, shows a glyph + status, and dismisses HUD 1s later
+ (void)showSuccessWithStatus:(NSString*)string
{
    [SVProgressHUD showSuccessWithStatus:string];
}

+ (void)showErrorWithStatus:(NSString *)string
{
    [SVProgressHUD showErrorWithStatus:string];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

+ (BOOL)isVisible
{
    return [SVProgressHUD isVisible];
}

@end
