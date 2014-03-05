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


@interface SMSideNavigationViewController () <SWRevealViewControllerDelegate>

@end

@implementation SMSideNavigationViewController

@synthesize apperanceManager = appearanceManager_, componentDescriptions=_componentDescriptions;

- (id)init
{
    self = [super init];
    if (self) {
        [self setApperanceManager:[SMNavigationApperanceManager appearanceManager]];
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add the menu controller
    [self setRearViewController:[[SMSideMenuViewController alloc] initWithComponentDesciptions:self.componentDescriptions]];
    
    // transition to the 1st view controller
    UIViewController *firstComponent = [self componentAtIndex:0];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/Menu_Icon"]
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(revealToggle:)];
    if ([firstComponent isKindOfClass:[UINavigationController class]]) {
        UIViewController *topViewController = [(UINavigationController *)firstComponent topViewController];
        topViewController.navigationItem.leftBarButtonItem = item;
    } else {
        firstComponent.navigationItem.leftBarButtonItem = item;
    }
    
    [self setFrontViewController:firstComponent];
    
    [self panGestureRecognizer];
    [self tapGestureRecognizer];
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
    [(SMSideMenuViewController *)self.rearViewController transitionToViewController:toComponent animated:NO];
}

#pragma mark - delegate

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    
}

- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position
{
    
}

- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController;
{
    
}

- (void)revealControllerPanGestureEnded:(SWRevealViewController *)revealController;
{
    
}

- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress
{
    
}

- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    
}

- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    
}

@end
