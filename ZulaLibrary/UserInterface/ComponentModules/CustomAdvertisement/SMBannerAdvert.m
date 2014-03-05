//
//  SMBannerAdvert.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMBannerAdvert.h"

@implementation SMBannerAdvert

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self.contentType == SMAdvertTypeVideo) {
        return nil;
    }
    return self;
}

@end
