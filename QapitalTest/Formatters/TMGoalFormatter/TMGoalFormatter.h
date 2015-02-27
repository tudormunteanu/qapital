//
//  TMGoalFormatter.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMGoalFormatter : NSObject

/**
 Returns an array of Goal models, from a list of dictionaries like the data returned by the API.
 */
- (NSArray *)goalsFromArray:(NSArray *)rawGoals;

@end
