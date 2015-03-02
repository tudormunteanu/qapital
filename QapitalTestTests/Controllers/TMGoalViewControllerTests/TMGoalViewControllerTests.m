//
//  TMGoalViewControllerTests.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 02/03/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "Kiwi.h"
#import "TMDataManager.h"
#import "TMGoal.h"
#import "TMGoalView.h"
#import "TMGoalViewController.h"
#import "TMGoalViewController+Testing.h"
#import <UIKit/UIKit.h>

SPEC_BEGIN(TMGoalViewControllerTests)

describe(@"test for TMGoalViewController", ^{
    
    it(@"should initialise", ^{
        
        TMGoalViewController *controller = [[TMGoalViewController alloc] initWithNibName:nil bundle:nil];
        
        [[controller should] beNonNil];
    });
    
    it(@"should conform to protocols", ^{
        
        TMGoalViewController *controller = [[TMGoalViewController alloc] initWithNibName:nil bundle:nil];

        [[controller should] conformToProtocol:@protocol(TMGoalViewDataSource)];
    });
    
    it(@"should retrieve one goal", ^{
        
        TMGoalViewController *controller = [[TMGoalViewController alloc] initWithNibName:nil bundle:nil];

        TMDataManager *mockDataManager = [TMDataManager mock];
        controller.dataManager = mockDataManager;
        [mockDataManager stub:@selector(getGoals:failure:) withBlock:^id(NSArray *params) {
            
            TMGoal *goal = [[TMGoal alloc] init];
            goal.name = @"Goal 1";
            goal.targetAmount = @100;
            goal.currentBalance = @50;
            goal.connectedUsers = @[@10, @12];
            
            GoalCompletionBlock completionBlock = [params objectAtIndex:0];
            NSArray *goals = @[goal];
            completionBlock(goals);
            return nil;
        }];

        [[controller.goal.name shouldEventually] equal:@"Goal 1"];
        [controller viewDidLoad];
    });
});

SPEC_END