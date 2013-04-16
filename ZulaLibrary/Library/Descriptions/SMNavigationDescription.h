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
 The class type of the navigation component
 */
@property (nonatomic, strong) NSString *type;

/**
 The appearance dictionary for the navigation
 */
@property (nonatomic, readonly) NSDictionary *appearance;

/**
 Navigation Data, includes appearance and data
 */
@property (nonatomic, strong) NSDictionary *data;

@end
