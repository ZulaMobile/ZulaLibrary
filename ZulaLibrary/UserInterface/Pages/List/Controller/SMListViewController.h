//
//  SMListViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPullToRefreshComponentViewController.h"
#import "SMPullToRefresh.h"

@protocol SMListViewStrategy;
@class SMListPage, SMListItem, SMMultipleImageView;

/**
 List page corresponds to UITableViewController.
 */
@interface SMListViewController : SMPullToRefreshComponentViewController <SMComponentNavigationDelegate>

/**
 The model instance, it stores the items to display
 */
@property (nonatomic, strong) SMListPage *listPage;

/**
 Swipable image gallery
 */
@property (nonatomic, strong) SMMultipleImageView *images;

/**
 *  The strategy will be responsible from the controller's behavior. 
 */
@property (nonatomic) id<SMListViewStrategy> strategy;

/**
 Returns the component from the data on the `listItem`.
 If `target_component` data is set on the `listItem`, creates the component, sets its description objects and return it
 If no `target_component` set, Creates a `ContentComponent` and use the data on `listitem`.
 */
- (SMBaseComponentViewController *)targetComponentByListItem:(SMListItem *)listItem;

@end

//

@protocol SMListViewStrategy <NSObject>

@property (nonatomic, weak) SMListViewController *controller;

- (id)initWithListViewController:(SMListViewController *)aListViewController;

/**
 *  Initial setup of the class. This is triggerrred before applyAppearances and after init
 */
- (void)setup;

/**
 *  The hook to apply necessary appearances
 */
- (void)applyAppearances:(NSDictionary *)appearances;

@end
