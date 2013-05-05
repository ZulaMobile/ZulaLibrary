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
    /*
    self.listPage = [[SMListPage alloc] initWithAttributes:
                     @{
                     @"title": @"My Cool List",
                     @"bg_image": @"http://localhost:8000/media/cache/d0/0d/d00dac305398fcee38b48e24ccaca322.png",
                     @"item_bg_image": @"http://localhost:8000/media/cache/6e/0c/6e0c55731aba01c848b1f28ddf9a63d9.png",
                     @"listing_style": @"table",
                     @"items": @[
                     @{
                     @"title": @"My news item 1",
                     @"subtitle": @"my news subtitle 1",
                     @"image": @"",
                     @"content": @"Lorem ipsum",
                     @"target_component_url": @"",
                     @"target_component_type": @"",
                     @"thumbnail": @"http://localhost:8000/media/cache/76/06/760695076cef82337ae13114e38633ab.png"
                     },
                     @{
                     @"title": @"My news item 2",
                     @"subtitle": @"my news subtitle 2",
                     @"image": @"",
                     @"content": @"Lorem ipsum",
                     @"target_component_url": @"",
                     @"target_component_type": @"",
                     @"thumbnail": @"http://localhost:8000/media/cache/76/06/760695076cef82337ae13114e38633ab.png"
                     },
                     @{
                     @"title": @"My news item 3 My news item 3 My news item 3 My news item 3",
                     @"subtitle": @"my news subtitle 3 my news subtitle 3 my news subtitle 3",
                     @"image": @"",
                     @"content": @"Lorem ipsum",
                     @"target_component_url": @"",
                     @"target_component_type": @"",
                     @"thumbnail": @"http://localhost:8000/media/cache/76/06/760695076cef82337ae13114e38633ab.png"
                     },
                     @{
                     @"title": @"My news item 4",
                     @"subtitle": @"my news subtitle 4",
                     @"image": @"",
                     @"content": @"Lorem ipsum",
                     @"target_component_url": @"",
                     @"target_component_type": @"",
                     @"thumbnail": @"http://localhost:8000/media/cache/76/06/760695076cef82337ae13114e38633ab.png"
                     },
                     ]
                     }];
    */
    
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
    
    if (cell == nil) {
        cell = [[SMListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // customize the cell
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        
        // background image if exists
        if (self.listPage.itemBackgroundUrl) {
            UIImageView *itemBackground = [[UIImageView alloc] init];
            [itemBackground setImageWithURL:self.listPage.itemBackgroundUrl];
            [cell setBackgroundView:itemBackground];
        }
    }
    
    // customize the cell data
    SMListItem *item = [self.listPage.items objectAtIndex:[indexPath row]];
    [cell.textLabel setText:item.title];
    [cell.detailTextLabel setText:item.subtitle];
    
    // left image if exists
    if (item.thumbnailUrl) {
        UIImageView *cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 76, 76)];
        [cellImage setImageWithURL:item.thumbnailUrl
                       placeholderImage:[UIImage imageNamed:@"Default"]];
        [cellImage setContentMode:UIViewContentModeScaleAspectFit];
        [cellImage setClipsToBounds:YES];
        [cellImage setTag:31];
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
    if (self.navigationController) {
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
    
    // if there is custom component, create the view controller
    // get view controller's appearances from main appearances
    if ([listItem hasTargetComponent]) {
        
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
