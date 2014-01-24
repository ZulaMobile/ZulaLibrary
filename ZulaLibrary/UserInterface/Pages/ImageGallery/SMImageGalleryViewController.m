//
//  SMImageGalleryViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMImageGalleryViewController.h"
#import "SMProgressHUD.h"
#import "UIViewController+SMAdditions.h"

#import "SMComponentDescription.h"
#import "MWPhoto.h"
#import "SMImageGallery.h"
#import "SMPullToRefreshFactory.h"

@interface SMImageGalleryViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SMImageGalleryViewController
@synthesize photos, imageGallery, scrollView;

- (id)initWithDescription:(SMComponentDescription *)description
{
    self = [super initWithDescription:description];
    if (self) {
        self.photos = [NSMutableArray array];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    // scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    NSString *pullToRefreshType = [self.componentDesciption.appearance objectForKey:@"pull_to_refresh_type"];
    pullToRefresh = [SMPullToRefreshFactory pullToRefreshWithScrollView:self.scrollView
                                                               delegate:self
                                                                   name:pullToRefreshType];
    
    [self.view addSubview:self.scrollView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fetch the data and load the model
    [self fetchContents];
}

#pragma mark - overridden methods

- (void)fetchContents
{
    // if data is already set and not deliberately refreshing contents, so no need to fetch contents
    if (![pullToRefresh isRefreshing] && self.imageGallery) {
        [self applyContents];
        return;
    }
    
    // start preloader
    if (![pullToRefresh isRefreshing]) 
        [SMProgressHUD show];
    
    
    NSString *url = [self.componentDesciption url];
    [SMImageGallery fetchWithURLString:url completion:^(SMImageGallery *_imageGallery, SMServerError *error) {
        // end preloader
        [SMProgressHUD dismiss];
        
        if (error) {
            DDLogError(@"Content page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        [self setImageGallery:_imageGallery];
        [self applyContents];
    }];
}

- (void)applyContents
{
    UIView *thumbnailViewToDelete = [self.scrollView viewWithTag:443];
    [thumbnailViewToDelete removeFromSuperview];
    thumbnailViewToDelete = nil;
    
    // add navigation image if set
    [self applyNavbarIconWithUrl:self.imageGallery.navbarIcon];
    
    self.photos = [NSMutableArray array];
    
    for (NSURL *url in self.imageGallery.images) {
        MWPhoto *ph = [MWPhoto photoWithURL:url];
        //[ph setCaption:@"Buraya aciklamalar gelecek"];
        [photos addObject:ph];
    }
    
    // thumbnail container
    UIView *thumbnailContainer = [[UIView alloc] initWithFrame:CGRectMake(self.padding.x,
                                                                          self.padding.y,
                                                                          CGRectGetWidth(self.view.frame) - self.padding.x * 2,
                                                                          - self.padding.y * 2)];
    [thumbnailContainer setBackgroundColor:[UIColor clearColor]];
    [thumbnailContainer setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    // set thumbnails
    NSInteger count = self.photos.count;
    int imagesPerRow = CGRectGetWidth(self.view.frame) / 80; // how many thumbnail on per row
    float width = (320 - (self.padding.y * (imagesPerRow + 1))) / imagesPerRow; // thumbnail width
    float height = width; // thumbnail height
    
    SMImageView *image;
    for (int i = 0; i < count; i++) {
        int row = i / imagesPerRow;
        int column = i % imagesPerRow;
        
        // create the thumbnail view
        image = [[SMImageView alloc] initWithFrame:CGRectMake((self.padding.x * column) + (column * width),
                                                              (self.padding.y * row) + (row * height),
                                                              width,
                                                              height)];
        [image setImageWithURL:[self.imageGallery.images objectAtIndex:i] activityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [image setContentMode:UIViewContentModeScaleToFill];
        [image setTouchDelegate:self];
        [image setTag:i];
        [image addFrame];
        
        [thumbnailContainer addSubview:image];
    }
    
    // expand the container size
    CGRect contanerFrame = thumbnailContainer.frame;
    contanerFrame.size.height = ((count/imagesPerRow + 1) * height) + (self.padding.y * (count/imagesPerRow + 1)) + self.padding.y;
    [thumbnailContainer setTag:443];
    [thumbnailContainer setFrame:contanerFrame];
    
    [self.scrollView addSubview:thumbnailContainer];
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(thumbnailContainer.frame), CGRectGetHeight(thumbnailContainer.frame))];
    
    [pullToRefresh endRefresh];
}

#pragma mark - private methods

- (void)imageDidTouch:(SMImageView *)image
{
    // create the image browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // settings
    browser.wantsFullScreenLayout = YES;
    browser.displayActionButton = NO;
    [browser setInitialPageIndex:image.tag];
    
    // make delegator know about this navigation
    if ([self.componentNavigationDelegate respondsToSelector:@selector(component:willShowViewController:animated:)]) {
        [self.componentNavigationDelegate component:self willShowViewController:browser animated:YES];
    }
    
    // present
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - photo browser delegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

@end
