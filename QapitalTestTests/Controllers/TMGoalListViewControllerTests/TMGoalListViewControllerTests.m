//
//  TMGoalListViewController.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 01/03/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "Kiwi.h"
#import "TMGoal.h"
#import "TMGoalListViewController.h"
#import "TMGoalListViewController+Testing.h"
#import "TMDataManager.h"
#import <UIKit/UIKit.h>

SPEC_BEGIN(TMGoalListViewControllerTests)

describe(@"test TMGoalListViewController", ^{

    __block TMGoalListViewController *controller = nil;
    
    __block TMDataManager *mockDataManager = nil; ;
    
    afterEach(^{
        
        controller = nil;
        mockDataManager = nil;
    });
    
    it(@"should initialise", ^{
        
        controller = [[TMGoalListViewController alloc] initWithNibName:nil bundle:nil];
        [[controller should] beNonNil];
    });
    
    it(@"should conform to certain protocols", ^{

        controller = [[TMGoalListViewController alloc] initWithNibName:nil bundle:nil];
        [[controller should] conformToProtocol:@protocol(UITableViewDelegate)];
        [[controller should] conformToProtocol:@protocol(UITableViewDataSource)];
        [[controller should] conformToProtocol:@protocol(UICollectionViewDelegate)];
        [[controller should] conformToProtocol:@protocol(UICollectionViewDataSource)];
        [[controller should] conformToProtocol:@protocol(UICollectionViewDelegateFlowLayout)];
    });
    
    it(@"should have a list of goals", ^{
        
        controller = [[TMGoalListViewController alloc] initWithNibName:nil bundle:nil];
        
        mockDataManager = [TMDataManager mock];
        controller.dataManager = mockDataManager;
        [mockDataManager stub:@selector(getGoals:failure:) withBlock:^id(NSArray *params) {
            
            TMGoal *goal = [[TMGoal alloc] init];
            goal.name = @"Goal 1";
            goal.targetAmount = @100;
            goal.currentBalance = @50;
            
            GoalCompletionBlock completionBlock = [params objectAtIndex:0];
            NSArray *goals = @[goal];
            completionBlock(goals);
            return nil;
        }];
        
        //
        // Expectations with receive: are set before the actuall call.
        //
        [[controller.tableView should] receive:@selector(reloadData)];
        [[controller.goals shouldEventually] have:1];
        [controller viewDidLoad];
    });
    
    it(@"should have a number of rows", ^{
        
        controller = [[TMGoalListViewController alloc] initWithNibName:nil bundle:nil];
        
        mockDataManager = [TMDataManager mock];
        controller.dataManager = mockDataManager;
        [mockDataManager stub:@selector(getGoals:failure:) withBlock:^id(NSArray *params) {
            
            TMGoal *goal = [[TMGoal alloc] init];
            goal.name = @"Goal 1";
            goal.targetAmount = @100;
            goal.currentBalance = @50;
            
            GoalCompletionBlock completionBlock = [params objectAtIndex:0];
            NSArray *goals = @[goal];
            completionBlock(goals);
            return nil;
        }];
        [controller viewDidLoad];
        
        //
        // Check number of rows in table.
        //
        NSUInteger rows = [controller tableView:controller.tableView numberOfRowsInSection:0];
        [[theValue(rows) should] equal:theValue(1)];
    });
    
    it(@"should return a number of users, for a UICollectionView", ^{
        
        controller = [[TMGoalListViewController alloc] initWithNibName:nil bundle:nil];
        
        mockDataManager = [TMDataManager mock];
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
        [controller viewDidLoad];
        
        NSUInteger users = [controller collectionView:nil numberOfItemsInSection:0];
        [[theValue(users) should] equal:theValue(2)];
    });
});

SPEC_END