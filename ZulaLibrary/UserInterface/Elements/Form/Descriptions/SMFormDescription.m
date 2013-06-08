//
//  SMFormDescription.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormDescription.h"
#import "SMFormField.h"

@implementation SMFormDescription
@synthesize fields;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSArray *raw_fields = [dictionary objectForKey:@"fields"];
        if (![raw_fields isKindOfClass:[NSArray class]]) {
            // raise an exception?
            return self;
        }
        
        NSMutableArray *fieldsArray = [NSMutableArray arrayWithCapacity:[raw_fields count]];
        for (NSDictionary *raw_field in raw_fields) {
            // create field instance
            //SMFormField *field = [SMFormFieldFactory createFormFieldFromDictionary:raw_field];
            //[fieldsArray addObject:field];
        }
        [self setFields:[NSArray arrayWithArray:fieldsArray]];
    }
    return self;
}

- (id)initWithFields:(NSArray *)formFields
{
    self = [super init];
    if (self) {
        [self setFields:formFields];
    }
    return self;
}

- (id)initWithJSONFile:(NSString *)file
{
    @throw [NSException exceptionWithName:@"Not Yet Implemented"
                                   reason:@"This class is not implemented yet"
                                 userInfo:nil];
}

- (id)initWithJSONString:(NSString *)json
{
    @throw [NSException exceptionWithName:@"Not Yet Implemented"
                                   reason:@"This class is not implemented yet"
                                 userInfo:nil];
}

- (id)initwithPlistFile:(NSString *)plistFile
{
    @throw [NSException exceptionWithName:@"Not Yet Implemented"
                                   reason:@"This class is not implemented yet"
                                 userInfo:nil];
}

@end
