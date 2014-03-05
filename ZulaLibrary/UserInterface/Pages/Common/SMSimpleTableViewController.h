//
//  SMPopOverViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 08/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMArrayDataSource.h"

/**
 *  A table view that displays any given text items
 *  A good place to use this table is to display content in a pop over controller
 */
@interface SMSimpleTableViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (id)initWithCellConfigureBlock:(TableViewCellConfigureBlock)block
              itemDidSelectBlock:(ItemDidSelectBlock)anItemDidSelectBlock;
- (void)showItems:(NSArray *)items;

@end
