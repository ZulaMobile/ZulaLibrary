//
//  SMLinksTilesStrategy.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMLinksTilesStrategy.h"

@implementation SMLinksTilesStrategy
@synthesize links;

- (id)initWithLinks:(SMLinks *)aLinksObject
{
    self = [super init];
    if (self) {
        self.links = aLinksObject;
    }
    return self;
}

- (void)setup
{
    
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    
}

@end
