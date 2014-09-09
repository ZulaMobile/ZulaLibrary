//
//  SMVideoGalleryViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/29/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMVideoGalleryViewController.h"
#import "ZulaLibrary.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "UIViewController+SMAdditions.h"
#import "UIColor+ZulaAdditions.h"

#import "SMVideoGallery.h"
#import "SMPullToRefreshFactory.h"
#import "SMComponentDescription.h"
#import "SMVideoCell.h"

@interface SMVideoGalleryViewController ()

@end

@implementation SMVideoGalleryViewController
@synthesize tableView;

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect fullSize = CGRectMake(0, 5.0f,
                                 CGRectGetWidth(self.view.frame),
                                 CGRectGetHeight(self.view.frame));
    
    // create table view
    self.tableView = [[UITableView alloc] initWithFrame:fullSize style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // add views to main view
    [self.view addSubview:self.tableView];
}

- (void)fetchContents
{
    [super fetchContents];
    
    NSString *url = [self.componentDesciption url];
    
    [SMVideoGallery fetchWithURLString:url completion:^(SMVideoGallery *theVideoGallery, SMServerError *error) {
        
        if (error) {
            NSLog(@"List page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        self.model = theVideoGallery;
        [self applyContents];
    }];
}

- (void)applyContents
{
    SMVideoGallery *videoGallery = (SMVideoGallery *)self.model;
    
    // ui changes
    if (videoGallery.backgroundUrl) {
        UIImageView *background = [[UIImageView alloc] init];
        [background sd_setImageWithURL:videoGallery.backgroundUrl];
        [self.tableView setBackgroundView:background];
    }
    
    // add navigation image if set
    [self applyNavbarIconWithUrl:videoGallery.navbarIcon];
    
    [self.tableView reloadData];
    
    [super applyContents];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    SMVideoGallery *videoGallery = (SMVideoGallery *)self.model;
    return [[videoGallery videos] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    // we don't support multiple sections yet.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMVideoGallery *videoGallery = (SMVideoGallery *)self.model;
    
    static NSString* CellIdentifier = @"VideoGalleryImageReuseIdentifier";
    
    SMVideoCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SMVideo *video = [videoGallery.videos objectAtIndex:[indexPath row]];
    
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
    SMVideoGallery *videoGallery = (SMVideoGallery *)self.model;
    return ([videoGallery.videos count] - 1 == [indexPath row]) ? 170.0f : 160.0;
}


@end
