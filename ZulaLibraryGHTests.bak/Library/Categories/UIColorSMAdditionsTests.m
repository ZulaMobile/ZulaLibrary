//
//  UIColorSMAdditionsTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "UIColor+ZulaAdditions.h"

@interface UIColorSMAdditionsTests : GHTestCase

@end

@implementation UIColorSMAdditionsTests

- (void)testIsBright
{
    UIColor *white = [UIColor whiteColor];
    GHAssertTrue([white isBright], @"");
    
    UIColor *yellow = [UIColor yellowColor];
    GHAssertTrue([yellow isBright], @"");
    
    UIColor *black = [UIColor blackColor];
    GHAssertFalse([black isBright], @"");
    
    UIColor *darkGray = [UIColor darkGrayColor];
    GHAssertFalse([darkGray isBright], @"");
    
}

- (void)testIsDark
{
    UIColor *white = [UIColor whiteColor];
    GHAssertFalse([white isDark], @"");
    
    UIColor *yellow = [UIColor yellowColor];
    GHAssertFalse([yellow isDark], @"");
    
    UIColor *black = [UIColor blackColor];
    GHAssertTrue([black isDark], @"");
    
    UIColor *darkGray = [UIColor darkGrayColor];
    GHAssertTrue([darkGray isDark], @"");
}

- (void)testsIsWhite
{
    UIColor *white = [UIColor whiteColor];
    
    GHAssertTrue([white isWhite], @"");
    
    UIColor *black = [UIColor blackColor];
    GHAssertFalse([black isWhite], @"");
    
    UIColor *yellow = [UIColor yellowColor];
    GHAssertFalse([yellow isWhite], @"");
}

- (void)testsIsBlack
{
    UIColor *black = [UIColor blackColor];
    GHAssertTrue([black isBlack], @"");
    
    UIColor *white = [UIColor whiteColor];
    GHAssertFalse([white isBlack], @"");
    
    UIColor *yellow = [UIColor yellowColor];
    GHAssertFalse([yellow isBlack], @"");
}

@end

