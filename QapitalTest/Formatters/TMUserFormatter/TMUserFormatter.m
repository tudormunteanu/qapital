//
//  TMUserFormatter.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <DCKeyValueObjectMapping/DCKeyValueObjectMapping.h>
#import <DCKeyValueObjectMapping/DCParserConfiguration.h>
#import <DCKeyValueObjectMapping/DCObjectMapping.h>
#import "TMUserFormatter.h"
#import "TMUser.h"

@implementation TMUserFormatter

/**
 Returns an array of Goal models, from a list of dictionaries like the data returned by the API.
 */
- (TMUser *)userFromDict:(NSDictionary *)userDict {
    
    //
    // Key/value mapping to convert from an NSDictionary to TMGoal
    //
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[TMUser class]];
    TMUser *user = [parser parseDictionary:userDict];
    return user;
}

@end
