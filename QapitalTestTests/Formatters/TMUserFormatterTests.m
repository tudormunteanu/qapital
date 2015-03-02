//
//  TMUserFormatterTests.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 01/03/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "Kiwi.h"
#import "TMUser.h"
#import "TMUserFormatter.h"
#import <UIKit/UIKit.h>

SPEC_BEGIN(TMUserFormatterTests)

describe(@"test TMUserFormatter", ^{
    
    it(@"should initialise", ^{
        
        TMUserFormatter *formatter = [[TMUserFormatter alloc] init];
        
        [[formatter should] beNonNil];
    });
    
    it(@"should create TMUser from NSDictionary", ^{
        
        NSDictionary *dict = @{
                               @"userId": @12,
                               @"displayName": @"Max Musterman",
                               @"avatarUrl": @"http://nasa.gov/avatar.png"
                               };
        TMUserFormatter *formatter = [[TMUserFormatter alloc] init];
        TMUser *user = [formatter userFromDict:dict];
        
        [[user should] beNonNil];
        [[user.userId should] equal:@12];
        [[user.displayName should] equal:@"Max Musterman"];
        [[user.avatarUrl should] equal:@"http://nasa.gov/avatar.png"];
    });
});

SPEC_END
