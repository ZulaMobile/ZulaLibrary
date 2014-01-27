//
//  SMTileLayout.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMTileLayout.h"

@implementation SMTileLayout

- (id)init
{
    self = [super init];
    if (self) {
        
        self.minimumInteritemSpacing = 10.0f; // horizontal space between each item (column) in a row, default: 32.0f;
        self.minimumLineSpacing = 10.0f; // vertical space between each row, default: 32.0f
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        //self.headerReferenceSize = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? (CGSize){50, 50} : (CGSize){43, 43}; // 100
        self.headerReferenceSize = (CGSize){0, 0};
        //self.footerReferenceSize = (CGSize){44, 44}; // 88
        self.footerReferenceSize = (CGSize){0, 0};
        
        self.itemSize = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ?
        CGSizeMake(280.0f, 280.0f) : CGSizeMake((320.0f - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) / 2,
                                                (320.0f - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) / 2);
    }
    return self;
}

@end
