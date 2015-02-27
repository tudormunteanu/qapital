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
    
    static const CGFloat progressOffsetY = 22;
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [progressView setProgress:0.8f animated:YES];
    progressView.trackTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f];
    progressView.progressTintColor = [UIColor whiteColor];
    [self.contentView addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.centerX.equalTo(strongSelf.contentView.mas_centerX);
        make.centerY.equalTo(strongSelf.contentView.mas_centerY).with.offset(progressOffsetY);
        make.width.equalTo(strongSelf.contentView.mas_width).multipliedBy(0.8f);
    }];
}

@end
