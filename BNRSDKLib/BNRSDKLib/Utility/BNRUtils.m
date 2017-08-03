//
//  Utils.m
//  BNRSDKLib
//
//  Created by JustinYang on 2017/7/31.
//  Copyright © 2017年 JustinYang. All rights reserved.
//

#import "BNRUtils.h"

@implementation BNRUtils
+(NSString *)timeIntCovertToTimeStr:(NSInteger)time withPlaceString:(NSString *)place{
    NSInteger value = time;
    if (value < 0) {
        return place;
    }else{
        NSInteger min = value%60;
        NSInteger hour = value/60;
        if (hour>0) {
            return [NSString stringWithFormat:@"%ld小时%02ld分",hour,min];
        }else if(min >= 0){
            return [NSString stringWithFormat:@"%ld分",min];
        }else{
            return place;
        }
    }
}

+(NSString *)timeIntCovertToSecAndMin:(NSInteger)second withPlaceString:(NSString *)place{
    if (second < 0) {
        return place;
    }else{
        NSInteger sec = second%60;
        NSInteger min = second/60;
        if (min>0) {
            return [NSString stringWithFormat:@"%ld分%02ld秒",min,sec];
        }else if(sec >= 0){
            return [NSString stringWithFormat:@"%ld秒",sec];
        }else{
            return place;
        }
    }
}
@end
