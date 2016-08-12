//
//  BNRSideController.h
//  wing
//
//  Created by IT_yangjing on 15/5/18.
//  Copyright (c) 2015年 IT_yangjing. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BNRLeftSideController;


@interface BNRLeftSideController : UIViewController{
@private
    UIViewController * leftControl;
    UIViewController * mainControl;
    
    UIImageView * imgBackground;
    
}
@property (nonatomic,weak) id delegate;



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
