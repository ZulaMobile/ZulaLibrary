//
//  SMImageGalleryViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMImageGalleryViewController.h"
#import "MWPhoto.h"

@interface SMImageGalleryViewController ()
- (void)onButton;
@end

@implementation SMImageGalleryViewController
@synthesize photos;

- (id)initWithDescription:(SMComponentDescription *)description
{
    self = [super initWithDescription:description];
    if (self) {
        self.photos = [NSMutableArray array];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm8.staticflickr.com/7036/6816418388_a771f3d599_o.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm8.staticflickr.com/7046/6812073540_7642101577_c.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm8.staticflickr.com/7054/6952857223_d117581db2_b.jpg"]]];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"open gallery" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(20, 20, 280, 44)];
    [btn addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)onButton
{
    // create the image browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // settings
    browser.wantsFullScreenLayout = YES;
    browser.displayActionButton = NO;
    [browser setInitialPageIndex:0];
    
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
