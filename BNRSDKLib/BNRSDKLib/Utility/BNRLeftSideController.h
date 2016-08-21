//
//  BNRSideController.h
//  wing
//
//  Created by IT_yangjing on 15/5/18.
//  Copyright (c) 2015年 IT_yangjing. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kNotifcationShowLeft;

@class BNRLeftSideController;


@interface BNRLeftSideController : UIViewController
/**
 *  显示左视图时，主页视图右移的位置
 */
@property (nonatomic, assign) CGFloat   xShift;
/**
 *  显示左视图时，主页视图下移的位置
 */
@property (nonatomic, assign) CGFloat   yShift;

/**
 *  左边滑手势热区设置，默认100
 */
@property (nonatomic) int hitWidth;

//初始化
-(instancetype)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
             andBackgroundImage:(UIImage *)image;


//恢复位置
-(void)showMainView;

//显示左视图
-(void)showLeftView;


@end

@interface UIViewController (BNRLeftSideController)
@property (nonatomic,weak) BNRLeftSideController *leftSideController;

@end
