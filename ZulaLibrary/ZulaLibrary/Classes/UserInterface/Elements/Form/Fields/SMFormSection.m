//
//  SMFormSection.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormSection.h"

@implementation SMFormSection
@synthesize fields, title;

- (id)initWithTitle:(NSString *)theTitle fields:(NSArray *)theFields
{
    self = [super init];
    if (self) {
        self.title = theTitle;
        self.fields = theFields;
    }
    return self;
}

@end
