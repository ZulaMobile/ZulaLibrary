//
//  SMNavigationDescription.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMNavigationDescription.h"

@implementation SMNavigationDescription
@synthesize  componentSlugs = _componentSlugs;
@synthesize type = _type;
@synthesize data = _data;

- (NSDictionary *)appearance
{
    return [self.data objectForKey:@"appearance"];
}

@end
