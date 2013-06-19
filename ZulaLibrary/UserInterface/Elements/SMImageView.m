//
//  SMImageView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIColor+SSToolkitAdditions.h"
#import <CoreText/CoreText.h>

#import "UILabel+SMAdditions.h"
#import "SMImageView.h"
#import "SMAppearanceValidator.h"

@interface SMImageView()
- (void)appearanceForAlignment:(NSString *)alignment;
- (void)appearanceForBackgroundColorHex:(NSString *)colorHex;
- (void)appearanceForCaption:(NSString *)caption;
- (void)rescaleImage;
@end

@implementation SMImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setClipsToBounds:YES];
    }
    return self;
}

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

- (void)setImageWithUrlString:(NSString *)url
{
    if (!url) {
        return;
    }
    
    NSURL *imageUrl = [NSURL URLWithString:url];
    if (!imageUrl) {
        return;
    }
    
    [self setImageWithURL:imageUrl];
}

-(NSString *) stringByStrippingHTML:(NSString *)html {
    NSRange r;
    //NSString *s = [[self copy] autorelease];
    NSString *s = [NSString stringWithString:html];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (void)appearanceForCaption:(NSString *)caption
{
    // adds a caption text on image
    if (!caption) {
        return;
    }
    /*
    NSString *fontName = @"Helvetica";
    float fontSize = 10;
    
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
    
    //[self addSubview:captionLabel];
    */
    
    UIWebView *captionWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            CGRectGetWidth(self.frame),
                                                                            CGRectGetHeight(self.frame))];
    [captionWebView setOpaque:NO];
    [captionWebView setBackgroundColor:[UIColor clearColor]];
    
    [captionWebView loadHTMLString:caption baseURL:[NSURL URLWithString:@"http://www.zulamobile.com"]];
    [captionWebView setDelegate:self];
    [self addSubview:captionWebView];
    
    /*
    NSString *styledCaption = [NSString stringWithFormat:@"<style>.image-caption {font-family: Helvetica, sans-serif; text-shadow: black 1px 1px; font-weight:bold; width:320px; height:160px;}</style><div class='image-element'><div class='image-caption'>%@</div>", caption];
    NSData *data = [styledCaption dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:nil];
    
    
    DTAttributedLabel *captionLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(0,
                                                                                          CGRectGetHeight(self.frame) - textSize.height,
                                                                                          320,
                                                                                          textSize.height)];
    
    [captionLabel setAttributedString:attributedString];
    [captionLabel setBackgroundColor:[UIColor clearColor]];
    [captionLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [captionLabel setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    //[captionLabel setNumberOfLines:0];
    //[captionLabel sizeToFit];
    
    [self addSubview:captionLabel];
     */
}

#pragma mark - web view delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    frame.origin.y = CGRectGetHeight(self.frame) - fittingSize.height;
    webView.frame = frame;
}

#pragma mark - image methods

- (void)addFrame
{
    CALayer *layer = self.layer;
    [layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [layer setBorderWidth:4.0f];
    [layer setShadowColor: [[UIColor colorWithHex:@"333333"] CGColor]];
    [layer setShadowOpacity:0.5f];
    [layer setShadowOffset: CGSizeMake(1, 1)];
    [layer setShadowRadius:1.0];
    [self setClipsToBounds:NO];
    
    [self rescaleImage];
}

- (void)rescaleImage
{
    UIImage* scaledImage = self.image;
    
    CALayer* layer = self.layer;
    CGFloat borderWidth = layer.borderWidth;
    
    //if border is defined
    if (borderWidth > 0)
    {
        //rectangle in which we want to draw the image.
        CGRect imageRect = CGRectMake(0.0, 0.0, self.bounds.size.width - 2 * borderWidth,self.bounds.size.height - 2 * borderWidth);
        //Only draw image if its size is bigger than the image rect size.
        if (self.image.size.width > imageRect.size.width || self.image.size.height > imageRect.size.height)
        {
            UIGraphicsBeginImageContext(imageRect.size);
            [self.image drawInRect:imageRect];
            scaledImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    self.image = scaledImage;
}

@end
