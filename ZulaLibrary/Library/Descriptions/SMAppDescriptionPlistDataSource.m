//
//  SMAppDescriptionPlistDataSource.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppDescriptionPlistDataSource.h"

@implementation SMAppDescriptionPlistDataSource
@synthesize path;

- (id)initWithPath:(NSString *)aPath
{
    self = [super init];
    if (self) {
        self.path = aPath;
    }
    return self;
}

- (void)fetchAppDescriptionWithCompletion:(void (^)(NSDictionary *, NSError *))completion
{
    if (!self.path) {
        if (completion) completion(nil, [NSError errorWithDomain:@"zulamobile"
                                            code:500
                                        userInfo:@{@"description": @"No path found for app description"}]);
        return;
    }
    
    // read the plist file
    NSDictionary *contents = [[NSDictionary alloc] initWithContentsOfFile:self.path];
    
    // validate data
    if(![SMAppDescriptionPlistDataSource isValidData:contents]) {
        NSError *err = [[NSError alloc] initWithDomain:@"zulamobile"
                                                  code:500
                                              userInfo:@{@"description": @"Invalid response data"}];
        if (completion) completion(nil, err);
        
        return;
    }
    
    // return the data
    completion(contents, nil);
}

@end
