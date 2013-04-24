//
//  SMListViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"

@class SMListPage;

/**
 List page corresponds to UITableViewController.
 */
@interface SMListViewController : SMBaseComponentViewController <UITableViewDataSource, UITableViewDelegate>

/**
 The model instance, it stores the items to display
 */
@property (nonatomic, strong) SMListPage *listPage;

/**
 Table view 
 */
@property (nonatomic, strong) UITableView *tableView;

@end
