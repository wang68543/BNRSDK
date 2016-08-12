//
//  UIImage+BNRAdditions.m
//  BNRSDKLib
//
//  Created by JustinYang on 8/12/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import "UIImage+BNRAdditions.h"

@implementation UIImage (BNRAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
