//
//  TMDataManager.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMUser;

typedef void(^GoalCompletionBlock)(NSArray *goals);
typedef void(^GoalsFailureBlock)(NSError *error);

@interface TMDataManager : NSObject

+ (TMDataManager *)sharedManager;

- (void)getGoals:(GoalCompletionBlock)completionBlock failure:(GoalsFailureBlock)failureBlock;

- (void)getUserForId:(NSString *)userId completionBlock:(void (^)(TMUser *user))completionBlock failure:(void (^)(NSError *error))failureBlock;

@end
