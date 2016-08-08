//
//  NSNotification+BNRAddditions.m
//  BNRSDKLib
//
//  Created by JustinYang on 8/8/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import "NSNotification+BNRAddditions.h"
#import "NSDate+SSToolkitAdditions.h"
@implementation NSNotification (BNRAddditions)

+(void)setLocalNotificationWithTime:(NSString *)time  andAlertText:(NSString *)alertText{
    if (time == nil || time.length <= 0) {
        return;
    }
    if ([NSDate betweenSecondWithStartTime:time EndTime:[[NSDate alloc] LocalTimeISO8601String]]<0) {
        return;
    }
    NSDate *date = [NSDate getDateStr:time withTimeZone:[NSTimeZone localTimeZone]];
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    noti.fireDate = date;
    noti.alertBody = alertText;
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound
                                                categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    
}
@end
