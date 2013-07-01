//
//  SMVideoGalleryViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/29/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMVideoGalleryViewController.h"
#import "SMProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIViewController+SSToolkitAdditions.h"
#import "UIColor+SSToolkitAdditions.h"

#import "SMVideoGallery.h"
#import "SMPullToRefreshFactory.h"
#import "SMComponentDescription.h"
#import "SMVideoCell.h"

@interface SMVideoGalleryViewController ()

@end

@implementation SMVideoGalleryViewController
@synthesize videoGallery, tableView;

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect fullSize = CGRectMake(0, 0,
                                 CGRectGetWidth(self.view.frame),
                                 CGRectGetHeight(self.view.frame));
    
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
    // if data is already set and not deliberately refreshing contents, so no need to fetch contents
    if (![pullToRefresh isRefreshing] && self.videoGallery) {
        [self applyContents];
        return;
    }
    
    // start preloader
    if (![pullToRefresh isRefreshing])
        [SMProgressHUD show];
    
    NSString *url = [self.componentDesciption url];
    
    [SMVideoGallery fetchWithURLString:url completion:^(SMVideoGallery *theVideoGallery, SMServerError *error) {
        // end preloader
        [SMProgressHUD dismiss];
        
        if (error) {
            DDLogError(@"List page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        [self setVideoGallery:theVideoGallery];
        [self applyContents];
    }];
}

- (void)applyContents
{
    
    // ui changes
    if (self.videoGallery.backgroundUrl) {
        UIImageView *background = [[UIImageView alloc] init];
        [background setImageWithURL:self.videoGallery.backgroundUrl];
        [self.tableView setBackgroundView:background];
    }
    
    // add navigation image if set
    [self applyNavbarIconWithUrl:self.videoGallery.navbarIcon];
    
    [pullToRefresh endRefresh];
    [self.tableView reloadData];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.videoGallery videos] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    // we don't support multiple sections yet.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"VideoGalleryImageReuseIdentifier";
    
    SMVideoCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SMVideo *video = [self.videoGallery.videos objectAtIndex:[indexPath row]];
    
    if (cell == nil) {
        cell = [[SMVideoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // customize the cell
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // background
        [cell setBackgroundColor:[UIColor colorWithHex:@"FFFFFF"]];
        
        // table item appearances
        //[cell applyAppearances:[self.componentDesciption.appearance objectForKey:@"item_bg_image"]];
    }
    
    [cell showVideoWithUrl:video.url];
    [cell.videoLabel setText:video.title];
    
    return cell;
}

#pragma mark - table view delegate

// display the detail row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //SMVideo *video = (SMVideo *)[self.videoGallery.videos objectAtIndex:[indexPath row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([self.videoGallery.videos count] - 1 == [indexPath row]) ? 170.0f : 160.0;
}


@end
