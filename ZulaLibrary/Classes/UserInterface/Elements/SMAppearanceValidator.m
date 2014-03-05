//
//  SMAppearanceValidator.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 3/13/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppearanceValidator.h"

@implementation SMAppearanceValidator

+ (BOOL)isValidData:(id)data
{
    if (![data isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    return YES;
}

@end
