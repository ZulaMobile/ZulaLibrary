//
//  SMNavBarNavigationControllerTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "SMAppDescription.h"
//#import "SMNavbarNavigationViewController.h"
#import "SMComponentDescription.h"
//#import "SMBaseComponentViewController.h"
//#import "SMHomePageViewController.h"
//#import "SMContentViewController.h"
//#import "SMContactViewController.h"

/*
@interface SMNavBarNavigationControllerTests : GHTestCase <SMAppDescriptionDataSource>

@end

@implementation SMNavBarNavigationControllerTests
{
    SMNavbarNavigationViewController *navbar;
}

- (void)setUp
{
    SMAppDescription *appDesc = [SMAppDescription sharedInstance];
    appDesc = nil;
    appDesc = [SMAppDescription sharedInstance];
    navbar = [[SMNavbarNavigationViewController alloc] init];
    [appDesc setDataSource:self];
    
    for (SMComponentDescription *compDesc in appDesc.componentDescriptions) {
        [navbar addChildComponentDescription:compDesc];
    }
}

- (void)testSettingUpComponentDescriptions
{
    GHAssertTrue(2 == [navbar.componentDescriptions count], @"navbar compnent count");
    GHAssertTrue([[navbar.componentDescriptions objectAtIndex:0] isKindOfClass:[SMComponentDescription class]], @"");
    GHAssertTrue([[navbar.componentDescriptions objectAtIndex:1] isKindOfClass:[SMComponentDescription class]], @"");

    SMComponentDescription *desc = [navbar.componentDescriptions objectAtIndex:0];
    GHAssertTrue([desc.title isEqualToString:@"Cool Content"], @"");

    desc = [navbar.componentDescriptions objectAtIndex:1];
    GHAssertTrue([desc.title isEqualToString:@"Contact Us"], @"");
}
 
- (void)testGettingComponentControllers
{
    SMBaseComponentViewController *ctrl = [navbar componentAtIndex:0];
    //GHAssertTrue([ctrl isKindOfClass:[SMContentViewController class]], @"");

    ctrl = [navbar componentAtIndex:1];
    //GHAssertTrue([ctrl isKindOfClass:[SMContactViewController class]], @"");
}

#pragma mark - app desc delegate

// mock app data
- (void)fetchAppDescriptionWithCompletion:(void (^)(NSDictionary *, NSError *))completion
{
    NSDictionary *navigation = @{@"appearance": [NSDictionary dictionary],
                                 @"type": @"navbar",
                                 @"navbar_icon": @""};
    NSArray *components = @[@{@"url": @"http://url",
                              @"appearance": [NSDictionary dictionary],
                              @"type": @"HomePageComponent",
                              @"title": @"My Home Page",
                              @"slug": @"my-home-page"},
                            @{@"url": @"http://someutl",
                              @"appearance": [NSDictionary dictionary],
                              @"type": @"ContentComponent",
                              @"title": @"Cool Content",
                              @"slug": @"cool-content"},
                            @{@"url": @"http://someutl",
                              @"appearance": [NSDictionary dictionary],
                              @"type": @"ContactComponent",
                              @"title": @"Contact Us",
                              @"slug": @"contact-us"}
                            ];
    NSDictionary *appDescDict = @{@"navigation": navigation, @"bg_image": @"", @"apperance": [NSDictionary dictionary], @"title": @"My App", @"components": components };
    
    completion(appDescDict, nil);
}

@end
*/