//
//  SMMultipleImageView.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/30/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"

/**
 Can display multiple `SMImageView` by swiping them. Same appearances for `SMImageView` applies here.
 
 Appearance options:
     * alignment: the content mode [center, left, right, aspect_fill, aspect_fit]. default is aspect_fill.
     * bg_color: hex code for rgb color (i.e. rrggbb).
     * url: background image set by user (warning: this only can be set by the app wide settings)
 */
@interface SMMultipleImageView : UIView <SMViewElement, UIScrollViewDelegate>

/**
 Removes the current images and adds the images in the array.
 Array can have either image url (NSURL *) or image views (UIImageView *)
 */
- (void)addImagesWithArray:(NSArray *)imageArray;

/**
 Pushes the image view at the end of the list
 */
- (void)pushImageView:(UIImageView *)imageView;

/**
 Creates an image view from the url and pushes image to the end of the image list
 */
- (void)pushImageUrl:(NSURL *)imageUrl;

@end
