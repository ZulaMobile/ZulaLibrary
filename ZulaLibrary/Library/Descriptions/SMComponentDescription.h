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
@property (nonatomic, readonly) NSString *type;

/**
 The title set by user
 */
@property (nonatomic, readonly) NSString *title;

/**
 Unique identifier of the component instance
 Usually the slugified version of the title
 */
@property (nonatomic, readonly) NSString *slug;

/**
 Appearance dictionary
 Merged with the appDescription.appearance dictionary
 appApperances are overridden by the component appearances
 */
@property (nonatomic, readonly) NSDictionary *appearance;

/**
 Rest API URL
 To fetch the content data, components will use this url
 */
@property (nonatomic, readonly) NSString *url;

/**
 Initializer method
 All properties must set using this initializer, since all of them are read-only
 */
- (id)initWithAttributes:(NSDictionary *)attributes;

@end
