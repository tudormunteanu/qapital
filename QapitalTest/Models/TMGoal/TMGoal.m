//
//  TMGoal.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "TMGoal.h"

@implementation TMGoal

- (BOOL)isEqualToGoal:(TMGoal *)goal2 {
    
    return [self.goalId isEqualToNumber:goal2.goalId];
}

@end
