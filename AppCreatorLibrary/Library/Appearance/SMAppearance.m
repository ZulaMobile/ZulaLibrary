//
//  SMAppearance.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/6/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppearance.h"

@implementation SMAppearance
@synthesize dataSource = _dataSource;

+ (SMAppearance *)sharedInstance
{
    static SMAppearance *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SMAppearance alloc] init];
    });
    return _sharedInstance;
}

- (void)fetchAppearanceWithBlock:(void(^)(NSError *error))block
{
    
}

- (SMComponentAppearance *)componentAppearanceForModelIdentifier:(NSString *)modelIdentifier componentName:(NSString *)componentName
{
    return nil;
}


@end
