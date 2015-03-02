//
//  TMAppearenceTests.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 02/03/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "Kiwi.h"
#import "TMAppearence.h"
#import <UIKit/UIKit.h>

SPEC_BEGIN(TMAppearenceTests)

describe(@"testing TMAppearence", ^{
    
    it(@"should initialise", ^{
        
        TMAppearence *app = [TMAppearence defaultAppearence];
        
        [[app should] beNonNil];
    });
    
    it(@"should be able to configure UIAppearence", ^{
        
        TMAppearence *app = [TMAppearence defaultAppearence];
        
        [[app should] respondToSelector:@selector(setupUIAppearance)];
    });
    
    it(@"should have non-nil properties", ^{
        
        TMAppearence *app = [TMAppearence defaultAppearence];
        
        NSArray *fonts = @[@"benton"];
        NSArray *fontSizes = @[@"10", @"16", @"32"];
        
        //
        // Xcode thinks the SEL may cause a leak, because it's unknown.
        // This warning is irrelevant at this point.
        //
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        for(NSString *fontName in fonts) {
            
            for(NSString *fontSize in fontSizes) {
                
                SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", fontName, fontSize]);
                UIFont *font = (UIFont *)[app performSelector:selector];
                [[font should] beNonNil];
            }
        }
#pragma clang diagnostic pop
    });
});

SPEC_END
