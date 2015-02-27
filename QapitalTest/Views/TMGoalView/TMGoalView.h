//
//  TMGoalView.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMGoalView;

@protocol TMGoalViewDataSource <NSObject>

- (NSURL *)imageURLForGoalView:(TMGoalView *)goalView;

@end

@interface TMGoalView : UIView

@property (nonatomic, weak  ) id<TMGoalViewDataSource> dataSource;

- (void)reloadData;

@end
