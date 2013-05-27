//
//  UIColorSMAdditionsTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/27/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "UIColorSMAdditionsTests.h"
#import "UIColor+ZulaAdditions.h"
#import "UIColor+SSToolkitAdditions.h"

@implementation UIColorSMAdditionsTests

- (void)testIsBright
{
    UIColor *white = [UIColor whiteColor];
    STAssertTrue([white isBright], @"");
    
    UIColor *yellow = [UIColor yellowColor];
    STAssertTrue([yellow isBright], @"");
    
    UIColor *black = [UIColor blackColor];
    STAssertFalse([black isBright], @"");
    
    UIColor *darkGray = [UIColor darkGrayColor];
    STAssertFalse([darkGray isBright], @"");
    
    UIColor *blueWithHex = [UIColor colorWithHex:@"27B3E6"];
    STAssertTrue([blueWithHex isBright], @"");
    
    blueWithHex = [UIColor colorWithHex:@"1F8DB5"];
    STAssertFalse([blueWithHex isBright], @"");
}

- (void)testIsDark
{
    UIColor *white = [UIColor whiteColor];
    STAssertFalse([white isDark], @"");
    
    UIColor *yellow = [UIColor yellowColor];
    STAssertFalse([yellow isDark], @"");
    
    UIColor *black = [UIColor blackColor];
    STAssertTrue([black isDark], @"");
    
    UIColor *darkGray = [UIColor darkGrayColor];
    STAssertTrue([darkGray isDark], @"");
}

- (void)testsIsWhite
{
    UIColor *white = [UIColor whiteColor];
    
    STAssertTrue([white isWhite], @"");
    
    UIColor *black = [UIColor blackColor];
    STAssertFalse([black isWhite], @"");
    
    UIColor *yellow = [UIColor yellowColor];
    STAssertFalse([yellow isWhite], @"");
}

- (void)testsIsBlack
{
    UIColor *black = [UIColor blackColor];
    STAssertTrue([black isBlack], @"");
    
    UIColor *white = [UIColor whiteColor];
    STAssertFalse([white isBlack], @"");
    
    UIColor *yellow = [UIColor yellowColor];
    STAssertFalse([yellow isBlack], @"");
}

@end
