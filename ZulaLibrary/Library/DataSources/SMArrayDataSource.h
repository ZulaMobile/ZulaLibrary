//
//  SMArrayDataSource.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 08/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

typedef void(^TableViewCellConfigureBlock) (id cell, id item, NSIndexPath *indexPath);
typedef void (^ItemDidSelectBlock) (id item);


@interface SMArrayDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) NSArray *items;

- (id)initWithItems:(NSArray *)theItems
     cellIdentifier:(NSString *)aCelldentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
 itemDidSelectBlock:(ItemDidSelectBlock)anItemDidSelectBlock;

@end
