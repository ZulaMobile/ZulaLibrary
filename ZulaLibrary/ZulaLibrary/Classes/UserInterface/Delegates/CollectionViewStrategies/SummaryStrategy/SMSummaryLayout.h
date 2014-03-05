//
//  SMSummaryLayout.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 19/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMLayoutDelegate <NSObject>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SMSummaryLayout : UICollectionViewLayout

@property (nonatomic, weak) id<SMLayoutDelegate> delegate;

@end
