//
//  SMBaseComponentViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"
#import "SMComponentDescription.h"
#import "SMAppDescription.h"
#import "SMMainView.h"
#import "SMImageView.h"
#import "UIViewController+SSToolkitAdditions.h"

@interface SMBaseComponentViewController ()

@end

@implementation SMBaseComponentViewController
@synthesize componentDesciption = _componentDesciption;

- (id)initWithDescription:(SMComponentDescription *)description
{
    self = [super init];
    if (self) {
        [self setComponentDesciption:description];
        
        // configure component
        [self setTitle:self.componentDesciption.title];
        
        // padding default value
        padding = 10.0;
    }
    return self;
}

- (void)loadView
{
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    SMMainView *view = [[SMMainView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [view applyAppearances:self.componentDesciption.appearance];
    
    // set background image
    self.backgroundImageView = [[SMImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    [self.backgroundImageView setAutoresizesSubviews:UIViewAutoresizingFlexibleAll];
    [self.backgroundImageView applyAppearances:[self.componentDesciption.appearance objectForKey:@"bg_image"]];
    
    // navigation bar
    NSInteger displayNavBar = [[self.componentDesciption.appearance objectForKey:@"display_navbar"] integerValue];
    if (displayNavBar == 1) {
        [self.navigationController setNavigationBarHidden:NO];
    } else {
        [self.navigationController setNavigationBarHidden:YES];
    }
    
    // set view
    [view addSubview:self.backgroundImageView];
    [view sendSubviewToBack:self.backgroundImageView];
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)fetchContents
{
    // must be overridden
}

@end
