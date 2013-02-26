//
//  SMNavbarNavigationViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMNavbarNavigationViewController.h"

@interface SMNavbarNavigationViewController ()

@end

@implementation SMNavbarNavigationViewController
@synthesize components = components_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewController:(UIViewController *)childController
{
    NSMutableArray *tmpComponents;
    if (self.components) {
        tmpComponents = [NSMutableArray arrayWithArray:self.components];
    } else {
        tmpComponents = [NSMutableArray array];
    }
    
    [tmpComponents addObject:childController];
    [self setComponents:[NSArray arrayWithArray:tmpComponents]];
}

@end
