//
//  TMGoalView.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "Masonry.h"
#import "TMGoalView.h"

@interface TMGoalView ()

@property (nonatomic, strong) UIImageView          *backgroundImageView;
@property (nonatomic, strong) UIImageView          *topImageView;

@end

@implementation TMGoalView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubviews];
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - Public

- (void)reloadData {
    
    NSURL *imageURL = [self.dataSource imageURLForGoalView:self];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:imageURL];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];

    weakify(self);
    [self.backgroundImageView setImageWithURLRequest:request
                                    placeholderImage:nil
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                 
                                                 strongify(weakSelf);
                                                 [strongSelf.backgroundImageView setImage:image];
                                                 [strongSelf blurrView:strongSelf.backgroundImageView];
    }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
                                                 NSLog(@"   ");
    }];
    [self.topImageView setImageWithURL:imageURL];
}

#pragma mark - Private

- (void)setupSubviews {
    
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backgroundImageView];
    weakify(self)
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.edges.equalTo(strongSelf);
    }];
    
    static const CGFloat topImageHeight = 320;
    
    self.topImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        strongify(weakSelf);
        make.left.equalTo(strongSelf.mas_left);
        make.right.equalTo(strongSelf.mas_right);
        make.top.equalTo(@(0));
        make.height.equalTo(@(topImageHeight));
    }];
}

- (void)blurrView:(UIView *)originalView {
    
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = originalView.bounds;
    [originalView addSubview:effectView];
}

@end