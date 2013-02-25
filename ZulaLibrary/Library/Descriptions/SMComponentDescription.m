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
{
    NSDictionary *_apperance;
}
@synthesize type = _type;
@synthesize title = _title;
@synthesize slug = _slug;

- (NSDictionary *)appearance
{
    return _apperance;
}

- (void)setAppearance:(NSDictionary *)appearance
{
    // merge with app wide apperances
    NSDictionary *appAppearances = [[SMAppDescription sharedInstance] appearance];
    _apperance = [NSDictionary dictionaryByMerging:appearance with:appAppearances];
}


@end
