//
//  SMTabularListStrategy.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMListViewController.h"

@interface SMTabularListStrategy : NSObject <SMListViewStrategy, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
