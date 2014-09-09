//
//  SMVideoGalleryViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/29/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"

@class SMVideoGallery;

@interface SMVideoGalleryViewController : SMBaseComponentViewController <UITableViewDataSource, UITableViewDelegate>

/**
 Table view to list all the videos
 */
@property (nonatomic, strong) UITableView *tableView;


@end
