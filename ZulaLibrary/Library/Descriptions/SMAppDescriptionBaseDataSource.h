//
//  SMAppDescriptionDataSource.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMAppDescription.h"
#import "SMValidator.h"

/**
 *  Base data source class. A data source fetches the necessary data from a source.
 *  The data is the core application data which typically includes the app title, appearances
 *  and components.
 *
 *  All data source implementations must be a subclass of this class
 */
@interface SMAppDescriptionBaseDataSource : NSObject <SMAppDescriptionDataSource, SMValidator>

@end
