//
//  TMDataManager.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDataManager : NSObject

+ (TMDataManager *)sharedManager;

- (void)getGoals:(void (^)(NSArray *goals))completionBlock failure:(void (^)(NSError *error))failureBlock;

@end
