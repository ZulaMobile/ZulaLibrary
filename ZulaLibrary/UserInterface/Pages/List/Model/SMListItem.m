//
//  SMListItem.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListItem.h"

@implementation SMListItem
@synthesize title, imageUrl=_imageUrl, subtitle=_subtitle, content=_content, targetComponentName=_targetComponentName, targetComponentUrl=_targetComponentUrl;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        [self setTitle:[attributes objectForKey:kModelListItemTitle]];
        
        _imageUrl = [self urlFromAttribute:[attributes objectForKey:kModelListItemImageUrl]];
        _subtitle = [attributes objectForKey:kModelListItemSubtitle];
        _content = [attributes objectForKey:kModelListItemContent];
        _targetComponentUrl = [self urlFromAttribute:[attributes objectForKey:kModelListItemTargetComponentUrl]];
        _targetComponentName = [attributes objectForKey:kModelListItemTargetComponentName];
    }
    return self;
}

- (BOOL)hasTargetComponent
{
    return (self.targetComponentUrl == nil) ? NO : YES;
}

@end
