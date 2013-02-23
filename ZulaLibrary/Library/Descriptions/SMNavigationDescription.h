//
//  SMNavigationDescription.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMNavigationDescription : NSObject

/**
 Collection of component slugs (NSString*) in order
 */
@property (nonatomic, strong) NSArray *componentSlugs;

/**
 Appearance data, Each value in the dictionary is another dictionary for the appearance tuple (key/value)
 @see 'App Description Service' wiki entry
 */
@property (nonatomic, strong) NSDictionary *appearance;

@end
