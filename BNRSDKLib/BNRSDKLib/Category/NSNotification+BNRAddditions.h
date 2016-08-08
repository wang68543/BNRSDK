//
//  NSNotification+BNRAddditions.h
//  BNRSDKLib
//
//  Created by JustinYang on 8/8/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotification (BNRAddditions)

/**
 *  设置本地通知，改通知只执行1次
 *
 *  @param time      时间
 *  @param alertText 本地通知文案
 */
+(void)setLocalNotificationWithTime:(NSString *)time  andAlertText:(NSString *)alertText;
@end
