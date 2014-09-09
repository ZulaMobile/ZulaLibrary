//
//  SMTabularListStrategy.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMTabularListStrategy.h"
#import "ZulaLibrary.h"

#import "UIColor+ZulaAdditions.h"
#import "UIViewController+SMAdditions.h"
#import "UIImageView+WebCache.h"

#import "SMComponentFactory.h"
#import "SMAppDescription.h"
#import "SMComponentDescription.h"
#import "SMContentViewController.h"
#import "SMListPage.h"
#import "SMListItem.h"
#import "SMContentPage.h"
#import "SMListCell.h"
#import "SMMultipleImageView.h"
#import "SMImageView.h"
#import "SMPullToRefreshFactory.h"
#import "SDImageCache.h"




@implementation SMTabularListStrategy
@synthesize controller;

- (id)initWithListViewController:(SMListViewController *)aListViewController
{
    self = [super init];
    if (self) {
        self.controller = aListViewController;
    }
    return self;
}

- (void)setup
{
    // screen size
    CGRect fullSize ;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        fullSize = CGRectMake(0, 0,
                              CGRectGetWidth(self.controller.view.frame),
                              CGRectGetHeight(self.controller.view.frame));
    } else {
        fullSize = CGRectMake(0, 0,
                              CGRectGetWidth(self.controller.view.frame),
                              CGRectGetHeight(self.controller.view.frame) - CGRectGetHeight(self.controller.navigationController.navigationBar.frame));
    }
    
    // create table view
    self.tableView = [[UITableView alloc] initWithFrame:fullSize style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // add views to main view
    [self.controller.view addSubview:self.tableView];
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    
    // ui changes
    if (listPage.backgroundUrl) {
        UIImageView *background = [[UIImageView alloc] init];
        [background sd_setImageWithURL:listPage.backgroundUrl];
        [self.tableView setBackgroundView:background];
    }
    
    [self.tableView reloadData];
}


#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    if ([[listPage images] count] > 0)
        return [listPage.items count] + 1;
    
    return [listPage.items count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    // we don't support multiple sections.
    return 1;
}

- (UITableViewCell *)cellForImageInTableView:(UITableView *)aTableView
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    static NSString* CellIdentifier = @"ListImageReuseIdentifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SMListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        self.controller.images = [[SMMultipleImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.controller.view.frame), 160)];
        [cell.contentView addSubview:self.controller.images];
    }
    
    [self.controller.images addImagesWithArray:listPage.images];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    NSInteger row = [indexPath row];
    if ([[listPage images] count] > 0) {
        if ([indexPath row] == 0) {
            return [self cellForImageInTableView:aTableView];
        }
        row -= 1;
    }
    
    static NSString* CellIdentifier = @"ListViewReuseIdentifier";
    
    SMListCell* cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SMListItem *item = [listPage.items objectAtIndex:row];
    
    if (cell == nil) {
        cell = [[SMListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // customize the cell
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // background image if exists
        if (listPage.itemBackgroundUrl) {
            SMImageView *itemBackground = [[SMImageView alloc] init];
            [itemBackground setImageWithURL:listPage.itemBackgroundUrl];
            [cell setBackgroundView:itemBackground];
        }
        
        // table item appearances
        [cell applyAppearances:[self.controller.componentDesciption.appearance objectForKey:@"item_bg_image"]];
        
        // accessory indicator
        if ([item hasDefaultTargetComponent] || [item hasCustomTargetComponent]) {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
    }
    
    // customize the cell data
    [cell.textLabel setText:item.title];
    [cell.detailTextLabel setText:item.subtitle];
    
    // left image if exists
    if (item.thumbnailUrl) {
        SMImageView *cellImage = [[SMImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
        [cellImage sd_setImageWithURL:item.thumbnailUrl
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                // move text label and title to the side
                                CGRect textLabelFrame = cell.textLabel.frame;
                                textLabelFrame.origin.x += 5;
                                textLabelFrame.size.width -= 20;
                                [cell.textLabel setFrame:textLabelFrame];
                                
                                CGRect textDetailFrame = cell.detailTextLabel.frame;
                                textDetailFrame.origin.x += 5;
                                textDetailFrame.size.width -= 20;
                                [cell.detailTextLabel setFrame:textDetailFrame];
                            }];
        
        [cellImage setContentMode:UIViewContentModeScaleAspectFill];
        [cellImage setClipsToBounds:YES];
        [cellImage setTag:31];
        [cellImage addFrame];
        
        // add borders
        //UIColor *bgColor = [cell backgroundColor];
        //[cellImage.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        //[cellImage.layer setBorderWidth:0.5];
        
        
        [cell.contentView addSubview:cellImage];
        
        
    }
    
    return cell;
}

#pragma mark - table view delegate

// display the detail row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    
    NSInteger row = [indexPath row];
    if ([[listPage images] count] > 0) {
        if ([indexPath row] == 0) {
            return;
        }
        row -= 1;
    }
    
    SMListItem *listItem = (SMListItem *)[listPage.items objectAtIndex:row];
    SMBaseComponentViewController *ctrl = [self.controller targetComponentByListItem:listItem];
    
    // make delegate know about the navigation
    if (ctrl && [self.controller.componentNavigationDelegate respondsToSelector:@selector(component:willShowViewController:animated:)]) {
        [self.controller.componentNavigationDelegate component:self.controller willShowViewController:ctrl animated:YES];
    }
    
    // display this page now
    if (self.controller.navigationController && ctrl) {
        [self.controller.navigationController pushViewController:ctrl animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    if ([[listPage images] count] > 0 && [indexPath row] == 0)
        return 160.0;
    
    return 80.0;
}

@end
