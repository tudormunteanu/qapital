//
//  TMUserFormatter.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMUser;

@interface TMUserFormatter : NSObject

/**
 Returns a TMUser objects, from a dictionary like the data returned by the API.
 */
- (TMUser *)userFromDict:(NSDictionary *)userDict;

@end
