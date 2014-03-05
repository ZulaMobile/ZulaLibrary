//
//  SMTileCell.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMTileCell.h"

@implementation SMTileCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.numberOfLines = 5;
        
        [self addSubview:self.title];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
