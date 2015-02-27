//
//  UIImage+Gradient.m
//  QapitalTest
//
//  Created by Tudor Munteanu on 27/02/15.
//  Copyright (c) 2015 http://mowowstudios.com. All rights reserved.
//

#import "UIImage+Gradient.h"

@implementation UIImage (Gradient)

- (void)gradientWithStartColor:(UIColor *)color1 endColor:(UIColor *)color2 completionBlock:(void (^)(UIImage *gradientImage))completionBlock {
    
    weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        strongify(weakSelf);
        
        UIGraphicsBeginImageContextWithOptions(strongSelf.size, NO, strongSelf.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, strongSelf.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGRect rect = CGRectMake(0, 0, strongSelf.size.width, strongSelf.size.height);
        
        // Create gradient
        NSArray *colors = [NSArray arrayWithObjects:(id)color2.CGColor, (id)color1.CGColor, nil];
        CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, NULL);
        
        // Apply gradient
        CGContextDrawImage(context, rect, strongSelf.CGImage);
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, strongSelf.size.height * 0.4f), CGPointMake(0, strongSelf.size.height), 0);
        UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGGradientRelease(gradient);
        CGColorSpaceRelease(space);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
             completionBlock(gradientImage);
        });
    });
}

@end
