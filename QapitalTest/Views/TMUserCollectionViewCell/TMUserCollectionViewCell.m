//
//  TMUserCollectionViewCell.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "Masonry.h"
#import "TMUserCollectionViewCell.h"

@implementation TMUserCollectionViewCell

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 20;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.clipsToBounds = YES;
        [self setupSubview];
    }
    return self;
}

#pragma mark - Private

- (void)prepareForReuse {
    
    self.avatarImageView.image = nil;
}

- (void)setupSubview {
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.avatarImageView];
    weakify(self);
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.edges.equalTo(strongSelf.contentView);
    }];
}


@end
