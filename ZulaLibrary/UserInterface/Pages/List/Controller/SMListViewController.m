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

#import "UIColor+ZulaAdditions.h"
#import "UIViewController+SMAdditions.h"

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

#import "SMTabularListStrategy.h"
#import "SMSummaryListStrategy.h"

#import "SMPullToRefreshModule.h"
#import "SMPullToRefreshFactory.h"


@interface SMListPullToRefreshModule : SMPullToRefreshModule
@end

@implementation SMListPullToRefreshModule

- (void)componentViewDidLoad
{
    // override the default behavior
}

- (void)componentDidFetchContent:(SMModel *)model
{
    if (!pullToRefresh) {
        NSString *pullToRefreshType = [self.component.componentDesciption.appearance objectForKey:@"pull_to_refresh_type"];
        SMListViewController *controller = (SMListViewController *)self.component;
        pullToRefresh = [SMPullToRefreshFactory pullToRefreshWithScrollView:[(SMTabularListStrategy *)controller.strategy tableView]
                                                                   delegate:self
                                                                       name:pullToRefreshType];
    }
    
    [super componentDidFetchContent:model];
}

@end


@interface SMListViewController ()
@end

@implementation SMListViewController
@synthesize images;

- (void)loadView
{
    [super loadView];
 
    // remove the default pull to refresh
    [self removeModuleByClass:[SMPullToRefreshModule class]];
    
    // add our modified one
    [self addModuleByClass:[SMListPullToRefreshModule class]];
}

- (void)fetchContents
{
    [super fetchContents];
    
    NSString *url = [self.componentDesciption url];
    
    [SMListPage fetchWithUrlString:url completion:^(SMListPage *theListPage, NSError *error) {
        
        if (error) {
            DDLogError(@"List page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        self.model = theListPage;
        [self applyContents];
    }];
}

- (void)applyContents
{
    SMListPage *listPage = (SMListPage *)self.model;
    
    // set the strategy
    if (listPage.listingStyle == SMListingStyleSummary) {
        self.strategy = [[SMSummaryListStrategy alloc] initWithListViewController:self];
    } else if (listPage.listingStyle == SMListingStyleTable) {
        self.strategy = [[SMTabularListStrategy alloc] initWithListViewController:self];
    } else {
        self.strategy = [[SMTabularListStrategy alloc] initWithListViewController:self];
    }
    
    [self.strategy setup];
    [self.strategy applyAppearances:[self.componentDesciption.appearance objectForKey:@""]];
    
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
    
    // add navigation image if set
    [self applyNavbarIconWithUrl:listPage.navbarIcon];
    
    [super applyContents];
}



#pragma mark - class methods

- (SMBaseComponentViewController *)targetComponentByListItem:(SMListItem *)listItem
{
    SMListPage *listPage = (SMListPage *)self.model;
    
    // check if the item has custom component
    if ([listItem hasCustomTargetComponent]) {
        // if there is custom component, fetch information
        
        // create the view controller
        SMAppDescription *appDescription = [SMAppDescription sharedInstance];
        return (SMBaseComponentViewController *)[SMComponentFactory subComponentWithDescription:listItem.targetComponentDescription
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
    [contentPage setBackgroundUrl:listPage.backgroundUrl];
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
    ctrl.model = contentPage;
    return ctrl;
}


@end
