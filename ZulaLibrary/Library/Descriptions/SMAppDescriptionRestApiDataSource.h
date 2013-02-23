//
//  SMAppDescriptionRestApiDataSource.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMAppDescription.h"

/**
 Default implementation of the data source for app description.
 Connects to the REST Server and fetches the data from there
 */
@interface SMAppDescriptionRestApiDataSource : NSObject <SMAppDescriptionDataSource>

@end
