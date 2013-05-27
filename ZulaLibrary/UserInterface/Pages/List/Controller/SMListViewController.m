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
#import "SMContentPage.h"
#import "SMListCell.h"
#import "SMContentViewController.h"
#import "SMComponentDescription.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SMProgressHUD.h"
#import "UIViewController+SSToolkitAdditions.h"
#import "SMComponentFactory.h"
#import "SMAppDescription.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ZulaAdditions.h"

@interface SMListViewController ()

@end

@implementation SMListViewController
@synthesize listPage, tableView;

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
    // if data is already set, no need to fetch contents
    if (self.listPage) {
        [self applyContents];
        return;
    }
    
    // start preloader
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
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    // ui changes
    if (self.listPage.backgroundUrl) {
        UIImageView *background = [[UIImageView alloc] init];
        [background setImageWithURL:self.listPage.backgroundUrl];
        [self.tableView setBackgroundView:background];
    }
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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
    
    SMListCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SMListItem *item = [self.listPage.items objectAtIndex:[indexPath row]];
    
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
        UIImageView *cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
        [cellImage setImageWithURL:item.thumbnailUrl
                       placeholderImage:[UIImage imageNamed:@"Default"]];
        [cellImage setContentMode:UIViewContentModeScaleAspectFill];
        [cellImage setClipsToBounds:YES];
        [cellImage setTag:31];
        
        // add borders
        //UIColor *bgColor = [cell backgroundColor];
        [cellImage.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [cellImage.layer setBorderWidth:0.5];
        
        [cell.contentView addSubview:cellImage];
    }
    
    return cell;
}

#pragma mark - table view delegate

// display the detail row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMListItem *listItem = (SMListItem *)[self.listPage.items objectAtIndex:[indexPath row]];
    SMBaseComponentViewController *ctrl = [self targetComponentByListItem:listItem];
    
    // display this page now
    if (self.navigationController && ctrl) {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

#pragma mark - class methods

- (SMBaseComponentViewController *)targetComponentByListItem:(SMListItem *)listItem
{
    // check if the item has custom component
    if ([listItem hasCustomTargetComponent]) {
        // if there is custom component, fetch information
        
        // get view controller's appearances from main appearances
        
        // create the view controller
        //SMAppDescription *appDescription = [SMAppDescription sharedInstance];
        //SMComponentFactory componentWithDescription:[appDescription.componentDescriptions] forNavigation:<#(SMNavigationDescription *)#>
        
        return nil;
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
    [contentPage setImageUrl:listItem.imageUrl];
    
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
