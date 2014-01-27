//
//  SMLinksTilesStrategy.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMLinksTilesStrategy.h"
#import "SMTileCell.h"
#import "SMTileLayout.h"


static NSString* TilesCellIdentifier = @"LinksTilesStrategyReuseIdentifier";

@interface SMLinksTilesStrategy () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) SMTileLayout *layout;

@end

@implementation SMLinksTilesStrategy
@synthesize links;

- (id)initWithLinks:(SMLinks *)aLinksObject
{
    self = [super init];
    if (self) {
        self.layout = [[SMTileLayout alloc] init];
        
        self.links = aLinksObject;
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.links.frame
                                                 collectionViewLayout:self.layout];
        self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleAll;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        // register the cell class
        [self.collectionView registerClass:[SMTileCell class] forCellWithReuseIdentifier:TilesCellIdentifier];
        
        [self.links addSubview:self.collectionView];
    }
    return self;
}

- (void)setup
{
    
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    
}

#pragma mark - collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.links.componentTitles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SMTileCell *cell = (SMTileCell *)[collectionView dequeueReusableCellWithReuseIdentifier:TilesCellIdentifier
                                                                               forIndexPath:indexPath];
    
    NSString *title = [self.links.componentTitles objectAtIndex:[indexPath row]];
    
    // configure the cell
    [cell.title setText:title];
    
    return cell;
}

#pragma mark - collection view delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // all items are selectable
    return YES;
}

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
