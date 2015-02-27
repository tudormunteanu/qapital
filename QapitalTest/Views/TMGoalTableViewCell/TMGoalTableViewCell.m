//
//  TMGoalTableViewCell.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "Masonry.h"
#import "TMAppearence.h"
#import "TMGoalTableViewCell.h"

@interface TMGoalTableViewCell ()

@property (nonatomic, strong) TMAppearence *appearence;

@end

@implementation TMGoalTableViewCell

#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setupComponents];
        [self setupSubviews];
    }
    return self;
}

#pragma mark - Public

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

#pragma mark - Private

- (void)setupComponents {
    
    self.appearence = [TMAppearence defaultAppearence];
}

- (void)setupSubviews {
    
    //
    // Background
    //
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.backgroundImageView];
    weakify(self);
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.edges.equalTo(strongSelf.contentView);
    }];
    
    //
    // Use auto-layout on the labels
    //
    self.textLabel.textColor = kColorText;
    self.textLabel.font = self.appearence.benton32;
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        strongify(weakSelf);
        make.centerX.equalTo(strongSelf.contentView.mas_centerX);
        make.centerY.equalTo(strongSelf.contentView.mas_centerY).with.offset(-30);
    }];
    
    self.detailTextLabel.textColor = kColorText;
    self.detailTextLabel.font = self.appearence.benton16;
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.centerX.equalTo(strongSelf.textLabel.mas_centerX);
        make.top.equalTo(weakSelf.textLabel.mas_bottom);
    }];
}

@end
