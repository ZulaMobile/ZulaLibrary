//
//  SMAppDescription.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppDescription.h"

#define kDefaultsKeyAppDescription @"app_description"

@implementation SMAppDescription
@synthesize appearance = _appearance;
@synthesize navigation = _navigation;
@synthesize appTitle = _appTitle;
@synthesize dataSource = _dataSource;

- (id)init
{
    self = [super init];
    if (self) {
        // set the default data source
        
        // get the cached data
        
        // create appearance instance
        
        // create navigation instance
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
        
        // create navigation instance
        
        if (completion) {
            completion(nil);
        }
        
        // post the notification
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAppDescriptionDidFetch
                                                            object:self];
    }];
}

@end
