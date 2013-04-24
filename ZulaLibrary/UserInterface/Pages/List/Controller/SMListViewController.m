//
//  SMListViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListViewController.h"
#import "SMListPage.h"
#import "SMListItem.h"

@interface SMListViewController ()

@end

@implementation SMListViewController
@synthesize listPage, tableView;

- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    // screen size
    CGRect fullSize = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    // create table view
    self.tableView = [[UITableView alloc] initWithFrame:fullSize style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setAutoresizesSubviews:UIViewAutoresizingFlexibleAll];
    
    // add views to main view
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fetchContents];
}

- (void)fetchContents
{
    self.listPage = [[SMListPage alloc] initWithAttributes:
                     @{
                     @"title": @"My Cool List",
                     @"bg_image": @"",
                     @"item_bg_image": @"",
                     @"listing_style": @"table",
                     @"items": @[
                     @{@"title": @"My news item 1", @"subtitle": @"my news subtitle 1", @"image": @"", @"content": @"Lorem ipsum", @"target_component_url": @"", @"target_component_type": @""},
                     @{@"title": @"My news item 2", @"subtitle": @"my news subtitle 2", @"image": @"", @"content": @"Lorem ipsum", @"target_component_url": @"", @"target_component_type": @""},
                     @{@"title": @"My news item 3", @"subtitle": @"my news subtitle 3", @"image": @"", @"content": @"Lorem ipsum", @"target_component_url": @"", @"target_component_type": @""},
                     @{@"title": @"My news item 4", @"subtitle": @"my news subtitle 4", @"image": @"", @"content": @"Lorem ipsum", @"target_component_url": @"", @"target_component_type": @""},
                     ]
                     }];
    [self.tableView reloadData];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listPage.items count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    // we don't support multiple sections yet.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"ListViewReuseIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // customize the cell
    }
    
    // customize the cell data
    SMListItem *item = [self.listPage.items objectAtIndex:[indexPath row]];
    [cell.textLabel setText:item.title];
    [cell.detailTextLabel setText:item.subtitle];
    
    return cell;
}

#pragma mark - table view delegate

// display the detail row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // check if the item has custom component
    
    // if there is custom component, create the view controller
    // get view controller's appearances from main appearances
    
    
}

@end
