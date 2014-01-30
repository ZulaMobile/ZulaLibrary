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
#import "SWRevealViewController.h"


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
    SWRevealViewController *revealController = self.revealViewController;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/Menu_Icon"]
                                                             style:UIBarButtonItemStyleBordered
                                                            target:revealController
                                                            action:@selector(revealToggle:)];
    
    NSString *title = nil;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *topViewController = [(UINavigationController *)viewController topViewController];
        topViewController.navigationItem.leftBarButtonItem = item;
        title = topViewController.title;
    } else {
        viewController.navigationItem.leftBarButtonItem = item;
        title = viewController.title;
    }
    
    if ([title isEqualToString:revealController.frontViewController.title]) {
        [revealController revealToggle:revealController.frontViewController];
    } else {
        [revealController setFrontViewController:viewController animated:YES];
    }
}

@end
