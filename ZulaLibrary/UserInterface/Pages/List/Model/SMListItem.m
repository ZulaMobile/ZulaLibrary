//
//  SMListItem.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListItem.h"
#import "SMComponentDescription.h"

@implementation SMListItem
@synthesize title, imageUrl=_imageUrl, subtitle=_subtitle, content=_content, targetComponentName=_targetComponentName, targetComponentDescription=_targetComponentDescription, thumbnailUrl=_thumbnailUrl;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        [self setTitle:[attributes objectForKey:kModelListItemTitle]];
        
        _thumbnailUrl = [self urlFromAttribute:[attributes objectForKey:kModelListItemThumbnailUrl]];
        _imageUrl = [self urlFromAttribute:[attributes objectForKey:kModelListItemImageUrl]];
        _subtitle = [attributes objectForKey:kModelListItemSubtitle];
        _content = [attributes objectForKey:kModelListItemContent];
        if ([[attributes objectForKey:kModelListItemTargetComponent] isKindOfClass:[NSDictionary class]]) {
            _targetComponentDescription = [[SMComponentDescription alloc] initWithAttributes:[attributes objectForKey:kModelListItemTargetComponent]];
        }
        _targetComponentName = [attributes objectForKey:kModelListItemTargetComponentName];
    }
    return self;
}

- (BOOL)hasCustomTargetComponent
{
    return !(self.targetComponentDescription == nil);
}

- (BOOL)hasDefaultTargetComponent
{
    return !(self.imageUrl == nil && [self.content isEqualToString:@""]);
}

@end
