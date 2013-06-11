//
//  SMListViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"

@class SMListPage, SMListItem, SMMultipleImageView;

/**
 List page corresponds to UITableViewController.
 */
@interface SMListViewController : SMBaseComponentViewController <UITableViewDataSource, UITableViewDelegate, SMComponentNavigationDelegate>

/**
 The model instance, it stores the items to display
 */
@property (nonatomic, strong) SMListPage *listPage;

/**
 Table view 
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 Swipable image gallery
 */
@property (nonatomic, strong) SMMultipleImageView *images;

/**
 Returns the component from the data on the `listItem`.
 If `target_component` data is set on the `listItem`, creates the component, sets its description objects and return it
 If no `target_component` set, Creates a `ContentComponent` and use the data on `listitem`.
 */
- (SMBaseComponentViewController *)targetComponentByListItem:(SMListItem *)listItem;

@end
