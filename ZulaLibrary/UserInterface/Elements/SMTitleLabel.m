//
//  SMTitleLabel.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 3/15/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMTitleLabel.h"

@implementation SMTitleLabel

- (void)appearanceForFontSize:(NSString *)fontSize fontFamily:(NSString *)fontFamily
{
    // default value
    if (!fontSize) {
        fontSize = @"16";
    }
    if (!fontFamily) {
        fontFamily = @"Helvetica-Bold";
    }
    
    NSInteger fontSizeInteger = [fontSize integerValue];
    [self setFont:[UIFont fontWithName:fontFamily size:fontSizeInteger]];
}

@end
