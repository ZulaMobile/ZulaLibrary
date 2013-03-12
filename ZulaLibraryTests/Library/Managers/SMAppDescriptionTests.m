//
//  SMAppDescriptionTests.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppDescriptionTests.h"
#import "SMComponentDescription.h"
#import "SMNavigationDescription.h"

@implementation SMAppDescriptionTests
{
    NSDictionary *appData;
}

- (void)setUp
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:@"App Title" forKey:@"title"];
    
    //
    // set main appearances
    //
    NSDictionary *mainAppearances = [NSDictionary dictionaryWithObjectsAndKeys:@"333333", @"bg_color", nil];
    [data setValue:mainAppearances forKey:@"appearance"];
    
    //
    // Set components
    //
    NSMutableArray *components = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *homepageApp = [[NSMutableDictionary alloc] init];
    [homepageApp setValue:@"HomePage" forKey:@"type"];
    [homepageApp setValue:@"Home Page" forKey:@"title"];
    [homepageApp setValue:@"home_page" forKey:@"slug"];
    [homepageApp setValue:[NSDictionary dictionaryWithObjectsAndKeys:
                           [NSDictionary dictionaryWithObjectsAndKeys:@"top center", @"align", nil], @"logo", nil]
                   forKey:@"appearance"];
    
    NSMutableDictionary *contentPage = [[NSMutableDictionary alloc] init];
    [contentPage setValue:@"Content" forKey:@"type"];
    [contentPage setValue:@"About Us" forKey:@"title"];
    [contentPage setValue:@"about_us" forKey:@"slug"];
    [contentPage setValue:[NSDictionary dictionaryWithObjectsAndKeys:
                           [NSDictionary dictionaryWithObjectsAndKeys:@"center", @"alignment", nil], @"image",
                           [NSDictionary dictionaryWithObjectsAndKeys:@"13", @"font-size", @"#ff0000", @"color", nil], @"title",
                           nil]
                   forKey:@"appearance"];
    
    [components addObject:homepageApp];
    [components addObject:contentPage];
    
    [data setValue:components forKey:@"components"];
    
    //
    // Set navigation
    //
    NSArray *navComponents = [NSArray arrayWithObjects:@"home_page", @"about_us", nil];
    NSDictionary *navigatorAppearance = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"tabbar", @"type",
                                         @"glymps", @"iconset",
                                         @"#ff0000", @"bg-color",
                                         nil];
    NSDictionary *navBarAppearance = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"glymps", @"iconset",
                                         @"#ff0000", @"bg-color",
                                         nil];
    NSDictionary *navAppearance = [NSDictionary dictionaryWithObjectsAndKeys:
                                    navigatorAppearance, @"navigator",
                                    navBarAppearance, @"navbar",
                                   nil];
    [data setValue:[NSDictionary dictionaryWithObjectsAndKeys:navComponents, @"components", navAppearance, @"appearance", nil]
            forKey:@"navigation"];
    
    appData = [NSDictionary dictionaryWithDictionary:data];
}

- (void)testUsage
{
    
    // reach the description instance with a singleton object
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    
    // set the mock data source
    [appDescription setDataSource:self];
    
    // fetch descriptions
    [appDescription fetchAndSaveAppDescriptionWithCompletion:^(NSError *error) {
        // fetched
    }];
    
    // get components
    NSArray *components = [appDescription componentDescriptions];
    STAssertTrue(2 == [components count], @"component sizes are not equal 2 != %d", [components count]);
    
    SMComponentDescription *homePageComponent = [components objectAtIndex:0];
    STAssertTrue([homePageComponent isKindOfClass:[SMComponentDescription class]], @"component type mismatch");
    STAssertEquals(homePageComponent.title, @"Home Page", @"component title is not correct");
    STAssertEquals(homePageComponent.slug, @"home_page", @"component slug is not correct");
    STAssertEquals(homePageComponent.type, @"HomePage", @"component type is not correct");
    STAssertNotNil(homePageComponent.appearance, @"appearance should not be nil");
    STAssertTrue([homePageComponent.appearance isKindOfClass:[NSDictionary class]], @"appearance must be a distionary");
    
    // get component info
    SMComponentDescription *aboutUsComponent = [appDescription componentDescriptionWithSlug:@"about_us"];
    SMComponentDescription *aboutUsComponent2 = [components objectAtIndex:1];
    STAssertEquals(aboutUsComponent, aboutUsComponent2, @"must be same object");
    
    STAssertTrue([aboutUsComponent isKindOfClass:[SMComponentDescription class]], @"component type mismatch");
    STAssertEquals(aboutUsComponent.title, @"About Us", @"component title is not correct");
    STAssertEquals(aboutUsComponent.slug, @"about_us", @"component slug is not correct");
    STAssertEquals(aboutUsComponent.type, @"Content", @"component type is not correct");
    STAssertNotNil(aboutUsComponent.appearance, @"appearance should not be nil");
    STAssertTrue([aboutUsComponent.appearance isKindOfClass:[NSDictionary class]], @"appearance must be a distionary");
    
    // fetching appearance data
    NSDictionary *title = [aboutUsComponent.appearance objectForKey:@"title"];
    NSString *titleColor = [title objectForKey:@"color"];
    STAssertTrue([titleColor isEqualToString:@"#ff0000"], @"title color cannot be fetched");
    
    SMNavigationDescription *navDesc = appDescription.navigationDescription;
    STAssertTrue([navDesc.componentSlugs isKindOfClass:[NSArray class]], @"navigation components");
    //STAssertTrue([navDesc.appearance isKindOfClass:[NSDictionary class]], @"navigation appearance");
    
    NSString *homepage = [navDesc.componentSlugs objectAtIndex:0];
    STAssertTrue([homepage isEqualToString:@"home_page"], @"home page");
    NSString *aboutus = [navDesc.componentSlugs objectAtIndex:1];
    STAssertTrue([aboutus isEqualToString:@"about_us"], @"about us");
    
    NSDictionary *appAppearance = [appDescription appearance];
    STAssertNotNil(appAppearance, @"app appearance must not be nil");
}

#pragma mark - app description data source

- (void)fetchAppDescriptionWithCompletion:(void (^)(NSDictionary *, NSError *))completion
{
    completion(appData, nil);
}


@end
