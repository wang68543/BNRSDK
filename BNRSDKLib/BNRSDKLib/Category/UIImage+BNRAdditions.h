//
//  UIImage+BNRAdditions.h
//  BNRSDKLib
//
//  Created by JustinYang on 8/12/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BNRAdditions)
/**
 *  get Image according to Color
 *
 *  @param color 
 *
 *  @return
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
