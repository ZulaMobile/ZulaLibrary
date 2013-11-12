//
//  SMNavigationApperanceManager.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMNavigationApperanceManager.h"
#import "SMAppDescription.h"
#import "UIColor+ZulaAdditions.h"
#import "SMNavigationDescription.h"
#import "SDWebImageManager.h"

@interface SMNavigationApperanceManager()
- (void)appearancesForNavBarBackgroundColor:(NSString *)hexColor;
- (void)appearancesForNavBarTextColor:(NSString *)hexColor;
- (void)appearancesForNavBarBackgroundImageUrl:(NSString *)imageUrl;
//- (void)appearancesForNavBarIconSet:(NSString *)iconSet;
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
    
    // nav bar apperance
    NSDictionary *navApperance = [navDesc appearance];
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
    if (![navbarImageUrl isEqualToString:@""]) {
        [self appearancesForNavBarBackgroundImageUrl:navbarImageUrl];
    }
}

#pragma mark - private methods

- (void)appearancesForNavBarBackgroundColor:(NSString *)hexColor
{
    if (!hexColor) {
        return;
    }
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHex:hexColor]];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithHex:hexColor]];
    
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

    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithHex:hexColor], UITextAttributeTextColor,
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

#pragma mark - web image delegate
/*
- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    DDLogInfo(@"finished");
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error
{
    DDLogError(@"image not downloaded");
}
*/
@end
