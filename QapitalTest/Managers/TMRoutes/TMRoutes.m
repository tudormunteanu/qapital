//
//  TMRoutes.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "JLRoutes.h"
#import "TMGoalViewController.h"
#import "TMRoutes.h"

@implementation TMRoutes

#pragma mark - Public

+ (void)initialise {
    
    [JLRoutes addRoute:@"/goal/view/:goalId" handler:^BOOL(NSDictionary *parameters) {
        
        NSString *goalIdString = parameters[@"goalId"];
        NSNumber *goalId = [NSNumber numberWithInteger:[goalIdString integerValue]];
        NSLog(@"=== goalId: %@", goalId);
        TMGoalViewController *goalViewController = [[TMGoalViewController alloc] initWithGoalId:goalId];
        UINavigationController *navController = (UINavigationController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        [navController pushViewController:goalViewController animated:YES];
        return YES;
    }];
}

+ (BOOL)routeURL:(NSURL *)url {
    
    return [JLRoutes routeURL:url];
}

@end
