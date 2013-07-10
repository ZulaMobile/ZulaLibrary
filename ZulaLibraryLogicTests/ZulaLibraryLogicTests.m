//
//  ZulaLibraryLogicTests.m
//  ZulaLibraryLogicTests
//
//  Created by Suleyman Melikoglu on 5/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "ZulaLibraryLogicTests.h"
#import "SMSubMenuView.h"

@implementation ZulaLibraryLogicTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in ZulaLibraryLogicTests");
    
    SMSubMenuView *submenu = [[SMSubMenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 34)];
    STAssertTrue([submenu isKindOfClass:[SMSubMenuView class]], @"trivial");
}

@end
