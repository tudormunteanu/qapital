//
//  TMGoalViewController.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "Masonry.h"
#import "TMDataManager.h"
#import "TMGoal.h"
#import "TMGoalView.h"
#import "TMGoalViewController.h"

@interface TMGoalViewController () <TMGoalViewDataSource>

@property (nonatomic, strong) TMDataManager *dataManager;
@property (nonatomic, strong) TMGoal        *goal;

@end

@implementation TMGoalViewController

#pragma mark - Lifecycle

- (instancetype)initWithGoalId:(NSNumber *)goalId {

    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        [self setupComponents];
        _goalId = goalId;
    }
    return self;
}

#pragma mark - Public

#pragma mark - Private

- (void)setupComponents {
    
    self.dataManager = [TMDataManager sharedManager];
}

- (void)loadView {
    
    self.view = [[TMGoalView alloc] initWithFrame:CGRectZero];
    self.view.dataSource = self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    
    //
    // For the lack of an /goals/:id endpoint, I'm getting all the goals and looking for the goalId required
    //
    weakify(self);
    [self.dataManager getGoals:^(NSArray *goals) {
        
        strongify(weakSelf);
        for (TMGoal *goal in goals) {
            
            if ([goal.goalId isEqualToNumber:strongSelf.goalId]) {
                
                strongSelf.goal = goal;
                break;
            }
        }
        [strongSelf.view reloadData];
    } failure:^(NSError *error) {
        
        
    }];
}

#pragma mark - TMGoalViewDataSource

- (NSURL *)imageURLForGoalView:(TMGoalView *)goalView {

    NSURL *imageURL = [NSURL URLWithString:self.goal.goalImageURL];
    return imageURL;
}

@end
