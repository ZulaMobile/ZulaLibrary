//
//  SMAppearanceDescription.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppearanceDescription.h"
#import "SMAppearance.h"

@implementation SMAppearanceDescription
{
    NSArray *_components;
}

- (id)initWithComponents:(NSArray *)components
{
    self = [super init];
    if (self) {
        _components = components;
    }
    return self;
}

- (SMAppearance *)appearanceForComponentSlug:(NSString *)slug
{
    for (NSDictionary *componentDict in _components) {
        NSString *componentSlug = (NSString *)[componentDict objectForKey:@"slug"];
        if ([componentSlug isEqualToString:slug]) {
            NSDictionary *componentAppearances = (NSDictionary *)[componentDict objectForKey:@"appearance"];
            return [[SMAppearance alloc] initWithAppearanceData:componentAppearances];
        }
    }
    return nil;
}


@end
