//
//  TMGoalFormatter.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <DCKeyValueObjectMapping/DCKeyValueObjectMapping.h>
#import <DCKeyValueObjectMapping/DCParserConfiguration.h>
#import <DCKeyValueObjectMapping/DCObjectMapping.h>
#import "TMGoalFormatter.h"
#import "TMGoal.h"

@implementation TMGoalFormatter

- (NSArray *)goalsFromArray:(NSArray *)rawGoals {
    
    NSMutableArray *finalGoals = [NSMutableArray array];
    for (NSDictionary *goalDict in rawGoals) {
        
        //
        // Key/value mapping to convert from an NSDictionary to TMGoal
        //
        DCObjectMapping *idToGoalId = [DCObjectMapping mapKeyPath:@"id" toAttribute:@"goalId" onClass:[TMGoal class]];
        
        DCParserConfiguration *config = [DCParserConfiguration configuration];
        [config addObjectMapping:idToGoalId];

        DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[TMGoal class] andConfiguration:config];
        TMGoal *goal = [parser parseDictionary:goalDict];
        [finalGoals addObject:goal];
    }
    return [NSArray arrayWithArray:finalGoals];
}

@end
