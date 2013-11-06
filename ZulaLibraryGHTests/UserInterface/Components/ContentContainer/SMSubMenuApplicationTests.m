//
//  SMSubMenuApplicationTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//
#import <GHUnitIOS/GHUnit.h>
#import "SMSubMenuView.h"

@interface SMSubMenuApplicationTests : GHTestCase

@end

@implementation SMSubMenuApplicationTests

- (void)testAddingButtons
{
    float padding = 10.0;
    
    SMSubMenuView *submenu = [[SMSubMenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    [submenu addButtonWithTitle:@"my btn 1" tag:1];
    UIView *btn1 = [submenu buttonWithTag:1];
    GHAssertTrue([btn1 isKindOfClass:[UIButton class]], @"new item must be a button");
    
    CGSize btnTitleSize = [@"my btn 1" sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    GHAssertEquals(btnTitleSize.width + padding * 2, btn1.frame.size.width, @"the btn size needs to fit");
    GHAssertEquals(padding, btn1.frame.origin.x, @"btn x");
    
    // add another button
    [submenu addButtonWithTitle:@"my btn 2" tag:2];
    UIView *btn2 = [submenu buttonWithTag:2];
    GHAssertTrue([btn2 isKindOfClass:[UIButton class]], @"new item must be a button");
    
    CGSize btnTitleSize2 = [@"my btn 2" sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    GHAssertEquals(btnTitleSize2.width + padding * 2, btn2.frame.size.width, @"the btn size needs to fit");
    GHAssertEquals(btn1.frame.size.width + padding * 2 + padding, btn2.frame.origin.x, @"new buttons need to shift to the side");
}

- (void)testScrollViewContentFrameMustEnlargeByButtonFrames
{
    float padding = 10.0;
    SMSubMenuView *submenu = [[SMSubMenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [submenu addButtonWithTitle:@"my btn 1" tag:1];
    [submenu addButtonWithTitle:@"my btn 2" tag:2];
    [submenu addButtonWithTitle:@"my btn 3" tag:3];
    [submenu addButtonWithTitle:@"my btn 4" tag:4];
    
    UIView *btn1 = [submenu buttonWithTag:1];
    float expectedScrollContentWidth = (btn1.frame.size.width + padding * 2) * 4;
    GHAssertEquals(expectedScrollContentWidth, submenu.scrollView.contentSize.width, @"scroll view content size need to enlarge by the addedbuttons");
}

@end
