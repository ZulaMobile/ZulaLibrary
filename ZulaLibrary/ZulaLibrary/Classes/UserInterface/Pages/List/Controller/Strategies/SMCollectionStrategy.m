//
//  SMCollectionStrategy.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 19/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMCollectionStrategy.h"
#import "ZulaLibrary.h"
#import "SMSummaryLayout.h"
#import "SMListPage.h"
#import "UIImageView+WebCache.h"
#import "SMSummaryCollectionCell.h"
#import "SMListItem.h"


static NSString *SummaryCollectionCellIdentifier = @"SummaryCollectionCellIdentifier";
static NSString *SummaryCollectionImageCellIdentifier = @"SummaryCollectionImageCellIdentifier";


@interface SMCollectionStrategy () <SMLayoutDelegate>

@end


@implementation SMCollectionStrategy
@synthesize controller;

- (id)initWithListViewController:(SMListViewController *)aListViewController
{
    self = [super init];
    if (self) {
        self.controller = aListViewController;
        
        // set the default layout
        self.layout = [[SMSummaryLayout alloc] init];
        [(SMSummaryLayout *)self.layout setDelegate:self];
    }
    return self;
}

- (void)setup
{
    // screen size
    CGRect fullSize ;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        fullSize = CGRectMake(0, 0,
                              CGRectGetWidth(self.controller.view.frame),
                              CGRectGetHeight(self.controller.view.frame));
    } else {
        fullSize = CGRectMake(0, 0,
                              CGRectGetWidth(self.controller.view.frame),
                              CGRectGetHeight(self.controller.view.frame) - CGRectGetHeight(self.controller.navigationController.navigationBar.frame));
    }
    
    // create collection view
    self.collectionView = [[UICollectionView alloc] initWithFrame:fullSize collectionViewLayout:self.layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleAll;
    [self.collectionView registerClass:[SMSummaryCollectionCell class] forCellWithReuseIdentifier:SummaryCollectionCellIdentifier];
    [self.collectionView registerClass:[SMSummaryCollectionImageCell class] forCellWithReuseIdentifier:SummaryCollectionImageCellIdentifier];
    
    // add views to main view
    [self.controller.view addSubview:self.collectionView];
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    
    // ui changes
    if (listPage.backgroundUrl) {
        UIImageView *background = [[UIImageView alloc] init];
        [background sd_setImageWithURL:listPage.backgroundUrl];
        [self.collectionView setBackgroundView:background];
    } else {
        self.collectionView.backgroundColor = [UIColor clearColor];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - collection view delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    if ([[listPage images] count] > 0)
        return [listPage.items count] + 1;
    
    return [listPage.items count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get the item for the cell
    SMListPage *listPage = (SMListPage *)self.controller.model;
    SMListItem *item = [listPage.items objectAtIndex:[indexPath row]];
    
    if (item.imageUrl) {
        SMSummaryCollectionCell *cell =
        (SMSummaryCollectionCell *)[aCollectionView dequeueReusableCellWithReuseIdentifier:SummaryCollectionCellIdentifier
                                                                              forIndexPath:indexPath];
        cell.title.text = item.title;
        cell.summary.text = item.subtitle;
        cell.backgroundColor = [UIColor redColor];
        return cell;
    } else {
        SMSummaryCollectionImageCell *cell =
        (SMSummaryCollectionImageCell *)[aCollectionView dequeueReusableCellWithReuseIdentifier:SummaryCollectionImageCellIdentifier
                                                                                   forIndexPath:indexPath];
        cell.title.text = item.title;
        cell.summary.text = item.subtitle;
        [cell.image sd_setImageWithURL:item.imageUrl];
        cell.backgroundColor = [UIColor greenColor];
        return cell;
    }
}

#pragma mark - collection view data source

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [aCollectionView cellForItemAtIndexPath:indexPath];
}

#pragma mark - summary layout delegate

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SMListPage *listPage = (SMListPage *)self.controller.model;
    if (listPage.items && [listPage.items count] > [indexPath row]) {
        SMListItem *item = [listPage.items objectAtIndex:[indexPath row]];
        if (item.imageUrl) {
            return CGSizeMake(320.0f, 180.0f + 30.0f + 20.0f);
        } else {
            CGSize summarySize = [item.subtitle sizeWithFont:[UIFont systemFontOfSize:13.0f]
                                           constrainedToSize:CGSizeMake(320.0f, 999.0f)
                                               lineBreakMode:NSLineBreakByWordWrapping];
            //return CGSizeMake(320.0f, 30.0f + 20.0f + summarySize.height);
            return CGSizeMake(320.0f, 30.0f + 20.0f + 40.0f);
        }
    }
    
    return CGSizeMake(0.0f, 0.0f);
}

@end
