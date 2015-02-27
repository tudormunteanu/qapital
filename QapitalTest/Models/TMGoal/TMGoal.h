//
//  TMGoal.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMGoal : NSObject

@property (nonatomic, strong) NSArray  *connectedUsers;
@property (nonatomic, strong) NSNumber *currentBalance;
@property (nonatomic, strong) NSNumber *goalId;
@property (nonatomic, strong) NSString *goalImageURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSNumber *targetAmount;
@property (nonatomic, strong) NSNumber *userId;

/**
 To check equality between 2 TMGoal objects.
 */
- (BOOL)isEqualToGoal:(TMGoal *)goal2;

@end
