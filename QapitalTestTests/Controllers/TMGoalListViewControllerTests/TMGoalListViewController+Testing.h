//
//  TMGoalListViewController+Testing.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 01/03/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "TMGoalListViewController.h"

@class TMDataManager;

@interface TMGoalListViewController (Testing) <UITableViewDataSource, UICollectionViewDataSource>

@property (nonatomic, strong) TMDataManager *dataManager;
@property (nonatomic, strong) NSArray       *goals;
@property (nonatomic, strong) UITableView   *tableView;

@end
