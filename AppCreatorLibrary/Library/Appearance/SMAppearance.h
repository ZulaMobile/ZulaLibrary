//
//  SMAppearance.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/6/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMComponentAppearance.h"

@protocol SMAppearanceDataSource;

/**
 A Wrapper for appearance values.
 */
@interface SMAppearance : NSObject
{
    // private appearance data
    NSDictionary *appearanceData;
}

- (id)initWithAppearanceData:(NSDictionary *)appearanceData;

/**
 Returns the value if exists, otherwise nil
 
 @param Element the name of the element (i.e. title, text, image, etc.)
 @param Key the attribute name (i.e. font, color, font-size, etc.)
 */
- (NSString *)stringForElement:(NSString *)element key:(NSString *)key;

/**
 Returns the value if exists, otherwise nil
 
 @param Element the name of the element (i.e. title, text, image, etc.)
 @param Key the attribute name (i.e. font, color, font-size, etc.)
 */
- (BOOL)boolForElement:(NSString *)element key:(NSString *)key;

/**
 Returns the value if exists, otherwise nil
 
 @param Element the name of the element (i.e. title, text, image, etc.)
 @param Key the attribute name (i.e. font, color, font-size, etc.)
 */
- (NSInteger)integerForElement:(NSString *)element key:(NSString *)key;

@end


