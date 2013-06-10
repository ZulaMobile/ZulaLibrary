//
//  SMFormField.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormField.h"
#import "SMFormDescription.h"
#import "NSString+SMAdditions.h"

@implementation SMFormField
{
    NSString *_label;
}
@synthesize name, field, validators, height, delegate;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.name = [attributes objectForKey:kFormFieldName];
        self.label = [attributes objectForKey:kFormFieldLabel];
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
        return [self.name titleCaseString];
    
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

// override if there is an action
- (BOOL)hasAction
{
    return NO;
}

- (void)executeActionWithDescription:(SMFormDescription *)description
                          completion:(void(^)(NSError *error))completion
{
    // override if there is an action
}

@end