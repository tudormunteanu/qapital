//
//  TMGoalsViewController.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 Tudor Munteanu. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "Masonry.h"
#import "TMDataManager.h"
#import "TMGoal.h"
#import "TMGoalTableViewCell.h"
#import "TMGoalsViewController.h"

static NSString *cellIdentifier = @"goalCell";

@interface TMGoalsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TMDataManager *dataManager;
@property (nonatomic, strong) NSArray       *goals;
@property (nonatomic, strong) UITableView   *tableView;

@end

@implementation TMGoalsViewController

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        [self setupComponents];
        [self setupSubviews];
        self.title = @"Savings";
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Public

#pragma mark - Private

- (void)setupComponents {
    
    self.dataManager = [TMDataManager sharedManager];
}

- (void)setupSubviews {
    
    //
    // UITableView
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 320;
    [self.view addSubview:self.tableView];
    weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.edges.equalTo(strongSelf.view);
    }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated {
    
    weakify(self);
    [self.dataManager getGoals:^(NSArray *goals) {
        
        strongify(weakSelf);
        self.goals = goals;
        [strongSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
        
    }];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.goals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMGoalTableViewCell *cell = (TMGoalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[TMGoalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    TMGoal *goal = self.goals[indexPath.row];
    NSURL *imageURL = [NSURL URLWithString:goal.goalImageURL];
    [cell.backgroundImageView setImageWithURL:imageURL];
    cell.textLabel.text = goal.name;
    cell.detailTextLabel.text = @"$1,582 saved of $3,090";
    return cell;
}

@end