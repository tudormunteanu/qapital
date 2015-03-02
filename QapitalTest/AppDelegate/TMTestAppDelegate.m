//
//  TMTestAppDelegate.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 01/03/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "Masonry.h"
#import "TMTestAppDelegate.h"
#import "ColorUtils.h"

@implementation TMTestAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = kColorQapitalMain;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = 0;
    label.font = [UIFont systemFontOfSize:40];
    label.text = @"QapitalTest";
    label.textColor = kColorText;
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.window addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.equalTo(@0);
    }];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
