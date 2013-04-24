//
//  SMListViewControllerTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListViewControllerTests.h"
#import "SMListViewController.h"
#import "SMComponentDescription.h"

@implementation SMListViewControllerTests
{
    SMComponentDescription *_componentDescription;
}

- (void)setUp
{
    _componentDescription = [[SMComponentDescription alloc] initWithAttributes:
                             @{
                             @"type": @"myvla",
                             @"title": @"My News",
                             @"slug": @"my-news",
                             @"url": @""
                             }];
}

- (void)testCreationOfComponent
{
    SMListViewController *ctrl = [[SMListViewController alloc] initWithDescription:_componentDescription];
    
}

@end
