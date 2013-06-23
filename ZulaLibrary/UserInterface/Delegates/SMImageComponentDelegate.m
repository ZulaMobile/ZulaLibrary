//
//  SMImageComponentDelegate.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMImageComponentDelegate.h"

@implementation SMImageComponentDelegate
{
    NSArray *images;
}
@synthesize component;

- (id)initWithComponent:(SMBaseComponentViewController *)aComponent
{
    self = [super init];
    if (self) {
        self.component = aComponent;
    }
    return self;
}

#pragma mark - image view delegate

- (void)imageDidTouch:(SMImageView *)image
{
    // image data
    MWPhoto *photo = [[MWPhoto alloc] initWithImage:image.image];
    images = [NSArray arrayWithObject:photo];
    
    // show image full screen
    [component setWantsFullScreenLayout:YES];
    [component.navigationController setNavigationBarHidden:NO];
    
    // create the image browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // settings
    browser.wantsFullScreenLayout = YES;
    browser.displayActionButton = NO;
    [browser setInitialPageIndex:0];
    
    // present
    if (component.navigationController) {
        [component.navigationController pushViewController:browser animated:YES];
    }
}

#pragma mark - photo browser delegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return [images count];
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < images.count)
        return [images objectAtIndex:index];
    return nil;
}

@end
