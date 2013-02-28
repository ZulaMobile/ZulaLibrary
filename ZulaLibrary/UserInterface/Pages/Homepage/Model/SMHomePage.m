//
//  SMHomePage.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMHomePage.h"

@implementation SMHomePage
@synthesize logoUrl = _logoUrl;
@synthesize backgroundUrl = _backgroundUrl;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _logoUrl = [NSURL URLWithString:[attributes objectForKey:@"logo"]];
        _backgroundUrl = [NSURL URLWithString:[attributes objectForKey:@"bg_image"]];
    }
    return self;
}

+ (void)fetchWithCompletion:(void (^)(SMHomePage *, NSError *))completion
{
    SMHomePage *homepage = [[SMHomePage alloc] initWithAttributes:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"http://www.zula.com/images/zula_logo.png", @"logo",
                             @"", @"bg_image",
                             nil]];
    if (completion) {
        completion(homepage, nil);
    }
}

@end
