//
//  SMSideMenuViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 13/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMSideMenuViewController.h"
#import "SMArrayDataSource.h"
#import "SMTableCell.h"
#import "SMComponentDescription.h"
#import "SMAppDelegate.h"
#import "SMBaseComponentViewController.h"


@interface SMSideMenuLogoCell : UITableViewCell

@end

@implementation SMSideMenuLogoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
        UIView *selectedBackgroundView = [UIView new];
        selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
        self.selectedBackgroundView = selectedBackgroundView;
        
        UIView *backgoundView = [UIView new];
        backgoundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
        self.backgroundView = backgoundView;
    }
    return self;
}

@end


static NSString *const CellIdentifier = @"MenuCellIdentifier";

@interface SMSideMenuViewController ()

@property (nonatomic, strong) SMArrayDataSource *arrayDataSource;

- (void)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender;

@end

@implementation SMSideMenuViewController

- (instancetype)initWithComponentDesciptions:(NSArray *)componentDescriptions
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        __block id weakSelf = self;
        self.arrayDataSource = [[SMArrayDataSource alloc] initWithItems:componentDescriptions cellIdentifier:CellIdentifier configureCellBlock:^(id cell, id item, NSIndexPath *indexPath) {
            SMTableCell *theCell = (SMTableCell *)cell;
            SMComponentDescription *desc = (SMComponentDescription *)item;
            theCell.textLabel.text = desc.title;
        } itemDidSelectBlock:^(id item, NSIndexPath *indexPath) {
            SMSideMenuViewController *strongSelf = weakSelf;
            
            UIResponder<SMAppDelegate> *appDelegate = (UIResponder<SMAppDelegate> *)[[UIApplication sharedApplication] delegate];
            UIViewController<SMNavigation> *navigation = (UIViewController<SMNavigation> *)[appDelegate navigationComponent];
            UIViewController *component = [navigation componentAtIndex:[indexPath row]];
            
            [strongSelf transitionToViewController:component animated:NO];
            
            /*
            // Prevent visual display bug with cell dividers
            [strongSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [strongSelf.tableView reloadData];
            });
            */
        }];
        
        [self.tableView registerClass:[SMTableCell class] forCellReuseIdentifier:CellIdentifier];
        self.tableView.dataSource = self.arrayDataSource;
        self.tableView.delegate = self.arrayDataSource;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor orangeColor];
    self.tableView.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.25];
}

- (void)transitionToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /*
    self.paneRevealLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/Left_Reveal_Icon"]
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(dynamicsDrawerRevealLeftBarButtonItemTapped:)];
    */
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/Menu_Icon"]
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(dynamicsDrawerRevealLeftBarButtonItemTapped:)];
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *topViewController = [(UINavigationController *)viewController topViewController];
        topViewController.navigationItem.leftBarButtonItem = item;
    } else {
        viewController.navigationItem.leftBarButtonItem = item;
    }
    
    
    [self.dynamicsDrawer setPaneViewController:viewController animated:animated completion:^{
        [self.dynamicsDrawer setPaneState:MSDynamicsDrawerPaneStateClosed animated:YES allowUserInterruption:YES completion:nil];
    }];
}

- (void)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawer setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionLeft animated:YES allowUserInterruption:YES completion:nil];
}

@end
