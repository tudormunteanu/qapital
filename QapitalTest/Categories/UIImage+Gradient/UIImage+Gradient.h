//
//  UIImage+Gradient.h
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Gradient)

- (void)gradientWithStartColor:(UIColor *)color1 endColor:(UIColor *)color2 completionBlock:(void (^)(UIImage *gradientImage))completionBlock;

@end
