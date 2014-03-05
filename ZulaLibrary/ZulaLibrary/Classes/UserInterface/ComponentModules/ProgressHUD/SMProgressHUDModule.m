//
//  SMProgressHUDModule.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMProgressHUDModule.h"
#import "SMProgressHUD.h"

@implementation SMProgressHUDModule
@synthesize component;

- (id)initWithComponent:(SMBaseComponentViewController *)aComponent
{
    self = [super init];
    if (self) {
        self.component = aComponent;
    }
    return self;
}

- (void)componentWillFetchContents
{
    [SMProgressHUD show];
}

- (void)componentDidFetchContent:(SMModel *)model
{
    [SMProgressHUD dismiss];
}

@end
