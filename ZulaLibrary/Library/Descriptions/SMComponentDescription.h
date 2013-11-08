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
@property (nonatomic, readonly) NSString *url DEPRECATED_ATTRIBUTE;

/**
 *  Contents attribute. 
 *  This attribute can hold two structures:
 *    1. An absolute URL, which points out to the contents of the description (a web service)
 *    2. A dictionary of contents
 *
 *  In the 1st case, the model must download contents from the given url. 
 *  The second case is assigning the contents directly from the dictionary.
 *
 *  You can use `hasDownloadableContents` message to test if the contents is url or not.
 */
@property (nonatomic, readonly) id contents;

/**
 Initializer method
 All properties must set using this initializer, since all of them are read-only
 */
- (id)initWithAttributes:(NSDictionary *)attributes;

/**
 *  Determines if the contents attribute is a url and model must download contents.
 *  If it returns NO, you can use the contents directly.
 *
 *  @return BOOL
 */
- (BOOL)hasDownloadableContents;

@end
