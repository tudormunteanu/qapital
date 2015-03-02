//
//  TMUserFormatterTests.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 28/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "Kiwi.h"
#import "TMGoal.h"
#import "TMGoalFormatter.h"
#import <UIKit/UIKit.h>

SPEC_BEGIN(TMGoalFormatterTests)

describe(@"test TMGoalFormatter", ^{
    
    it(@"should initialise", ^{
    
        TMGoalFormatter *formatter = [[TMGoalFormatter alloc] init];
        [[formatter should] beNonNil];
    });
    
    it(@"should create TMGoal object from a NSArray of NSDictionary objects", ^{
        
        NSDictionary *dict = @{@"goalImageURL": @"http://google.com/image.png",
                               @"userId": @(70),
                               @"targetAmount": @(500.0f),
                               @"currentBalance": @(200.0f),
                               @"status": @"active",
                               @"name": @"Buy a plane",
                               @"id": @(1),
                               @"connectedUsers": @[@10]};
        
        NSArray *rawGoals = @[dict];
        
        TMGoalFormatter *formatter = [[TMGoalFormatter alloc] init];
        NSArray *goals = [formatter goalsFromArray:rawGoals];
        TMGoal *goal = goals[0];
    
        [[goal.name should] equal:@"Buy a plane"];
        [[goal.connectedUsers should] equal:@[@10]];
    });
});

SPEC_END
