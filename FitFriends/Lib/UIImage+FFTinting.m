//
//  UIImage+FFTinting.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-16.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "UIImage+FFTinting.h"

@implementation UIImage (FFTinting)

- (UIImage *)tintedImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);

    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);

    [self drawInRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);

    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);

    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return tintedImage;
}

@end
