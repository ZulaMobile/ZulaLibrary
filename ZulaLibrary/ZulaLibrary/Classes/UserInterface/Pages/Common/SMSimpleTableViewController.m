//
//  SMPopOverViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 08/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMSimpleTableViewController.h"

@interface SMSimpleTableViewController ()

@property (nonatomic, strong) SMArrayDataSource *dataSource;

@end

static NSString *CellIdentifier = @"PopOverCellIdentifier";

@implementation SMSimpleTableViewController
@synthesize tableView, activityIndicator, dataSource;

- (id)initWithCellConfigureBlock:(TableViewCellConfigureBlock)block
              itemDidSelectBlock:(ItemDidSelectBlock)anItemDidSelectBlock
{
    self = [super init];
    if (self) {
        self.dataSource = [[SMArrayDataSource alloc] initWithItems:@[]
                                                    cellIdentifier:CellIdentifier
                                                configureCellBlock:block
                                                itemDidSelectBlock:anItemDidSelectBlock];
    }
    return self;
}

- (void)loadView
{
    self.view = [UIView new];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // table view
    self.tableView = [[UITableView alloc]
                      initWithFrame:CGRectZero
                      style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    [self.tableView setHidden:YES];
    [self.view addSubview:self.tableView];
    
    // indicator
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicator];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    float edge = 40.0f;
    self.activityIndicator.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2 - edge / 2,
                                              CGRectGetWidth(self.view.frame) / 2 - edge / 2,
                                              edge, edge);
}

- (void)showItems:(NSArray *)items
{
    [self.activityIndicator stopAnimating];
    self.dataSource.items = items;
    [self.tableView setHidden:NO];
    [self.tableView reloadData];
}

@end
