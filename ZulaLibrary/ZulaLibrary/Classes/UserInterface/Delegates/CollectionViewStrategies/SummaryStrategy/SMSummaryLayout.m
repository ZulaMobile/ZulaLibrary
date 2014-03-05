//
//  SMSummaryLayout.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 19/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMSummaryLayout.h"

@interface SMSummaryLayout ()
@property (nonatomic, strong) NSMutableArray *itemAttributes;
@property (nonatomic, assign) CGSize contentSize;
- (NSInteger)columnNumberWithSmallestOffset;
@end

@implementation SMSummaryLayout
{
    NSMutableArray *yOffsets;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 *  This is where we calculate each view elements positions.
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemAttributes = [NSMutableArray array];
    
    UIOffset itemOffset = UIOffsetMake(10.0f, 10.0f);
    CGFloat xOffset = itemOffset.horizontal;
    CGFloat totalWidth = CGRectGetWidth(self.collectionView.frame) - itemOffset.horizontal * 2;
    
    // calculate the number of columns.
    NSInteger numberOfColumns = self.collectionView.frame.size.width / 320;
    CGFloat columnSize = floorf((totalWidth - (numberOfColumns - 1) * itemOffset.horizontal) / numberOfColumns);
    yOffsets = [NSMutableArray array];
    for (int i = 0; i < numberOfColumns; i++) {
        yOffsets[i] = [NSNumber numberWithFloat:0.0f];
    }
    
    // number of sections
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) return;
    
    // for each section
    NSInteger currentColumn = 0;
    for (int section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        for (int index = 0; index < numberOfItems; index++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
            
            // determine the item size
            CGFloat itemHeight = 0.0f;
            if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
                CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
                itemHeight = itemSize.height;
            }
            
            // create the UICollectionViewLayoutAttributes. We will use them later.
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectMake(xOffset, [yOffsets[currentColumn] floatValue], columnSize, itemHeight);
            [self.itemAttributes addObject:attributes];
            
            // set the y offset for current column
            float currentYOffset = [yOffsets[currentColumn] floatValue] + itemHeight;
            yOffsets[currentColumn] = [NSNumber numberWithFloat:currentYOffset];
            
            // get the column number with smallest yOffset
            currentColumn = [self columnNumberWithSmallestOffset];
            xOffset = currentColumn * columnSize;
        }
    }
    
    // Get the last item to calculate the total height of the content
    UICollectionViewLayoutAttributes *attributes = [self.itemAttributes lastObject];
    CGFloat contentHeight = attributes.frame.origin.y + attributes.frame.size.height;
    self.contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), contentHeight);
}

- (NSInteger)columnNumberWithSmallestOffset
{
    NSInteger columnNumber = 0;
    float smallest = [yOffsets[0] floatValue];
    for (int i = 1; i < [yOffsets count]; i++) {
        CGFloat height = [[yOffsets objectAtIndex:i] floatValue];
        if (height < smallest) {
            smallest = height;
            columnNumber = i;
        }
    }
    return columnNumber;
}

- (CGSize)collectionViewContentSize
{
    return self.contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.itemAttributes objectAtIndex:[indexPath row]];
}

@end
