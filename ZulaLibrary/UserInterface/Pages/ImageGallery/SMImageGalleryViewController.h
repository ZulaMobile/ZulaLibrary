//
//  SMImageGalleryViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"
#import "MWPhotoBrowser.h"

/**
 Photo Gallery Component. 
 All photos are displayed as grid. When one photo is selected, the fullscreen
 Image gallery starts.
 */
@interface SMImageGalleryViewController : SMBaseComponentViewController <MWPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *photoUrls;

/**
 The array of `MWPhoto` objects.
 */
@property (nonatomic, strong) NSMutableArray *photos;

@end
