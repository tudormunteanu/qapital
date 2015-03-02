//
//  main.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 26/02/15.
//  Copyright (c) 2015 Tudor Munteanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        BOOL runningTests = NSClassFromString(@"XCTestCase") != nil;
        if (!runningTests) {

            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        } else {
         
            // Switch in UnitTest app delegate
            return UIApplicationMain(argc, argv, nil, @"TMTestAppDelegate");
        }
    }
}
