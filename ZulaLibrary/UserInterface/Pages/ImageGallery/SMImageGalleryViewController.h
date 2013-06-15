//
//  SMImageGalleryViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPullToRefreshComponentViewController.h"
#import "MWPhotoBrowser.h"

@class SMImageGallery;

/**
 Photo Gallery Component. 
 All photos are displayed as grid. When one photo is selected, the fullscreen
 Image gallery starts.
 */
@interface SMImageGalleryViewController : SMPullToRefreshComponentViewController <MWPhotoBrowserDelegate>

/**
 The model class that includes title, images, bg_image and navbar_image
 */
@property (nonatomic, strong) SMImageGallery *imageGallery;

/**
 The array of `MWPhoto` objects.
 */
@property (nonatomic, strong) NSMutableArray *photos;

@end
