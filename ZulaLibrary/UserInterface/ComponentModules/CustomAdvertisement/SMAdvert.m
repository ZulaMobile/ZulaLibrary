//
//  SMAdvert.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMAdvert.h"

@implementation SMAdvert

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSString *theContentType = [dictionary objectForKey:@"content_type"];
        if ([theContentType isEqualToString:@"Image"]) {
            self.contentType = SMAdvertTypeImage;
        } else if ([theContentType isEqualToString:@"HTML"]) {
            self.contentType = SMAdvertTypeHTML;
        } else if ([theContentType isEqualToString:@"Video"]) {
            self.contentType = SMAdvertTypeVideo;
        }
        
        self.url = [dictionary objectForKey:@"url"];
        self.targetUrl = [dictionary objectForKey:@"target_url"];
        self.keywords = [dictionary objectForKey:@"keywords"];
    }
    return self;
}

@end
