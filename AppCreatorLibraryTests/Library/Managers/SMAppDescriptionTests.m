//
//  SMAppDescriptionTests.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppDescriptionTests.h"
#import "SMAppearance.h"
#import "SMAppearanceDescription.h"

@implementation SMAppDescriptionTests

- (void)testUsage
{
    
    // reach the description instance with a singleton object
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    
    // fetch descriptions
    [appDescription fetchAndSaveAppDescriptionWithCompletion:^(NSError *error) {
        // fetched
    }];
    
    // get components
    NSArray *components = [appDescription components];
    STAssertEquals(2, [components count], @"component sizes are not equal");
    
    SMComponentDescription *homePageComponent = [components objectAtIndex:0];
    STAssertEquals(homePageComponent.title, @"Home Page", @"component title is not correct");
    STAssertEquals(homePageComponent.slug, @"home_page", @"component slug is not correct");
    STAssertEquals(homePageComponent.componentType, @"HomePage", @"component type is not correct");
    
    // get component info
    SMComponentDescription *aboutUsComponent = [appDescription componentDataWithSlug:@"about_us"];
    
    // shortcut method for appearance
    SMAppearance *aboutUsAppearance = [appDescription appearanceForComponentSlug:@"about_us"];
    
    STAssertEquals(aboutUsAppearance, aboutUsComponent.appearance, @"appearances should be equal");
    
    // fetching appearance data
    NSString *titleColor = [aboutUsAppearance stringForElement:@"title" key:@"color"];
    STAssertTrue([titleColor isEqualToString:@"#ff0000"], @"title color cannot be fetched");
    
    NSInteger titleFontSize = [aboutUsAppearance integerForElement:@"title" key:@"font-size"];
    STAssertEquals(titleFontSize, 13, @"title font size are not equal");
}

#pragma mark - app description data source

- (void)fetchAppDescriptionWithCompletion:(void (^)(NSDictionary *, NSError *))completion
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:@"App Title" forKey:@"title"];
    
    NSMutableArray *appearances = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *homepageApp = [[NSMutableDictionary alloc] init];
    [homepageApp setValue:@"HomePage" forKey:@"component"];
    [homepageApp setValue:@"Home Page" forKey:@"title"];
    [homepageApp setValue:@"home_page" forKey:@"slug"];
    [homepageApp setValue:[NSDictionary dictionaryWithObjectsAndKeys:
                           [NSDictionary dictionaryWithObjectsAndKeys:@"top center", @"align", nil], @"logo", nil]
                   forKey:@"appearance"];
    
    NSMutableDictionary *contentPage = [[NSMutableDictionary alloc] init];
    [contentPage setValue:@"ContentPage" forKey:@"component"];
    [contentPage setValue:@"About Us" forKey:@"title"];
    [contentPage setValue:@"about_us" forKey:@"slug"];
    [contentPage setValue:[NSDictionary dictionaryWithObjectsAndKeys:
                           [NSDictionary dictionaryWithObjectsAndKeys:@"center", @"alignment", nil], @"image",
                           [NSDictionary dictionaryWithObjectsAndKeys:@"13", @"font-size", @"#ff0000", @"color", nil], @"title",
                           nil]
                   forKey:@"appearance"];
    
    
    
    [appearances addObject:homepageApp];
    [appearances addObject:contentPage];
    
    [data setValue:appearances forKey:@"appearances"];
    
    if (completion) {
        completion(data, nil);
    }
}

@end
