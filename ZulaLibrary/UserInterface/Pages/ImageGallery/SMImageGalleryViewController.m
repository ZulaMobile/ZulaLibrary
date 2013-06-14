//
//  SMImageGalleryViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMImageGalleryViewController.h"
#import "SMProgressHUD.h"
#import "UIViewController+SSToolkitAdditions.h"

#import "SMComponentDescription.h"
#import "MWPhoto.h"
#import "SMImageView.h"
#import "SMImageGallery.h"

@interface SMImageGalleryViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

- (void)onButton:(UIView *)sender;

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
    // if data is already set, no need to fetch contents
    if (self.imageGallery) {
        [self applyContents];
        return;
    }
    
    // start preloader
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
    for (NSURL *url in self.imageGallery.images) {
        MWPhoto *ph = [MWPhoto photoWithURL:url];
        //[ph setCaption:@"Buraya aciklamalar gelecek"];
        [photos addObject:ph];
    }
    
    // thumbnail container
    UIView *thumbnailContainer = [[UIView alloc] initWithFrame:CGRectMake(padding,
                                                                          padding,
                                                                          CGRectGetWidth(self.view.frame) - padding * 2,
                                                                          0)];
    [thumbnailContainer setBackgroundColor:[UIColor clearColor]];
    [thumbnailContainer setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    // set thumbnails
    NSInteger count = self.photos.count;
    int imagesPerRow = CGRectGetWidth(self.view.frame) / 80; // how many thumbnail on per row
    float width = (320 - (padding * (imagesPerRow + 1))) / imagesPerRow; // thumbnail width
    float height = width; // thumbnail height
    
    UIButton *imageButton;
    SMImageView *image;
    for (int i = 0; i < count; i++) {
        int row = i / imagesPerRow;
        int column = i % imagesPerRow;
        
        // image button
        imageButton = [[UIButton alloc] initWithFrame:CGRectMake((padding * column) + (column * width),
                                                                 (padding * row) + (row * height),
                                                                 width,
                                                                 height)];
        // create the thumbnail view
        image = [[SMImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(imageButton.frame), CGRectGetHeight(imageButton.frame))];
        [image setImageWithURL:[self.imageGallery.images objectAtIndex:i]];
        [image setClipsToBounds:YES];
        [image setContentMode:UIViewContentModeScaleToFill];
        [image addFrame];
        
        [imageButton addSubview:image];
        [imageButton setTag:i];
        [imageButton addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [thumbnailContainer addSubview:imageButton];
    }
    
    // expand the container size
    CGRect contanerFrame = thumbnailContainer.frame;
    contanerFrame.size.height = ((count/imagesPerRow + 1) * height) + (padding * (count/imagesPerRow + 1)) + padding;
    [thumbnailContainer setFrame:contanerFrame];
    
    [self.scrollView addSubview:thumbnailContainer];
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(thumbnailContainer.frame), CGRectGetHeight(thumbnailContainer.frame))];
}

#pragma mark - private methods

- (void)onButton:(UIView *)sender
{
    // create the image browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // settings
    browser.wantsFullScreenLayout = YES;
    browser.displayActionButton = NO;
    [browser setInitialPageIndex:sender.tag];
    
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
