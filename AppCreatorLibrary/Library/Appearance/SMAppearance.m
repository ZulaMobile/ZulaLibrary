//
//  SMAppearance.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/6/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppearance.h"

@implementation SMAppearance

- (id)initWithAppearanceData:(NSDictionary *)theAppearanceData
{
    self = [super init];
    if (self) {
        appearanceData = theAppearanceData;
    }
    return self;
}

- (NSString *)stringForElement:(NSString *)element key:(NSString *)key
{
    NSDictionary *attributes = (NSDictionary *)[appearanceData objectForKey:element];
    if (!attributes) {
        return nil;
    }
    return [attributes objectForKey:key];
}

- (BOOL)boolForElement:(NSString *)element key:(NSString *)key
{
    NSDictionary *attributes = (NSDictionary *)[appearanceData objectForKey:element];
    if (!attributes) {
        return NO;
    }
    return [[attributes objectForKey:key] boolValue];
}

- (NSInteger)integerForElement:(NSString *)element key:(NSString *)key
{
    NSDictionary *attributes = (NSDictionary *)[appearanceData objectForKey:element];
    if (!attributes) {
        return NO;
    }
    return [[attributes objectForKey:key] integerValue];
}

@end
