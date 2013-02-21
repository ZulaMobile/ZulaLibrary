//
//  SMAppDescription.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppDescription.h"
#import "SMAppearanceDescription.h"

#define kDefaultsKeyAppDescription @"app_description"

@implementation SMAppDescription
@synthesize appearanceDescription = _appearanceDescription;
@synthesize navigationDescription = _navigationDescription;
@synthesize appTitle = _appTitle;
@synthesize dataSource = _dataSource;

- (id)init
{
    self = [super init];
    if (self) {
        // set the default data source
        self.dataSource = self;
        
        // get the cached data
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *cachedAppDescription = [defaults dictionaryForKey:kDefaultsKeyAppDescription];
        
        if (cachedAppDescription) {
            // create appearance instance
            NSArray *components = (NSArray *)[cachedAppDescription objectForKey:@"appearances"];
            _appearanceDescription = [[SMAppearanceDescription alloc] initWithComponents:components];
            
            // create navigation instance
#warning create navigation instance
        }
    }
    return self;
}

// singleton implementation
+ (SMAppDescription *)sharedInstance
{
    static SMAppDescription *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SMAppDescription alloc] init];
    });
    return _sharedInstance;
}

- (void)fetchAndSaveAppDescriptionWithCompletion:(void (^)(NSError *))completion
{
    // if data is already downloaded, skip the operation
    if (_appearanceDescription && _navigationDescription) {
        if (completion) {
            completion(nil);
        }
        return;
    }
    
    // fetch the data
    [self.dataSource fetchAppDescriptionWithCompletion:^(NSDictionary *response, NSError *error) {
        if (error) {
            // an error occurred
            if (completion) {
                completion(error);
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAppDescriptionFail
                                                                object:error];
            return;
        }
        
        // save the data
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:response forKey:kDefaultsKeyAppDescription];
        [defaults synchronize];
        
        // create appearance instance
        NSArray *components = (NSArray *)[response objectForKey:@"appearances"];
        _appearanceDescription = [[SMAppearanceDescription alloc] initWithComponents:components];
        
        // create navigation instance
        
        if (completion) {
            completion(nil);
        }
        
        // post the notification
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAppDescriptionDidFetch
                                                            object:self];
    }];
}

#pragma mark - data source

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
    
    
    
    //[appearances addObject:homepageApp];
    [appearances addObject:contentPage];
    
    [data setValue:appearances forKey:@"appearances"];
    
    if (completion) {
        completion(data, nil);
    }
}

@end
