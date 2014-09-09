//
//  SMImageComponentDelegate.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMImageComponentStrategy.h"
#import "SMBaseComponentViewController.h"

@implementation SMImageComponentStrategy
{
    NSArray *images;
}
@synthesize component;

- (id)initWithComponent:(SMBaseComponentViewController *)aComponent
{
    self = [super init];
    if (self) {
        self.component = aComponent;
    }
    return self;
}

#pragma mark - image view delegate

- (void)imageDidTouch:(SMImageView *)image
{
    // @TODO
}

@end
