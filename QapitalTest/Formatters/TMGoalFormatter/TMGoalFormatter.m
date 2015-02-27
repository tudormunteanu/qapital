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
#import <UIKit/UIKit.h>

@implementation TMGoalFormatter

- (NSArray *)goalsFromArray:(NSArray *)rawGoals {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //
    // TODO: remove force NSLocale. Forced to US to look similar to the .psd provided.
    //
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    formatter.maximumFractionDigits = 0;
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
        
        //
        // Format verbose balance and target.
        //
        formatter.numberStyle = NSNumberFormatterCurrencyStyle;
        //
        // TODO: removed hardcoded USD currency.
        //
        formatter.currencyCode = @"USD";
        NSString *formattedBalance = [formatter stringFromNumber:goal.currentBalance];
        NSString *formattedTarget = nil;
        goal.verboseBalance = [NSString stringWithFormat:@"%@ saved", formattedBalance];
        if (goal.targetAmount) {
            
            formattedTarget = [formatter stringFromNumber:goal.targetAmount];
            goal.verboseBalance = [NSString stringWithFormat:@"%@ of %@", goal.verboseBalance, formattedTarget];
        }
        
        //
        // Calculate percentage for progress bar
        //
        if (goal.targetAmount) {
            
            CGFloat perc = ([goal.currentBalance floatValue] * 100.0f)/[goal.targetAmount floatValue];
            goal.targetPercentage = @(perc);
        } else {
            
            // default to 0 if no targetAmount is set.
            goal.targetPercentage = @(0);
        }
        
        [finalGoals addObject:goal];
    }
    return [NSArray arrayWithArray:finalGoals];
}

@end
