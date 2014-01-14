//
//  SMArrayDataSource.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 08/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMArrayDataSource.h"

@interface SMArrayDataSource ()

@property (nonatomic, copy) TableViewCellConfigureBlock cellConfigureBlock;
@property (nonatomic, copy) ItemDidSelectBlock itemDidSelectBlock;

@end

@implementation SMArrayDataSource
@synthesize items, cellConfigureBlock, cellIdentifier, itemDidSelectBlock;

- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)theItems
     cellIdentifier:(NSString *)aCelldentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
 itemDidSelectBlock:(ItemDidSelectBlock)anItemDidSelectBlock
{
    self = [super init];
    if (self) {
        self.items = theItems;
        self.cellIdentifier = aCelldentifier;
        self.cellConfigureBlock = aConfigureCellBlock;
        self.itemDidSelectBlock = anItemDidSelectBlock;
    }
    return self;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = [self.items objectAtIndex:[indexPath row]];
    cellConfigureBlock(cell, item, indexPath);
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self.items objectAtIndex:[indexPath row]];
    itemDidSelectBlock(item, indexPath);
}

@end
