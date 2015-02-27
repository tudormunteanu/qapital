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
#import "TMUser.h"
#import "TMUserCollectionViewCell.h"

static NSString *cellIdentifier = @"goalCell";
static NSString *collectionCellIdentifier = @"collectionCell";

@interface TMGoalListViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

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
        [cell.connectedUsersCollectionView registerClass:[TMUserCollectionViewCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
        cell.connectedUsersCollectionView.userInteractionEnabled = NO;
        cell.connectedUsersCollectionView.dataSource = self;
        cell.connectedUsersCollectionView.delegate = self;
    }
    
    TMGoal *goal = self.goals[indexPath.row];
    NSURL *imageURL = [NSURL URLWithString:goal.goalImageURL];
    [cell setBackgroundImageWithURL:imageURL];
    cell.titleLabel.text = goal.name;
    cell.connectedUsersCollectionView.tag = indexPath.row;
    cell.subtitleLabel.text = goal.verboseBalance;
    CGFloat progressVal = [goal.targetPercentage floatValue]/100.0f;
    [cell.progressView setProgress:progressVal animated:NO];
    [cell.connectedUsersCollectionView reloadData];
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    TMGoal *goal = self.goals[collectionView.tag];
    return [goal.connectedUsers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMGoal *goal = self.goals[collectionView.tag];
    TMUserCollectionViewCell *cell = (TMUserCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier
                                                                                                           forIndexPath:indexPath];
    NSString *userId = goal.connectedUsers[indexPath.row];
    
    [self.dataManager getUserForId:userId completionBlock:^(TMUser *user) {
        
        NSURL *imageURL = [NSURL URLWithString:user.avatarUrl];
        [cell.avatarImageView setImageWithURL:imageURL];
        
    } failure:^(NSError *error) {
        
    }];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(40, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


@end