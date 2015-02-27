//
//  TMGoalTableViewCell.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMGoalTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView      *backgroundImageView;
@property (nonatomic, strong) UICollectionView *connectedUsersCollectionView;
@property (nonatomic, strong) UIProgressView   *progressView;
@property (nonatomic, strong) UILabel          *titleLabel;
@property (nonatomic, strong) UILabel          *subtitleLabel;

- (void)setBackgroundImageWithURL:(NSURL *)url;

@end
