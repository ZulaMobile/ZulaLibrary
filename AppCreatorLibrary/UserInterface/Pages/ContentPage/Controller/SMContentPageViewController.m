//
//  SMContentPageViewController.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContentPageViewController.h"

@interface SMContentPageViewController ()
- (void)_customizeViews;
@end

@implementation SMContentPageViewController

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [view setBackgroundColor:[UIColor yellowColor]];
    
    _titleView = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth(view.frame), 30)];
    [_titleView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_titleView setText:@"Test label"];
    [_titleView setTextColor:[UIColor blackColor]];
    
    [view addSubview:_titleView];
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fetch the data and load the model
    
    // customize views
    
}

#pragma mark - private methods

// organize and customize the views
// must be called after the data is fetched and we have a model instance
- (void)_customizeViews
{
    /*
    SMAppearance *appearance = [[SMAppearance alloc] init];
    [appearance fetchAppearanceWithBlock:(void(^)(NSError *error)) {
        
    }];
    
    
    SMComponentAppearance *titleAppearance = [SMComponentAppearance appearanceForModel:[SMContentPage identifier] element:@"title"];
    NSString *fontName = [titleAppearance objectForKey:@"font-name"];
    NSString *textColor = [titleAppearance objectForKey:@"text-color"];
    float fontSize = [titleAppearance floatForKey:@"font-size"];
    */
}

@end
