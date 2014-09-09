//
//  SMAppDescriptionDataSource.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppDescriptionBaseDataSource.h"

@implementation SMAppDescriptionBaseDataSource

+ (BOOL)isValidData:(id)data
{
    if (![data isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    // check if root level attributes are exists
    if (![data objectForKey:@"title"] || ![data objectForKey:@"navigation"] || ![data objectForKey:@"appearance"] || ![data objectForKey:@"components"]) {
        return NO;
    }
    
    // check if root level attributes are in correct type
    if (![[data objectForKey:@"title"] isKindOfClass:[NSString class]] ||
        ![[data objectForKey:@"navigation"] isKindOfClass:[NSDictionary class]] ||
        ![[data objectForKey:@"appearance"] isKindOfClass:[NSDictionary class]] ||
        ![[data objectForKey:@"components"] isKindOfClass:[NSArray class]]) {
        NSLog(@"App description: title, navigation, appearance or components are missing.");
        return NO;
    }
    
    // check if navigation type exists
    if (![[data objectForKey:@"navigation"] objectForKey:@"type"]) {
        NSLog(@"App description: navigation type is missing. %@", data);
        return NO;
    }
    
    return YES;
}

- (void)fetchAppDescriptionWithCompletion:(void (^)(NSDictionary *, NSError *))completion
{
    // must be implemented
}

@end
