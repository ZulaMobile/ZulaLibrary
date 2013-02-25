//
//  SMComponentDescription.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Component Meta data and user set data
 */
@interface SMComponentDescription : NSObject

/**
 The type of the component corresponds to the class name of it.
 @example 'Content' corresponds to 'SMContentViewController'
 */
@property (nonatomic, strong) NSString *type;

/**
 The title set by user
 */
@property (nonatomic, strong) NSString *title;

/**
 Unique identifier of the component instance
 Usually the slugified version of the title
 */
@property (nonatomic, strong) NSString *slug;

/**
 Appearance dictionary
 Merged with the appDescription.appearance dictionary
 appApperances are overridden by the component appearances
 */
@property (nonatomic, strong) NSDictionary *appearance;

@end
