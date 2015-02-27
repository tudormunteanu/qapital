//
//  TMDataManager.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "AFNetworking.h"
#import "TMDataManager.h"
#import "TMGoalFormatter.h"
#import "TMUserFormatter.h"
#import "TMUser.h"

@interface TMDataManager ()

@property (nonatomic, strong) NSString                      *domain;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation TMDataManager

#pragma mark - Lifecycle

- (instancetype)init {
    
    self = [super init];
    if (self) {
    
        self.domain = @"http://qapital-ios-testtask.herokuapp.com";
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //
        // TODO: Ask the server peeps why the content-type is text/html and not application/json
        //
        NSSet *acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
        self.manager = manager;
    }
    return self;
}

#pragma mark - Public

+ (TMDataManager *)sharedManager {
    
    static TMDataManager *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        
        sharedInstance = [[TMDataManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)getGoals:(void (^)(NSArray *goals))completionBlock failure:(void (^)(NSError *error))failureBlock {
    
    NSString *path = [self urlStringForPath:@"/savingsgoals"];
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //
        // TODO: add more error handling in the case responseObject is not a dict
        //
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        TMGoalFormatter *formatter = [[TMGoalFormatter alloc] init];
        NSArray *goals = [formatter goalsFromArray:responseDict[@"savingsGoals"]];
        completionBlock(goals);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failureBlock(error);
    }];
}

- (void)getUserForId:(NSString *)userId completionBlock:(void (^)(TMUser *user))completionBlock failure:(void (^)(NSError *error))failureBlock {
    
    NSString *path = [self urlStringForPath:[NSString stringWithFormat:@"/users/%@", userId]];
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        //
        // TODO: add more error handling in the case responseObject is not a dict
        //
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        TMUserFormatter *formatter = [[TMUserFormatter alloc] init];
        TMUser *user = [formatter userFromDict:responseDict];
        completionBlock(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failureBlock(error);
    }];
}

#pragma mark - Private

- (NSString *)urlStringForPath:(NSString *)path {
    
    return [NSString stringWithFormat:@"%@%@", self.domain, path];
}

@end
