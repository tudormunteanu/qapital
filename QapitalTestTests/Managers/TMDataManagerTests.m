//
//  TMDataManagerTests.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 02/03/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "AFNetworking.h"
#import "Kiwi.h"
#import "TMDataManager.h"
#import <UIKit/UIKit.h>

@interface TMDataManager (Testing)

@property (nonatomic, strong) NSString                      *domain;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

SPEC_BEGIN(TMDataManagerTests)

describe(@"test TMDataManager", ^{
    
    it(@"should initialise", ^{
        
        TMDataManager *dataManager = [TMDataManager sharedManager];
        
        [[dataManager should] beNonNil];
    });
    
    it(@"should get the goals while making a GET request through AFNetworking", ^{
        
        TMDataManager *dataManager = [TMDataManager sharedManager];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager mock];
        dataManager.manager = manager;
        
        [[manager should] receive:@selector(GET:parameters:success:failure:)];
        [dataManager getGoals:^(NSArray *goals) {
            
        }
                      failure:^(NSError *error) {
            
        }];
    });
    
    it(@"should get the user while making a GET request throught AFNetworking", ^{
        
        TMDataManager *dataManager = [TMDataManager sharedManager];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager mock];
        dataManager.manager = manager;
        
        [[manager should] receive:@selector(GET:parameters:success:failure:)];
        [dataManager getUserForId:@"1" completionBlock:^(TMUser *user) {
            
        } failure:^(NSError *error) {
            
        }];
    });
});

SPEC_END
