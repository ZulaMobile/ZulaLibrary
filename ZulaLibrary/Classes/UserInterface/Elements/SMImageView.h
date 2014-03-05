//
//  SMImageView.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"

@protocol SMImageViewDelegate;

/**
 Standard image view
 
 Appearance options:
     * alignment: the content mode [center, left, right, aspect_fill, aspect_fit]. default is aspect_fill.
     * bg_color: hex code for rgb color (i.e. rrggbb).
     * url: background image set by user (warning: this only can be set by the app wide settings)
 */
@interface SMImageView : UIImageView <SMViewElement, UIWebViewDelegate>

@property (nonatomic, weak) id<SMImageViewDelegate> touchDelegate;

- (void)setImageWithUrlString:(NSString *)url;

- (void)setImageWithURL:(NSURL *)url;

- (void)setImageWithURL:(NSURL *)url activityIndicatorStyle:(UIActivityIndicatorViewStyle)style;

- (void)setImageWithProgressBarAndUrl:(NSURL *)url;

/**
 Adds a white frame around the image.
 */
- (void)addFrame;

@end

/**
 Image view delegate handles the image related events
 */
@protocol SMImageViewDelegate <NSObject>

@optional
- (void)imageDidTouch:(SMImageView *)image;
- (void)imageDidTouch:(SMImageView *)image inImages:(NSArray *)images;
@end
