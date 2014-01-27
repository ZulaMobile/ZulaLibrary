//
//  SMSideNavigationViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 13/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMSideNavigationViewController.h"
#import "SMNavigationApperanceManager.h"
#import "SMBaseComponentViewController.h"
#import "SMAppDescription.h"
#import "SMComponentFactory.h"
#import "SMSideMenuViewController.h"


@interface SMSideNavigationViewController () 
@property (nonatomic, strong) SMSideMenuViewController *menuController;
@end

@implementation SMSideNavigationViewController

@synthesize apperanceManager = appearanceManager_, componentDescriptions=_componentDescriptions;

- (id)init
{
    self = [super init];
    if (self) {
        [self setApperanceManager:[SMNavigationApperanceManager appearanceManager]];
        
        // configure side navigation
        self.delegate = self;
        //self.bounceElasticity = 0.2f;
        //self.bounceMagnitude = 60.0f;
        self.gravityMagnitude = 3.0f;
        
        // add stylers
        [self addStylersFromArray:@[[MSDynamicsDrawerParallaxStyler styler], [MSDynamicsDrawerShadowStyler styler]] forDirection:MSDynamicsDrawerDirectionLeft];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    // add the menu controller
    self.menuController = [[SMSideMenuViewController alloc] initWithComponentDesciptions:self.componentDescriptions];
    self.menuController.dynamicsDrawer = self;
    [self setDrawerViewController:self.menuController forDirection:MSDynamicsDrawerDirectionLeft];
    
    // transition to the 1st view controller
    UIViewController *firstComponent = [self componentAtIndex:0];
    [self setPaneViewSlideOffAnimationEnabled:YES];
    
    [self.menuController transitionToViewController:firstComponent animated:NO];
    
    /*
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self bouncePaneOpenInDirection:MSDynamicsDrawerDirectionLeft allowUserInterruption:NO completion:nil];
    });
     */
}

#pragma mark - SMNavigation methods

- (void)addChildComponentDescription:(SMComponentDescription *)componentDescription
{
    // add component to the self.components
    NSMutableArray *tmpComponents;
    if (self.componentDescriptions) {
        tmpComponents = [NSMutableArray arrayWithArray:self.componentDescriptions];
    } else {
        tmpComponents = [NSMutableArray array];
    }
    [tmpComponents addObject:componentDescription];
    [self setComponentDescriptions:[NSArray arrayWithArray:tmpComponents]];
}

- (SMBaseComponentViewController *)componentAtIndex:(NSInteger)index
{
    SMComponentDescription *compDesc = [self.componentDescriptions objectAtIndex:index];
    
    if (!compDesc) {
        raise(1);
    }
    
    SMAppDescription *appDesc = [SMAppDescription sharedInstance];
    return (SMBaseComponentViewController *)[SMComponentFactory componentWithDescription:compDesc forNavigation:appDesc.navigationDescription];
}

- (SMBaseComponentViewController *)componentFromComponentDescription:(SMComponentDescription *)componentDescription
{
    SMAppDescription *appDesc = [SMAppDescription sharedInstance];
    return (SMBaseComponentViewController *)[SMComponentFactory componentWithDescription:componentDescription forNavigation:appDesc.navigationDescription];
}

- (void)navigateComponent:(UIViewController *)toComponent fromComponent:(UIViewController *)fromComponent
{
    [self.menuController transitionToViewController:toComponent animated:YES];
}

#pragma mark - MSDynamicsDrawerViewControllerDelegate

- (void)dynamicsDrawerViewController:(MSDynamicsDrawerViewController *)dynamicsDrawerViewController didUpdateToPaneState:(MSDynamicsDrawerPaneState)state
{
    // Ensure that the pane's table view can scroll to top correctly
    self.menuController.tableView.scrollsToTop = (state == MSDynamicsDrawerPaneStateOpen);
}

@end
