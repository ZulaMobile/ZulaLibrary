//
//  SMVideoGalleryViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/29/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPullToRefreshComponentViewController.h"

@class SMVideoGallery;

@interface SMVideoGalleryViewController : SMPullToRefreshComponentViewController <UITableViewDataSource, UITableViewDelegate>

/**
 The model instance, it stores the items to display
 */
@property (nonatomic, strong) SMVideoGallery *videoGallery;

/**
 Table view to list all the videos
 */
@property (nonatomic, strong) UITableView *tableView;


@end
