//
//  SMComponentDescription.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMComponentDescription.h"
#import "SMAppDescription.h"
#import "NSDictionary+SMAdditions.h"

@implementation SMComponentDescription

@synthesize type = _type;
@synthesize title = _title;
@synthesize slug = _slug;
@synthesize url = _url;
@synthesize appearance = _apperance;
@synthesize contents = _contents;
@synthesize index = _index;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _type = [attributes objectForKey:@"type"];
        _title = [attributes objectForKey:@"title"];
        _slug = [attributes objectForKey:@"slug"];
        _url = [attributes objectForKey:@"url"];
        _index = 0; // default is zero
        
        // try to understand if the contents is a url
        if (_url) {
            _contents = _url; // backward compatibility
        } else {
            id rawContents = [attributes objectForKey:@"contents"];
            _contents = ([rawContents isKindOfClass:[NSDictionary class]]) ? rawContents : [NSURL URLWithString:rawContents];
        }
        
        // merge with app wide apperances
        NSDictionary *appAppearances = [[SMAppDescription sharedInstance] appearance];
        _apperance = [NSDictionary dictionaryByMerging:appAppearances
                                                  with:[attributes objectForKey:@"appearance"]];
    }
    return self;
}

- (BOOL)hasDownloadableContents
{
    if ([_contents isKindOfClass:[NSString class]]) {
        NSString *url = (NSString *)_contents;
        return [NSURL URLWithString:url] != nil;
    }
    return NO;
}

@end
