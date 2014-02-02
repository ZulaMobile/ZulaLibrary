//
//  SMSummaryListStrategy.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMSummaryListStrategy.h"

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
#import "SMMultipleImageView.h"
#import "SMImageView.h"
#import "SMPullToRefreshFactory.h"
#import "SDImageCache.h"
#import "SMSummaryCell.h"

//#import "UIIm"


static NSString* CellIdentifier = @"SummaryListImageReuseIdentifier";

@implementation SMSummaryListStrategy
@synthesize controller;

- (void)setup
{
    [super setup];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    SMListItem *item = [listPage.items objectAtIndex:[indexPath row]];
    if (item.thumbnailUrl) {
        return 180.0f + 30.0f + 20.0f;
    } else {
        return 100.0f + 30.0f + 20.0f;
    }
}

- (UITableViewCell *)cellForImageInTableView:(UITableView *)aTableView
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SMSummaryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
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
    
    SMSummaryCell* cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SMListItem *item = [listPage.items objectAtIndex:row];
    
    if (cell == nil) {
        cell = [[SMSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
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
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    // customize the cell data
    [cell.title setText:item.title];
    [cell.summary setText:item.subtitle];
    
    // left image if exists
    if (item.thumbnailUrl) {
        // add borders
        //UIColor *bgColor = [cell backgroundColor];
        //[cellImage.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        //[cellImage.layer setBorderWidth:0.5];
        
        [cell.image setImageWithURL:item.thumbnailUrl];
        [cell activateDisplayImageView];
    } else {
        cell.image = nil;
        [cell activateNoImageView];
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

@end
