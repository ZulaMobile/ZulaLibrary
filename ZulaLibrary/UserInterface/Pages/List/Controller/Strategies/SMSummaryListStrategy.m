//
//  SMSummaryListStrategy.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMSummaryListStrategy.h"

@implementation SMSummaryListStrategy
@synthesize controller;

- (id)initWithListViewController:(SMListViewController *)aListViewController
{
    self = [super init];
    if (self) {
        self.controller = aListViewController;
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
