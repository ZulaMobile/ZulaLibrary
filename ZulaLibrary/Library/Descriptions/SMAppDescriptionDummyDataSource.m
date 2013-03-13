//
//  SMAppDescriptionDummyDataSource.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 3/13/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppDescriptionDummyDataSource.h"

@implementation SMAppDescriptionDummyDataSource

- (void)fetchAppDescriptionWithCompletion:(void (^)(NSDictionary *, NSError *))completion
{
    // @todo: validation of data
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:@"App Title" forKey:@"title"];
    
    //
    // set main appearances
    //
    NSDictionary *navigatorAppearance = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"glymps", @"iconset",
                                         @"#ff0000", @"bg_color",
                                         nil];
    NSDictionary *navBarAppearance = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"glymps", @"iconset",
                                      @"#ff0000", @"bg_color",
                                      @"ffff00", @"tint_color",
                                      nil];
    
    NSDictionary *mainAppearances = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"ff0000", @"bg_color",
                                     @"white", @"scroll_color",
                                     [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"aspect_fill", @"alignment",
                                      @"http://www.emobilez.com/wallpapers/data/media/298/nuclear_iphone_wallpapers.jpg", @"url",
                                      nil], @"bg_image",
                                     navigatorAppearance, @"navigator",
                                     navBarAppearance, @"navbar",
                                     @"0", @"display_navbar",
                                     nil];
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
                           
                           [NSDictionary dictionaryWithObjectsAndKeys:@"aspect_fill", @"alignment", nil], @"image",
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"20", @"font_size",
                            @"GillSans-Bold", @"font_family",
                            @"F6FFA6", @"color",
                            @"clean", @"bg_color",
                            @"center", @"alignment", nil], @"title",
                           //[NSDictionary dictionaryWithObjectsAndKeys:@"13", @"font_size", @"dddddd", @"color", nil], @"text",
                           nil]
                   forKey:@"appearance"];
    
    
    NSMutableDictionary *companyPage = [[NSMutableDictionary alloc] init];
    [companyPage setValue:@"Content" forKey:@"type"];
    [companyPage setValue:@"Company" forKey:@"title"];
    [companyPage setValue:@"company" forKey:@"slug"];
    [companyPage setValue:[NSDictionary dictionaryWithObjectsAndKeys:
                           
                           [NSDictionary dictionaryWithObjectsAndKeys:@"aspect_fill", @"alignment", nil], @"image",
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"20", @"font_size",
                            @"HenveticaBold", @"font_family",
                            @"FFFFFF", @"color",
                            @"0000FF", @"bg_color",
                            @"center", @"alignment", nil], @"title",
                           //[NSDictionary dictionaryWithObjectsAndKeys:@"13", @"font_size", @"dddddd", @"color", nil], @"text",
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"#ff00ff", @"bg-color", nil], @"navbar",
                           @"1", @"display_navbar",
                           nil]
                   forKey:@"appearance"];
    
    
    [components addObject:homepageApp];
    [components addObject:contentPage];
    [components addObject:companyPage];
    [components addObject:companyPage];
    [components addObject:companyPage];
    [components addObject:companyPage];
    [components addObject:companyPage];
    [components addObject:companyPage];
    [components addObject:companyPage];
    [components addObject:companyPage];
    [components addObject:companyPage];
    
    [data setValue:components forKey:@"components"];
    
    //
    // Set navigation
    //
    NSArray *navComponents = [NSArray arrayWithObjects:@"home_page", @"about_us", nil];
    
    [data setValue:[NSDictionary dictionaryWithObjectsAndKeys:
                    @"navbar", @"type",
                    navComponents, @"components", nil]
            forKey:@"navigation"];
    
    
    // delay execution
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (completion) {
            completion([NSDictionary dictionaryWithDictionary:data], nil);
        }
    });
    
}

@end
