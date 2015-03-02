//
//  TMAppearence.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 Tudor Munteanu. All rights reserved.
//

#import "ColorUtils.h"
#import "TMAppearence.h"

@implementation TMAppearence

#pragma mark - Lifecycle

- (instancetype)init {
    
    self = [super init];
    if (self) {
    
        [self setupDefaults];
    }
    return self;
}


#pragma mark - Public

+ (TMAppearence *)defaultAppearence {
    
    static TMAppearence *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        
        sharedInstance = [[TMAppearence alloc] init];
    });
    
    return sharedInstance;
}

- (void)setupUIAppearance {
    
    [[UIBarButtonItem appearance] setTintColor:kColorQapitalMain];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName: self.bentonMedium16,
                                                           }];
}

#pragma mark - Private

- (void)setupDefaults {
    
    self.benton10 = [UIFont fontWithName:@"BentonSans" size:10];
    self.benton16 = [UIFont fontWithName:@"BentonSans" size:16];
    self.benton32 = [UIFont fontWithName:@"BentonSans" size:32];
    
    self.bentonMedium16 = [UIFont fontWithName:@"BentonSans-Medium" size:16];
    
    self.bentonBold32 = [UIFont fontWithName:@"BentonSans-Bold" size:32];
}

@end
