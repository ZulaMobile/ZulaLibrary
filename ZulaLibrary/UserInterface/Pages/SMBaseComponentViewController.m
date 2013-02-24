//
//  SMBaseComponentViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"
#import "SMComponentDescription.h"
#import "SMAppDescription.h"
#import "SMMainView.h"

@interface SMBaseComponentViewController ()

@end

@implementation SMBaseComponentViewController
@synthesize componentDesciption = _componentDesciption;

- (id)initWithDescription:(SMComponentDescription *)description
{
    self = [super init];
    if (self) {
        [self setComponentDesciption:description];
        
        // configure component
        [self setTitle:self.componentDesciption.title];
        
        // padding default value
        padding = 10.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // apply app wide appearaces
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    if ([self.view isKindOfClass:[SMMainView class]]) {
        [(SMMainView *)self.view applyAppearances:appDescription.appearance];
    }
}

@end
