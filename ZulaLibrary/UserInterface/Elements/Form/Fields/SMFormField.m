//
//  SMFormField.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormField.h"

@implementation SMFormField
{
    NSString *_label;
}
@synthesize name, labelWidth, field, validators, height;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.name = [attributes objectForKey:kFormFieldName];
        self.label = [attributes objectForKey:kFormFieldLabel];
        self.labelWidth = 0;
    }
    return self;
}

#pragma mark - getter/setters

- (void)setLabel:(NSString *)label
{
    _label = label;
}

- (NSString *)label
{
    // if label is empty or not set, return the name
    if (!_label || [_label isEqualToString:@""])
        return self.name;
    
    return _label;
}

#pragma mark - methods

// should be overridden
- (BOOL)isValid
{
    return YES;
}

// must be overridden
- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
