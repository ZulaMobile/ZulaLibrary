//
//  SMListItem.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"

// data structure constants
#define kModelListItemTitle @"title"
#define kModelListItemSubtitle @"subtitle"
#define kModelListItemImageUrl @"image"
#define kModelListItemThumbnailUrl @"thumbnail"
#define kModelListItemContent @"content"
#define kModelListItemTargetComponent @"target_component"
#define kModelListItemTargetComponentName @"target_component_type"

@class SMComponentDescription;

/**
 Listing item for "List Page". Each item corresponds to a table item
 
 @see [[List Component]] wiki entry
 */
@interface SMListItem : SMModel

/**
 Header of the item.
 */
@property (nonatomic, strong) NSString *title;

/**
 Optional thumbnail image. If set, it will display on detail page.
 */
@property (nonatomic, readonly) NSURL *imageUrl;

/**
 Optional thumbnail image. If set, it will display on the left side of the item.
 */
@property (nonatomic, readonly) NSURL *thumbnailUrl;

/**
 Optional subtitle or short description under the header(title) text
 */
@property (nonatomic, readonly) NSString *subtitle;

/**
 Content text, if item has not got a target component, this text becomes the content 
 text for the detail page (which is a `ContentComponent`.
*/
@property (nonatomic, readonly) NSString *content;

/**
 Optional target component, it is the same structure with a component description.
 */
@property (nonatomic, readonly) SMComponentDescription *targetComponentDescription;

/**
 The name of the target component, if nil, the `ContentComponent` is created with `content` attribute
 */
@property (nonatomic, readonly) NSString *targetComponentName;

/**
 Returns YES if the target component is a custom component
 */
- (BOOL)hasCustomTargetComponent;

/**
 Returns YES if the target component is created using the content and imageUrl properties of this class
 The default component type is `ContentComponent`
 */
- (BOOL)hasDefaultTargetComponent;

@end
