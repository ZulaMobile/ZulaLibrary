//
//  SMAdvert.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SMAdvertContentType) {
    SMAdvertTypeImage,
    SMAdvertTypeHTML,
    SMAdvertTypeVideo
};


/**
 *  Advert view. Sends value changed event on closing.
 */
@interface SMAdvert : NSObject

@property (nonatomic) SMAdvertContentType contentType;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *targetUrl;

@property (nonatomic, strong) NSArray *keywords;

/**
 *  Initialize the advert from the information in given dictionary.
 *  The dictionary should have following keys:
 *   * advert_type NSString (Interstitial or Banner)
 *   * content_type NSString (Image, Video or HTML)
 *   * url NSString (The actual source of the content)
 *   * keywords NSArray (An array which has NSStrings)
 *
 *  @discussion
 *  `keywords` are the content that the advert display in higher priority.
 *  There are some special keywords like `ALL`, `NONE`, `SPLASH`.
 *
 *  @param dictionary
 *
 *  @return 
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
