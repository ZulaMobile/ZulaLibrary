//
//  SMMultipleImageView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/30/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMMultipleImageView.h"
#import "UIImageView+WebCache.h"

#import "UIColor+SSToolkitAdditions.h"
#import <CoreText/CoreText.h>
#import "UILabel+SMAdditions.h"
#import "SMAppearanceValidator.h"

@interface SMMultipleImageView()

// internal scrollview
@property (nonatomic, strong) UIScrollView *scrollView;

// internal page control
@property (nonatomic, strong) UIPageControl *pageControl;

// change page with page control
- (void)changePage:(id)sender;

// appearance methods
- (void)appearanceForAlignment:(NSString *)alignment;
- (void)appearanceForBackgroundColorHex:(NSString *)colorHex;
- (void)appearanceForCaption:(NSString *)caption;

@end

@implementation SMMultipleImageView
{
    BOOL pageControlUsed;
    UIActivityIndicatorView *indicator;
}
@synthesize scrollView, pageControl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        pageControlUsed = NO;
        
        // initialize scrollview
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self.scrollView setContentSize:CGSizeMake(0, CGRectGetHeight(self.frame))];
        [self.scrollView setPagingEnabled:YES];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self.scrollView setDelegate:self];
        
        // initial page control on the bottom center
        float pageControlHeight = 20.0f;
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - pageControlHeight - 10, CGRectGetWidth(self.frame), pageControlHeight)];
        [self.pageControl setCurrentPage:1];
        [self.pageControl setNumberOfPages:0];
        [self.pageControl setHidesForSinglePage:YES];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}

#pragma park - methosds

- (void)addImagesWithArray:(NSArray *)imageArray
{
    // remove all images
    // @todo
    
    for (id image in imageArray) {
        if ([image isKindOfClass:[UIImageView class]]) {
            [self pushImageView:image];
        } else if ([image isKindOfClass:[NSURL class]]) {
            [self pushImageUrl:image];
        } else {
            raise(1);
        }
    }
}

- (void)pushImageUrl:(NSURL *)imageUrl
{
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    float width = 20.0f, height = 20.0f;
    [indicator setFrame:CGRectMake(CGRectGetWidth(self.frame) / 2 - width / 2, CGRectGetHeight(self.frame) / 2 - height / 2, width, height)];
    [indicator setHidesWhenStopped:YES];
    [indicator startAnimating];
    [indicator setTag:45];
    
    __block UIActivityIndicatorView *blockIndicator = indicator;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [imageView addSubview:indicator];
    
    [imageView setImageWithURL:imageUrl success:^(UIImage *image, BOOL cached) {
        [blockIndicator stopAnimating];
    } failure:^(NSError *error) {
        [blockIndicator stopAnimating];
    }];
    [self pushImageView:imageView];
}

- (void)pushImageView:(UIImageView *)imageView
{
    // resize the image to fit into this view
    // add the image at the end of the scroll view
    [imageView setFrame:CGRectMake(self.scrollView.contentSize.width,
                                   0,
                                   CGRectGetWidth(self.frame),
                                   CGRectGetHeight(self.frame))];
    [self.scrollView addSubview:imageView];
    
    // expand the content size of the scroll view
    CGSize currentContentSize = self.scrollView.contentSize;
    currentContentSize.width += CGRectGetWidth(self.frame);
    self.scrollView.contentSize = currentContentSize;
    
    NSInteger numberOfPages = self.pageControl.numberOfPages;
    numberOfPages++;
    [self.pageControl setNumberOfPages:numberOfPages];
}

#pragma mark - private methods

- (void)changePage:(id)sender
{
    pageControlUsed = YES;
    CGFloat pageWidth = self.scrollView.contentSize.width / self.pageControl.numberOfPages;
    CGFloat x = self.pageControl.currentPage * pageWidth;
    [self.scrollView scrollRectToVisible:CGRectMake(x, 0, pageWidth, self.scrollView.frame.size.height) animated:YES];
}

#pragma mark - scroll view delegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!pageControlUsed)
        self.pageControl.currentPage = lround(self.scrollView.contentOffset.x /
                                              (self.scrollView.contentSize.width / self.pageControl.numberOfPages));
}

#pragma mark - appearance methods

/**
 image view settings, Current available options are:
 * alignment: the content mode [center, left, right, aspect_fill, aspect_fit]. default is aspect_fill
 * bg_color
 */
- (void)applyAppearances:(NSDictionary *)appearances
{
    if (![SMAppearanceValidator isValidData:appearances]) {
        //DDLogError(@"Image data is not valid, expects dict: %@", appearances);
        return;
    }
    
    // set appearances
    [self appearanceForAlignment:[appearances objectForKey:@"alignment"]];
    [self appearanceForBackgroundColorHex:[appearances objectForKey:@"bg_color"]];
    [self appearanceForCaption:[appearances objectForKey:@"caption"]];
}

#pragma mark - appearance helpers

- (void)appearanceForAlignment:(NSString *)alignment
{
    // default value
    if (!alignment)
        alignment = @"aspect_fill";
    
    if ([alignment isEqualToString:@"left"]) {
        [self setContentMode:UIViewContentModeLeft];
    } else if ([alignment isEqualToString:@"right"]) {
        [self setContentMode:UIViewContentModeRight];
    } else if ([alignment isEqualToString:@"center"]) {
        [self setContentMode:UIViewContentModeCenter];
    } else if ([alignment isEqualToString:@"aspect_fit"]) {
        [self setContentMode:UIViewContentModeScaleAspectFit];
    } else if ([alignment isEqualToString:@"aspect_fill"]) {
        [self setContentMode:UIViewContentModeScaleAspectFill];
    }
}

- (void)appearanceForBackgroundColorHex:(NSString *)colorHex
{
    // default value
    if (!colorHex) {
        colorHex = @"clean";
    }
    
    if ([colorHex isEqualToString:@"clean"] || [colorHex isEqualToString:@""]) {
        [self setBackgroundColor:[UIColor clearColor]];
    } else {
        [self setBackgroundColor:[UIColor colorWithHex:colorHex]];
    }
}

- (void)appearanceForCaption:(NSString *)caption
{
    // adds a caption text on image
    if (!caption) {
        return;
    }
    
    NSString *fontName = @"Helvetica";
    float fontSize = 12;
    CGSize textSize = [caption sizeWithFont:[UIFont fontWithName:fontName size:fontSize] constrainedToSize:self.frame.size lineBreakMode:NSLineBreakByTruncatingTail];
    
     UILabel *captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2 - textSize.width / 2,
     CGRectGetHeight(self.frame) - textSize.height - 10.0,
     320,
     textSize.height)];
     [captionLabel setText:caption];
     [captionLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
     [captionLabel setBackgroundColor:[UIColor clearColor]];
     [captionLabel setTextAlignment:NSTextAlignmentCenter];
     [captionLabel setTextColor:[UIColor whiteColor]];
     [captionLabel setShadowColor:[UIColor blackColor]];
     [captionLabel setShadowOffset:CGSizeMake(0, -1)];
     [captionLabel setLineBreakMode:NSLineBreakByTruncatingTail];
     [captionLabel setNumberOfLines:0];
     [captionLabel sizeToFit];
     
     // add glow
     [captionLabel addGlow:[UIColor blackColor]];
     
     [self addSubview:captionLabel];
     
}


@end
