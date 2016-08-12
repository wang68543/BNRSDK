//
//  BNRMacro.h
//  BNRSDKLib
//
//  Created by JustinYang on 8/10/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#ifndef BNRMacro_h
#define BNRMacro_h

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define TrailOfView(view) (view.frame.origin.x+view.frame.size.width)
#define BottomOfView(view) (view.frame.origin.y+view.frame.size.height)
#define kScaleWidth (kScreenWidth/375)
#define kScaleHeight ((self.navigationController==nil)?(kScreenHeight/667):(self.navigationController.navigationBarHidden==NO?((kScreenHeight-64)/603):(kScreenHeight/667)))
#define kWidthAfterScale(x)  ((x)*kScaleWidth)
#define kHeightAfterScale(y) ((y)*kScaleHeight)
#define kScaleCenterX(dis,view) (kWidthAfterScale(dis)+view.bounds.size.width/2.0)
#define kScaleCenterY(dis,view) (kHeightAfterScale(dis)+view.bounds.size.height/2.0)




#define  BasicHeight  (1/iPhone5Height*(isiPhone4?iPhone5Height:kScreenHeight))
#define  BasicWeight  (1/iPhone5Weight*kScreenWidth)

#define isiPhone6 (([[UIScreen mainScreen] bounds].size.width>320)&&([[UIScreen mainScreen] bounds].size.width<=375))
#define isiPhone6Plus (([[UIScreen mainScreen] bounds].size.width>375)&&([[UIScreen mainScreen] bounds].size.width<=414))

#define isiPhone5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define isiPhone4 ([[UIScreen mainScreen] bounds].size.height <568)

#define  iPhone5Weight 320.0
#define  iPhone5Height 568.0


#define IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

#define IOS8 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")


#define CURRENT_LANGUAGE_IS_CHINESE ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"zh-Hans"]||[[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"zh-Hant"])




#define Pt(px)  (((px)/96.)*72)

#endif /* BNRMacro_h */
