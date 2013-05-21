//
//  SMSubMenuViewTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/20/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMSubMenuViewTests.h"
#import "SMSubMenuView.h"

@implementation SMSubMenuViewTests

- (void)testAddingButtons
{
    float padding = 10.0;
    
    SMSubMenuView *submenu = [[SMSubMenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    [submenu addButtonWithTitle:@"my btn 1" tag:1];
    UIView *btn1 = [submenu buttonWithTag:1];
    STAssertTrue([btn1 isKindOfClass:[UIButton class]], @"new item must be a button");
    
    CGSize btnTitleSize = CGSizeMake(58.0, 50);// [@"my btn 1" sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14]];
    STAssertEquals(btnTitleSize.width + padding * 2, btn1.frame.size.width, @"the btn size needs to fit");
    STAssertEquals(padding, btn1.frame.origin.x, @"btn x");
    
    // add another button
    [submenu addButtonWithTitle:@"my btn 2" tag:2];
    UIView *btn2 = [submenu buttonWithTag:2];
    STAssertTrue([btn2 isKindOfClass:[UIButton class]], @"new item must be a button");
    
    CGSize btnTitleSize2 = CGSizeMake(58.0, 50); //[@"my btn 2" sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14]];
    STAssertEquals(btnTitleSize2.width + padding * 2, btn2.frame.size.width, @"the btn size needs to fit");
    STAssertEquals(btn1.frame.size.width + padding * 2, btn2.frame.origin.x, @"new buttons need to shift to the side");
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
    STAssertEquals(expectedScrollContentWidth, submenu.scrollView.contentSize.width, @"scroll view content size need to enlarge by the addedbuttons");
}

- (void)testHittestOfButtons
{
    
}

@end
