//
//  Utils.m
//  BNRSDKLib
//
//  Created by JustinYang on 2017/7/31.
//  Copyright © 2017年 JustinYang. All rights reserved.
//

#import "BNRUtils.h"

@implementation BNRUtils
+(NSString *)timeIntCovertToTimeStr:(id)time withPlaceString:(NSString *)place{
    NSInteger value = 0;
    if ([time isKindOfClass:[NSNumber class]]) {
        value = [time integerValue];
    }else{
        value = (NSInteger)time;
    }

    if (value < 0) {
        return place;
    }else{
        NSInteger min = value%60;
        NSInteger hour = value/60;
        if (hour>0) {
            return [NSString stringWithFormat:@"%ld小时%02ld分",hour,min];
        }else if(min > 0){
            return [NSString stringWithFormat:@"%ld分",min];
        }else{
            return nil;
        }
    }
}
@end
