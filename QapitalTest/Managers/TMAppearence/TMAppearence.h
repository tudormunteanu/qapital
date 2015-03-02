//
//  TMAppearence.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 Tudor Munteanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TMAppearence : NSObject

@property (nonatomic, strong) UIFont *benton10;
@property (nonatomic, strong) UIFont *benton16;
@property (nonatomic, strong) UIFont *benton32;

@property (nonatomic, strong) UIFont *bentonMedium16;

@property (nonatomic, strong) UIFont *bentonBold32;

+ (TMAppearence *)defaultAppearence;

- (void)setupUIAppearance;

@end
