//
//  SMListPage.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListPage.h"
#import "SMListItem.h"

@implementation SMListPage
@synthesize title = _title,
backgroundUrl = _backgroundUrl,
itemBackgroundUrl = _itemBackgroundUrl,
listingStyle = _listingStyle,
items = _items;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        [self setTitle:[attributes objectForKey:kModelListPageTitle]];
        
        _backgroundUrl = [self urlFromAttribute:[attributes objectForKey:kModelListPageBackgroundImageUrl]];
        _itemBackgroundUrl = [self urlFromAttribute:[attributes objectForKey:kModelListPageItemBackgroundImageUrl]];
        
        // default listing style is table
        NSString *theListingStyle = [attributes objectForKey:kModelListPageListType];
        if (!theListingStyle || [theListingStyle isEqualToString:@"table"]) {
            _listingStyle = SMListingStyleTable;
        } else if ([theListingStyle isEqualToString:@"box"]) {
            _listingStyle = SMListingStyleBox;
        } else if ([theListingStyle isEqualToString:@"group"]) {
            _listingStyle = SMListingStyleGroup;
        }
        
        NSArray *theItems = (NSArray *)[attributes objectForKey:@"items"];
        
        // items are initially an empty array
        if ([theItems count] == 0) {
            _items = [NSArray array];
        } else {
            NSMutableArray *itemsArr = [NSMutableArray arrayWithCapacity:[theItems count]];
            for (NSDictionary *itemDict in theItems) {
                SMListItem *item = [[SMListItem alloc] initWithAttributes:itemDict];
                [itemsArr addObject:item];
            }
            _items = [NSArray arrayWithArray:itemsArr];
        }
    }
    return self;
}

+ (void)fetchWithUrlString:(NSString *)urlString completion:(void (^)(SMListPage *, NSError *))completion
{
    
}

@end
