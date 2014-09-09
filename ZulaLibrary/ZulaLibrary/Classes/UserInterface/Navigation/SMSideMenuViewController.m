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
#import "SMAppDescription.h"
#import "SMNavigationDescription.h"
#import "UIImageView+WebCache.h"
#import "UIColor+ZulaAdditions.h"


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
        
        /*
        UIView *selectedBackgroundView = [UIView new];
        selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
        self.selectedBackgroundView = selectedBackgroundView;
        
        UIView *backgoundView = [UIView new];
        backgoundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
        self.backgroundView = backgoundView;
         */
    }
    return self;
}

@end


static NSString *const CellIdentifier = @"MenuCellIdentifier";
static NSString *const LogoCellIdentifier = @"MenuLogoCellIdentifier";

@interface SMSideMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) NSString *logoUrl;
@property (nonatomic, strong) NSString *backgroundImageUrl;

@property (nonatomic, strong) UIColor *textColor;

- (void)applyAppearances;

@end

@implementation SMSideMenuViewController
{
    BOOL isInitial;
}

- (instancetype)initWithComponentDesciptions:(NSArray *)componentDescriptions
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        isInitial = YES;
        
        self.items = componentDescriptions;
        
        SMNavigationDescription *navDesc = [[SMAppDescription sharedInstance] navigationDescription];
        self.logoUrl = [navDesc.data objectForKey:@"sidebar_top_image"];
        self.backgroundImageUrl = [navDesc.data objectForKey:@"sidebar_bg_image"];
        
        if ([self.logoUrl isEqualToString:@""]) self.logoUrl = nil;
        if ([self.backgroundImageUrl isEqualToString:@""]) self.backgroundImageUrl = nil;
        
        [self.tableView registerClass:[SMTableCell class] forCellReuseIdentifier:CellIdentifier];
        [self.tableView registerClass:[SMSideMenuLogoCell class] forCellReuseIdentifier:LogoCellIdentifier];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    [self applyAppearances];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (isInitial) {
        // select the 1st item
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
        isInitial = NO;
    }
}

- (void)applyAppearances
{
    SMNavigationDescription *navDesc = [[SMAppDescription sharedInstance] navigationDescription];
    NSDictionary *appearances = [[navDesc.data objectForKey:@"appearance"] objectForKey:@"sidebar"];
    
    if (appearances) {
        // text color
        self.textColor = ([appearances objectForKey:@"text_color"]) ?
        [UIColor colorWithHex:[appearances objectForKey:@"text_color"]] : [UIColor whiteColor];
        
        // background color
        NSDictionary *bgImageDict = [appearances objectForKey:@"bg_image"];
        if (bgImageDict) {
            NSString *bgColorHex = [bgImageDict objectForKey:@"bg_color"];
            UIColor *bgColor = (bgColorHex) ? [UIColor colorWithHex:bgColorHex] : [UIColor colorWithHex:@"#006EFF"];
            self.tableView.backgroundColor = bgColor;
        }
    }
    
    // background image
    if (self.backgroundImageUrl) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:self.view.frame];
        [bgImage sd_setImageWithURL:[NSURL URLWithString:self.backgroundImageUrl]];
        
        // background image alignment
        NSDictionary *bgImageDict = [appearances objectForKey:@"bg_image"];
        if (bgImageDict) {
            NSString *alignmentOption = [bgImageDict objectForKey:@"alignment"];
            if (alignmentOption) {
                if ([alignmentOption isEqualToString:@"aspect_fill"]) {
                    bgImage.contentMode = UIViewContentModeScaleAspectFill;
                } else if ([alignmentOption isEqualToString:@"aspect_fit"]) {
                    bgImage.contentMode = UIViewContentModeScaleAspectFit;
                } else {
                    bgImage.contentMode = UIViewContentModeCenter;
                }
            }
        }
        
        self.tableView.backgroundView = bgImage;
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    
    //self.tableView.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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


#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                    forIndexPath:indexPath];
    
    id item = [self.items objectAtIndex:[indexPath row]];
    SMComponentDescription *desc = (SMComponentDescription *)item;
    cell.textLabel.text = desc.title;
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIResponder<SMAppDelegate> *appDelegate = (UIResponder<SMAppDelegate> *)[[UIApplication sharedApplication] delegate];
    UIViewController<SMNavigation> *navigation = (UIViewController<SMNavigation> *)[appDelegate navigationComponent];
    UIViewController *component = [navigation componentAtIndex:[indexPath row]];
    
    [self transitionToViewController:component animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), 70.0f)];
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 260.0f, 50.0f)];
    [logo sd_setImageWithURL:[NSURL URLWithString:self.logoUrl]];
    logo.contentMode = UIViewContentModeCenter;
    
    SMNavigationDescription *navDesc = [[SMAppDescription sharedInstance] navigationDescription];
    NSDictionary *appearances = [[navDesc.data objectForKey:@"appearance"] objectForKey:@"sidebar"];
    if (appearances) {
        // background color
        NSDictionary *topImageDict = [appearances objectForKey:@"top_image"];
        if (topImageDict) {
            NSString *bgColorHex = [topImageDict objectForKey:@"bg_color"];
            UIColor *bgColor = (bgColorHex) ? [UIColor colorWithHex:bgColorHex] : [UIColor clearColor];
            logo.backgroundColor = bgColor;
        }
        
        /*
        // alignment
        NSString *alignmentOption = [topImageDict objectForKey:@"alignment"];
        if (alignmentOption) {
            if ([alignmentOption isEqualToString:@"aspect_fill"]) {
                logo.contentMode = UIViewContentModeScaleAspectFill;
            } else if ([alignmentOption isEqualToString:@"aspect_fit"]) {
                logo.contentMode = UIViewContentModeScaleAspectFit;
            } else {
                logo.contentMode = UIViewContentModeCenter;
            }
        }
         */
    }
    
    [headerView addSubview:logo];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (self.logoUrl) ? 70.0f : 0.0f;
}

@end
