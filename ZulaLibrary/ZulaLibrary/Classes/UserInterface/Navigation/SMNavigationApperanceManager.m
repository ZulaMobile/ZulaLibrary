//
//  SMNavigationApperanceManager.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMNavigationApperanceManager.h"
#import "Macros.h"

#import "SMAppDescription.h"
#import "UIColor+ZulaAdditions.h"
#import "SMNavigationDescription.h"
#import "SDWebImageManager.h"

@interface SMNavigationApperanceManager()

- (void)appearancesForNavBarBackgroundColor:(NSString *)hexColor;
- (void)appearancesForNavBarTextColor:(NSString *)hexColor;
- (void)appearancesForNavBarBackgroundImageUrl:(NSString *)imageUrl;
//- (void)appearancesForNavBarIconSet:(NSString *)iconSet;

- (void)appearancesForTabBarBackgroundColor:(NSString *)hexColor;
- (void)appearancesForTabBarTextColor:(NSString *)hexColor;
- (void)appearancesForTabBarBackgroundImageUrl:(NSString *)imageUrl;

@end

@implementation SMNavigationApperanceManager

+ (SMNavigationApperanceManager *)appearanceManager
{
    return [[SMNavigationApperanceManager alloc] init];
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    SMAppDescription *appDesc = [SMAppDescription sharedInstance];
    SMNavigationDescription *navDesc = [appDesc navigationDescription];
    NSDictionary *navApperance = [navDesc appearance];
    
    // nav bar apperance
    NSDictionary *navBarApperance = [navApperance objectForKey:@"navbar"];
    if (navBarApperance) {
        NSDictionary *bg_img = [navBarApperance objectForKey:@"bg_image"];
        if (bg_img) {
            [self appearancesForNavBarBackgroundColor:[bg_img objectForKey:@"bg_color"]];
        }
        
        [self appearancesForNavBarTextColor:[navBarApperance objectForKey:@"text_color"]];
    }
    
    // nav bar data
    NSString *navbarImageUrl = [navDesc.data objectForKey:@"navbar_bg_image"];
    [self appearancesForNavBarBackgroundImageUrl:navbarImageUrl];
    
    // tabbar appearance
    NSDictionary *tabBarApperance = [navApperance objectForKey:@"tabbar"];
    if (tabBarApperance) {
        NSDictionary *bg_img = [tabBarApperance objectForKey:@"bg_image"];
        if (bg_img) {
            [self appearancesForTabBarBackgroundColor:[bg_img objectForKey:@"bg_color"]];
        }
        
        [self appearancesForTabBarTextColor:[tabBarApperance objectForKey:@"text_color"]];
    }
    
    // tab bar data
    NSString *tabbarImageUrl = [navDesc.data objectForKey:@"tabbar_bg_image"];
    if (![tabbarImageUrl isEqualToString:@""]) {
        [self appearancesForTabBarBackgroundImageUrl:tabbarImageUrl];
    }
}

#pragma mark - private methods

- (void)appearancesForNavBarBackgroundColor:(NSString *)hexColor
{
    if (!hexColor) {
        return;
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        // background color
        //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHex:hexColor]];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHex:hexColor alpha:0.4f]];
    } else {
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithHex:hexColor]];
        [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithHex:hexColor]];
    }
}

- (void)appearancesForNavBarBackgroundImageUrl:(NSString *)imageUrl
{    
    if (!imageUrl || [imageUrl isEqualToString:@""]) {
        
        return;
    }
#warning load async
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    CGFloat screenScale = 2; //[UIScreen mainScreen].scale;  
    if (screenScale != image.scale) {  
        image = [UIImage imageWithCGImage:image.CGImage scale:screenScale orientation:image.imageOrientation];
    }
    
    [[UINavigationBar appearance] setBackgroundImage:image
                                       forBarMetrics:UIBarMetricsDefault];
    
    /*
    NSLog(@"url: %@", imageUrl);
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:imageUrl] options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
        //progress
        DDLogInfo(@"size: %d", receivedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        // completed
        
        if (finished && !error) {
            DDLogInfo(@"completed");
            CGFloat screenScale = 2; //[UIScreen mainScreen].scale;
            if (screenScale != image.scale) {
                image = [UIImage imageWithCGImage:image.CGImage scale:screenScale orientation:image.imageOrientation];
            }
            
            [[UINavigationBar appearance] setBackgroundImage:image
                                               forBarMetrics:UIBarMetricsDefault];
        } else {
            DDLogInfo(@"not finished");
        }
    }];
    */
}

- (void)appearancesForNavBarTextColor:(NSString *)hexColor
{
    if (!hexColor) {
        return;
    }

    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        // text color
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithHex:hexColor]];
    }
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithHex:hexColor], NSForegroundColorAttributeName,
      nil]];
    /*
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], UITextAttributeTextColor,
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8], UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,
      nil]];
     */
}

- (void)appearancesForTabBarBackgroundColor:(NSString *)hexColor
{
    if (!hexColor) {
        return;
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        // background color
        [[UITabBar appearance] setBarTintColor:[UIColor colorWithHex:hexColor]];
    } else {
        [[UITabBar appearance] setTintColor:[UIColor colorWithHex:hexColor]];
        [[UITabBar appearance] setBackgroundColor:[UIColor colorWithHex:hexColor]];
    }
}

- (void)appearancesForTabBarTextColor:(NSString *)hexColor
{
    if (!hexColor) {
        return;
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        // text color
        [[UITabBar appearance] setTintColor:[UIColor colorWithHex:hexColor]];
    } else {
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithHex:hexColor] }
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithHex:@"CCCCCC"] }
                                                 forState:UIControlStateSelected];
    }
}

- (void)appearancesForTabBarBackgroundImageUrl:(NSString *)imageUrl
{
    
}

#pragma mark - web image delegate
/*
- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    NSLog(@"finished");
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error
{
    NSLog(@"image not downloaded");
}
*/
@end
