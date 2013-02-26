//
//  SMNavigationApperanceManager.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMNavigationApperanceManager.h"
#import "SMAppDescription.h"
#import "UIColor+SSToolkitAdditions.h"

@interface SMNavigationApperanceManager()
- (void)appearancesForNavBarBackgroundColor:(NSString *)hexColor;
- (void)appearancesForNavBarTintColor:(NSString *)hexColor;
//- (void)appearancesForNavBarBackgroundImageUrl:(NSString *)imageUrl;
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
    
    // nav bar apperance
    NSDictionary *navBarApperance = [appDesc.appearance objectForKey:@"navbar"];
    if (navBarApperance) {
        [self appearancesForNavBarBackgroundColor:[navBarApperance objectForKey:@"bg_color"]];
        [self appearancesForNavBarTintColor:[navBarApperance objectForKey:@"tint_color"]];
    }
}

#pragma mark - private methods

- (void)appearancesForNavBarBackgroundColor:(NSString *)hexColor
{
    if (!hexColor) {
        return;
    }
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithHex:hexColor]];
}

- (void)appearancesForNavBarTintColor:(NSString *)hexColor
{
    if (!hexColor) {
        return;
    }
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHex:hexColor]];
}

@end
