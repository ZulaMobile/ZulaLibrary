//
//  SMAppDescription.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppDescription.h"
#import "SMComponentDescription.h"
#import "SMNavigationDescription.h"

#define kDefaultsKeyAppDescription @"app_description"

@implementation SMAppDescription
@synthesize components = _components;
@synthesize navigationDescription = _navigationDescription;
@synthesize appTitle = _appTitle;
@synthesize dataSource = _dataSource;

- (id)init
{
    self = [super init];
    if (self) {
        // set the default data source
        self.dataSource = self;
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

- (SMComponentDescription *)componentDescriptionWithSlug:(NSString *)slug
{
    for (SMComponentDescription *componentDesc in _components) {
        if ([componentDesc.slug isEqualToString:slug]) {
            return componentDesc;
        }
    }
    return nil;
}

- (void)fetchAndSaveAppDescriptionWithCompletion:(void (^)(NSError *))completion
{
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
        //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //[defaults setObject:response forKey:kDefaultsKeyAppDescription];
        //[defaults synchronize];
        
        // create components
        NSArray *componentDatas = (NSArray *)[response objectForKey:@"components"];
        NSMutableArray *tmpComponents = [[NSMutableArray alloc] initWithCapacity:[componentDatas count]];
        for (NSDictionary *componentData in componentDatas) {
            SMComponentDescription *component = [[SMComponentDescription alloc] init];
            [component setType:[componentData objectForKey:@"type"]];
            [component setTitle:[componentData objectForKey:@"title"]];
            [component setSlug:[componentData objectForKey:@"slug"]];
            [component setAppearance:[componentData objectForKey:@"appearance"]];
            [tmpComponents addObject:component];
        }
        _components = [NSArray arrayWithArray:tmpComponents];
        
        // create navigation instance
        NSDictionary *navData = [response objectForKey:@"navigation"];
        _navigationDescription = [[SMNavigationDescription alloc] init];
        [_navigationDescription setComponentSlugs:[navData objectForKey:@"components"]];
        [_navigationDescription setAppearance:[navData objectForKey:@"appearance"]];
        
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
    if (completion) {
        completion(nil, nil);
    }
}

@end
