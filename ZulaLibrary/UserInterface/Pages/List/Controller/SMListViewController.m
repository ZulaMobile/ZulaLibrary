//
//  SMListViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "SMProgressHUD.h"

#import "UIColor+ZulaAdditions.h"
#import "UIViewController+SSToolkitAdditions.h"

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

@interface SMListViewController ()

@end

@implementation SMListViewController
@synthesize listPage, tableView, images;

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect fullSize = CGRectMake(0, 0,
                                 CGRectGetWidth(self.view.frame),
                                 CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.navigationController.navigationBar.frame));
    
    // create table view
    self.tableView = [[UITableView alloc] initWithFrame:fullSize style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    pullToRefresh = [SMPullToRefreshFactory pullToRefreshWithScrollView:self.tableView delegate:self];
    
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
    // if data is already set, no need to fetch contents
    /*if (self.listPage) {
        [self applyContents];
        return;
    }*/
    
    // start preloader
    if (![pullToRefresh isRefreshing])
        [SMProgressHUD show];
    
    NSString *url = [self.componentDesciption url];
    
    [SMListPage fetchWithUrlString:url completion:^(SMListPage *theListPage, NSError *error) {
        // end preloader
        [SMProgressHUD dismiss];
        
        if (error) {
            DDLogError(@"List page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        [self setListPage:theListPage];
        [self applyContents];
    }];
}

- (void)applyContents
{
    
    // ui changes
    if (self.listPage.backgroundUrl) {
        UIImageView *background = [[UIImageView alloc] init];
        [background setImageWithURL:self.listPage.backgroundUrl];
        [self.tableView setBackgroundView:background];
    }
    
    // add images view if exists
    /*
    if ([[self.listPage images] count] > 0) {
        self.images = [[SMMultipleImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
        [self.images addImagesWithArray:self.listPage.images];
        [self.view addSubview:self.images];
        
        CGRect tableViewFrame = self.tableView.frame;
        tableViewFrame.origin.y += CGRectGetHeight(self.images.frame);
        tableViewFrame.size.height -= CGRectGetHeight(self.images.frame);
        [self.tableView setFrame:tableViewFrame];
    }*/
    
    [pullToRefresh endRefresh];
    [self.tableView reloadData];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.listPage images] count] > 0) 
        return [self.listPage.items count] + 1;
    
    return [self.listPage.items count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    // we don't support multiple sections yet.
    return 1;
}

- (UITableViewCell *)cellForImageInTableView:(UITableView *)aTableView
{
    static NSString* CellIdentifier = @"ListImageReuseIdentifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SMListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        self.images = [[SMMultipleImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160)];
        [cell.contentView addSubview:self.images];
    }
    
    [self.images addImagesWithArray:self.listPage.images];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if ([[self.listPage images] count] > 0) {
        if ([indexPath row] == 0) {
            return [self cellForImageInTableView:aTableView];
        }
        row -= 1;
    }
    
    static NSString* CellIdentifier = @"ListViewReuseIdentifier";
    
    SMListCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SMListItem *item = [self.listPage.items objectAtIndex:row];
    
    if (cell == nil) {
        cell = [[SMListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // customize the cell
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // background image if exists
        if (self.listPage.itemBackgroundUrl) {
            UIImageView *itemBackground = [[UIImageView alloc] init];
            [itemBackground setImageWithURL:self.listPage.itemBackgroundUrl];
            [cell setBackgroundView:itemBackground];
        }
        
        // table item appearances
        [cell applyAppearances:[self.componentDesciption.appearance objectForKey:@"item_bg_image"]];
        
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
        [cellImage setImageWithURL:item.thumbnailUrl placeholderImage:[UIImage imageNamed:@"Default"] success:^(UIImage *image, BOOL cached) {
            // move text label and title to the side
            CGRect textLabelFrame = cell.textLabel.frame;
            textLabelFrame.origin.x += 5;
            textLabelFrame.size.width -= 20;
            [cell.textLabel setFrame:textLabelFrame];
            
            CGRect textDetailFrame = cell.detailTextLabel.frame;
            textDetailFrame.origin.x += 5;
            textDetailFrame.size.width -= 20;
            [cell.detailTextLabel setFrame:textDetailFrame];
        } failure:^(NSError *error) {
            //
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
    NSInteger row = [indexPath row];
    if ([[self.listPage images] count] > 0) {
        if ([indexPath row] == 0) {
            return;
        }
        row -= 1;
    }
    
    SMListItem *listItem = (SMListItem *)[self.listPage.items objectAtIndex:row];
    SMBaseComponentViewController *ctrl = [self targetComponentByListItem:listItem];
    
    // make delegate know about the navigation
    if (ctrl && [self.componentNavigationDelegate respondsToSelector:@selector(component:willShowViewController:animated:)]) {
        [self.componentNavigationDelegate component:self willShowViewController:ctrl animated:YES];
    }
    
    // display this page now
    if (self.navigationController && ctrl) {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.listPage images] count] > 0 && [indexPath row] == 0)
        return 160.0;
    
    return 80.0;
}

#pragma mark - class methods

- (SMBaseComponentViewController *)targetComponentByListItem:(SMListItem *)listItem
{
    // check if the item has custom component
    if ([listItem hasCustomTargetComponent]) {
        // if there is custom component, fetch information
        
        // create the view controller
        SMAppDescription *appDescription = [SMAppDescription sharedInstance];
        return (SMBaseComponentViewController *)[SMComponentFactory componentWithDescription:listItem.targetComponentDescription
                                                                               forNavigation:appDescription.navigationDescription];
    }
 
    // check if no component link
    if (![listItem hasDefaultTargetComponent]) {
        return nil;
    }
    
    // if there is no target component, create a `ContentComponent`
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            listItem.title, kModelContentPageTitle,
                            listItem.content, kModelContentPageText,
                            //[listItem.imageUrl absoluteString], kModelContentPageImageUrl,
                            //[self.listPage.backgroundUrl absoluteString], kModelContentPageBackgroundImageUrl,
                            nil];
    SMContentPage *contentPage = [[SMContentPage alloc] initWithAttributes:params];
    [contentPage setBackgroundUrl:self.listPage.backgroundUrl];
    if (listItem.imageUrl) {
        [contentPage setImages:[NSArray arrayWithObject:listItem.imageUrl]];
    }
    
    NSDictionary *componentDescParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                         listItem.title, @"title",
                                         listItem.title, @"slug",  // fix this
                                         @"ContentComponent", @"type",
                                         [self.componentDesciption appearance], @"appearance",
                                         @"", @"url",
                                         nil];
    SMComponentDescription *contentComponentDescription = [[SMComponentDescription alloc] initWithAttributes:componentDescParams];
    SMContentViewController *ctrl = [[SMContentViewController alloc] initWithDescription:contentComponentDescription];
    [ctrl setContentPage:contentPage];
    return ctrl;
}


@end
