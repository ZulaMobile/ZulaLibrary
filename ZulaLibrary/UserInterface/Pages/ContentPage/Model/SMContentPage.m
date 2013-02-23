//
//  SMContentPage.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContentPage.h"

@implementation SMContentPage
@synthesize title = _title;
@synthesize text = _text;
@synthesize imageUrl = _imageUrl;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        _title = [attributes objectForKey:kModelContentPageTitle];
        _text = [attributes objectForKey:kModelContentPageText];
        
        NSString *imageUrlString = [attributes objectForKey:kModelContentPageImageUrl];
        if (imageUrlString && ![imageUrlString isEqualToString:@""]) {
            _imageUrl = [NSURL URLWithString:imageUrlString];
        }
        
        NSString *backgroundImageUrlString = [attributes objectForKey:kModelContentPageBackgroundImageUrl];
        if (backgroundImageUrlString && ![backgroundImageUrlString isEqualToString:@""]) {
            _backgroundUrl = [NSURL URLWithString:backgroundImageUrlString];
        }
    }
    return self;
}

+ (NSString *)apiServiceName
{
    return @"";
}

@end
