//
//  SMCollectionStrategy.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 19/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMListViewController.h"

@interface SMCollectionStrategy : NSObject <SMListViewStrategy, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewLayout *layout;

@end
