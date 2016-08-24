//
//  UIColor+BNRAdditions.m
//  BNRSDKLib
//
//  Created by JustinYang on 8/24/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import "UIColor+BNRAdditions.h"

@implementation UIColor (BNRAdditions)
+(NSUInteger)getRGBValueWithColor:(UIColor *)color{
    NSUInteger hexColor = 0x00000000;
    CGColorRef colorRef = color.CGColor;
    int number = CGColorGetNumberOfComponents(colorRef);
    if (number > 3) {
        const float *rgba = CGColorGetComponents(colorRef);
        CGFloat r = rgba[0];
        CGFloat g = rgba[1];
        CGFloat b = rgba[2];
        CGFloat a = rgba[3];
        
        hexColor = (((unsigned char)(r*255+0.5))<<24)+
                    (((unsigned char)(g*255+0.5))<<16)+
                    (((unsigned char)(b*255+0.5))<<8)+
                    ((unsigned char)(a*255+0.5));
        
    }
    return hexColor;
    
}
@end
