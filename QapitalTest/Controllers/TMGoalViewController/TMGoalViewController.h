//
//  TMGoalViewController.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "TMGoalView.h" // import done to avoid compiler warnings; other approaches are too dirty.
#import <UIKit/UIKit.h>

@interface TMGoalViewController : UIViewController

@property (nonatomic, strong, readonly) NSNumber *goalId;
@property (nonatomic, strong) TMGoalView *view;

- (instancetype)initWithGoalId:(NSNumber *)goalId NS_DESIGNATED_INITIALIZER;

@end
