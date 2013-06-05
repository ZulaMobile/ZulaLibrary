//
//  SMImageGalleryViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMImageGalleryViewController.h"
#import "MWPhoto.h"
#import "SMImageView.h"

@interface SMImageGalleryViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

- (void)onButton:(UIView *)sender;

@end

@implementation SMImageGalleryViewController
@synthesize photos, photoUrls, scrollView;

- (id)initWithDescription:(SMComponentDescription *)description
{
    self = [super initWithDescription:description];
    if (self) {
        self.photoUrls = [NSArray arrayWithObjects:
                          @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg",
                          @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",
                          @"http://farm8.staticflickr.com/7036/6816418388_a771f3d599_o.jpg",
                          @"http://farm8.staticflickr.com/7046/6812073540_7642101577_c.jpg",
                          @"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg",
                          @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg",
                          @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",
                          @"http://farm8.staticflickr.com/7036/6816418388_a771f3d599_o.jpg",
                          @"http://farm8.staticflickr.com/7046/6812073540_7642101577_c.jpg",
                          @"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg",
                          @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg",
                          @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",
                          @"http://farm8.staticflickr.com/7036/6816418388_a771f3d599_o.jpg",
                          @"http://farm8.staticflickr.com/7046/6812073540_7642101577_c.jpg",
                          @"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg",
                          @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg",
                          @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",
                          @"http://farm8.staticflickr.com/7036/6816418388_a771f3d599_o.jpg",
                          @"http://farm8.staticflickr.com/7046/6812073540_7642101577_c.jpg",
                          @"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg",
                          @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg",
                          @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",
                          @"http://farm8.staticflickr.com/7036/6816418388_a771f3d599_o.jpg",
                          @"http://farm8.staticflickr.com/7046/6812073540_7642101577_c.jpg",
                          @"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg",
                          @"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg",
                          @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg",
                          @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",
                          @"http://farm8.staticflickr.com/7036/6816418388_a771f3d599_o.jpg",
                          @"http://farm8.staticflickr.com/7046/6812073540_7642101577_c.jpg",
                          @"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg",
                          @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg",
                          @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",
                          @"http://farm8.staticflickr.com/7036/6816418388_a771f3d599_o.jpg",
                          @"http://farm8.staticflickr.com/7046/6812073540_7642101577_c.jpg",
                          @"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg",
                          @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg",
                          @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",
                          @"http://farm8.staticflickr.com/7036/6816418388_a771f3d599_o.jpg",
                          @"http://farm8.staticflickr.com/7046/6812073540_7642101577_c.jpg",
                          @"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg",
                          nil];
        
        self.photos = [NSMutableArray array];
        for (NSString *urlString in self.photoUrls) {
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:urlString]]];
        }
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    // scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
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
        [image setImageWithURL:[NSURL URLWithString:[self.photoUrls objectAtIndex:i]]];
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
    [self.view addSubview:self.scrollView];
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
