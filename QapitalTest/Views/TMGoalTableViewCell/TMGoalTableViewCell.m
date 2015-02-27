//
//  TMGoalTableViewCell.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "ColorUtils.h"
#import "Masonry.h"
#import "TMAppearence.h"
#import "TMGoalTableViewCell.h"
#import "UIImage+Gradient.h"

@interface TMGoalTableViewCell ()

@property (nonatomic, strong) TMAppearence *appearence;

@end

@implementation TMGoalTableViewCell

#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupComponents];
        [self setupSubviews];
    }
    return self;
}

#pragma mark - Public

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (void)setBackgroundImageWithURL:(NSURL *)url {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    weakify(self);
    [self.backgroundImageView setImageWithURLRequest:request
                                    placeholderImage:nil
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                 
                                                 strongify(weakSelf);
                                                 [image gradientWithStartColor:kColorGradient
                                                                      endColor:[UIColor clearColor]
                                                               completionBlock:^(UIImage *gradientImage) {
                                                                   
                                                                   [strongSelf.backgroundImageView setImage:gradientImage];
                                                               }];
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                
                                                 
                                             }];
}

#pragma mark - Private

- (void)prepareForReuse {
    
    [super prepareForReuse];
    self.backgroundImageView.image = nil;
    [self.progressView setProgress:0 animated:NO];
}

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
    static const CGFloat textLabelOffsetY = -32;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = kColorText;
    self.titleLabel.font = self.appearence.benton32;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        strongify(weakSelf);
        make.centerX.equalTo(strongSelf.contentView.mas_centerX);
        make.centerY.equalTo(strongSelf.contentView.mas_centerY).with.offset(textLabelOffsetY);
    }];
    
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subtitleLabel.textColor = kColorText;
    self.subtitleLabel.font = self.appearence.benton16;
    [self.contentView addSubview:self.subtitleLabel];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.centerX.equalTo(strongSelf.titleLabel.mas_centerX);
        make.top.equalTo(strongSelf.titleLabel.mas_bottom);
    }];
    
    static const CGFloat progressOffsetY = 22.0f;
    static const CGFloat progressWidthMultiplier = 0.8f;
    static const CGFloat progressHeight = 2.0f;
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.trackTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f];
    self.progressView.progressTintColor = [UIColor whiteColor];
    [self.progressView setProgress:0 animated:NO];
    [self.contentView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.centerX.equalTo(strongSelf.contentView.mas_centerX);
        make.centerY.equalTo(strongSelf.contentView.mas_centerY).with.offset(progressOffsetY);
        make.width.equalTo(strongSelf.contentView.mas_width).multipliedBy(progressWidthMultiplier);
        make.height.equalTo(@(progressHeight));
    }];
    
    //
    // UICollectionView
    //
    static const CGFloat collectionViewWidth = 170.0f;
    static const CGFloat collectionViewHeight = 110.0f;
    static const CGFloat collectionViewBottom = -15.0f;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.connectedUsersCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.connectedUsersCollectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.connectedUsersCollectionView];
    [self.connectedUsersCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.centerX.equalTo(strongSelf.contentView.mas_centerX);
        make.width.equalTo(@(collectionViewWidth));
        make.height.equalTo(@(collectionViewHeight));
        make.bottom.equalTo(@(collectionViewBottom));
    }];
}

@end
