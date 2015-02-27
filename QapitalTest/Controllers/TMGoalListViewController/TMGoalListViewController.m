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
#import "TMGoalListViewController.h"

static NSString *cellIdentifier = @"goalCell";

@interface TMGoalListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TMDataManager *dataManager;
@property (nonatomic, strong) NSArray       *goals;
@property (nonatomic, strong) UITableView   *tableView;

@end

@implementation TMGoalListViewController

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.edges.equalTo(strongSelf.view);
    }];
    
    //
    // NavBar
    //
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated {
    
    weakify(self);
    [self.dataManager getGoals:^(NSArray *goals) {
        
        strongify(weakSelf);
        strongSelf.goals = goals;
        [strongSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark buttons

- (void)addButtonPressed:(UIButton *)snder {
    
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMGoal *goal = self.goals[indexPath.row];
    NSString *urlString = [NSString stringWithFormat:@"qapital://goal/view/%@", goal.goalId];
    NSURL *viewUserURL = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:viewUserURL];
}

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
    [cell setBackgroundImageWithURL:imageURL];
    cell.titleLabel.text = goal.name;
    cell.subtitleLabel.text = @"$1,582 saved of $3,090";
    return cell;
}

@end