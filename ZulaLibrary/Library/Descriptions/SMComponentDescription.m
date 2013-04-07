//
//  SMComponentDescription.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMComponentDescription.h"
#import "SMAppDescription.h"
#import "NSDictionary+SMAdditions.h"

@implementation SMComponentDescription

@synthesize type = _type;
@synthesize title = _title;
@synthesize slug = _slug;
@synthesize url = _url;
@synthesize appearance = _apperance;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _type = [attributes objectForKey:@"type"];
        _title = [attributes objectForKey:@"title"];
        _slug = [attributes objectForKey:@"slug"];
        _url = [attributes objectForKey:@"url"];
        
        // merge with app wide apperances
        NSDictionary *appAppearances = [[SMAppDescription sharedInstance] appearance];
        _apperance = [NSDictionary dictionaryByMerging:appAppearances
                                                  with:[attributes objectForKey:@"appearance"]];
    }
    return self;
}

@end
