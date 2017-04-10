//
//  BNRSideController.m
//  wing
//
//  Created by IT_yangjing on 15/5/18.
//  Copyright (c) 2015年 IT_yangjing. All rights reserved.
//

#import "BNRLeftSideController.h"
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#import "BNRMacro.h"
#import "UIViewController+BNRAdditions.h"
#define kDutyOfWidth  (6*kScreenWidth/8.)

#define InitAlpha 1

const char *kLeftSideControllerKey = "BNRLeftSideController";
NSString *const kNotifcationShowLeft = @"notiShowLeftView";
@interface BNRLeftSideController (){
    UIViewController * leftControl;
    UIViewController * mainControl;
    
    UIImageView * imgBackground;
    
}

@property(nonatomic,strong)UIView *maskView;
//透明度为0，当显示左边视图时，加在主视图上， 点击手势加载他上面
@property(nonatomic,strong)UIView *maskMainView;


@property (nonatomic,strong) UITapGestureRecognizer *tap;
@end

@implementation BNRLeftSideController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    leftControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,-kScreenWidth/2.,0);
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [mainControl viewWillAppear:animated];
    [self showMainView:NO];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [mainControl viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [mainControl viewDidDisappear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [mainControl viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(instancetype)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
                        andBackgroundImage:(UIImage *)image;
{
    if(self){
        
        leftControl = LeftView;
        mainControl = MainView;
        leftControl.leftSideController = self;
        mainControl.leftSideController = self;
        [self addChildViewController:leftControl];
        [self addChildViewController:mainControl];
        
        
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [imgview setImage:image];
        [self.view addSubview:imgview];
        
        _maskMainView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskMainView.backgroundColor = [UIColor whiteColor];
        _maskMainView.alpha = 0.1;
        //滑动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [mainControl.view addGestureRecognizer:pan];
        
        
        //单击手势
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.tap setNumberOfTapsRequired:1];
//        [mainControl.view addGestureRecognizer:self.tap];
        [_maskMainView addGestureRecognizer:self.tap];
        self.tap.enabled = NO;

        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipLeftHandle:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [mainControl.view addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightHanle:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [mainControl.view addGestureRecognizer:swipeRight];
        
        [self.view addSubview:leftControl.view];
        
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.alpha = InitAlpha;
//        [self.view addSubview:_maskView];
        
        [self.view addSubview:mainControl.view];
        
        leftControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,-kScreenWidth/2.,0);
        
        self.hitWidth = 100;
        self.xShift = kDutyOfWidth;
        self.yShift = 40;
        self.maskView.alpha = InitAlpha;
    }
    return self;
}



#pragma mark - 滑动手势

-(void)handlePan:(UIPanGestureRecognizer *)pan{
    static BOOL couldPan = NO;
    CGPoint point = [pan locationInView:self.view];
    CGPoint pointAtMainView = [pan locationInView:mainControl.view];
    if (pan.state == UIGestureRecognizerStateBegan) {
        if (pointAtMainView.x > self.hitWidth) {
            couldPan = NO;
            return;
        }else{
            couldPan = YES;
        }
    }
    
    if (couldPan == NO) {
        return;
    }
    
    CGFloat leftShiftfac = (point.x*kScreenWidth)/(2*self.xShift);
    CGFloat yShiftFac = self.yShift*point.x/self.xShift;
    if (point.x < self.xShift) {
        mainControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, point.x, yShiftFac);
        leftControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,-kScreenWidth/2.+leftShiftfac,0);
        self.maskView.alpha = InitAlpha*(1 - point.x/self.xShift);
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (point.x < self.xShift/2.) {
            [self showMainView:YES];
        }else{
            [self showLeftView:YES];
        }
        couldPan = NO;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded && self.isShowLeftView) {
        [self showMainView:YES];
    }
}

- (void)swipLeftHandle:(UISwipeGestureRecognizer *)swip{
    if (swip.state == UIGestureRecognizerStateEnded && self.isShowLeftView) {
        [self showMainView:YES];
    }
}
-(void)swipeRightHanle:(UISwipeGestureRecognizer *)swip{
    if (swip.state == UIGestureRecognizerStateEnded && self.isShowLeftView == NO) {
        [self showLeftView:YES];
    }
}
#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView:(BOOL)animation{
    if (animation) {
        [UIView beginAnimations:nil context:nil];
    }
    mainControl.view.transform = CGAffineTransformIdentity;
    leftControl.view.transform =  CGAffineTransformTranslate(CGAffineTransformIdentity,-kScreenWidth/2.,0);;
    self.maskView.alpha = InitAlpha;
    self.isShowLeftView = NO;
    if (animation) {
        [UIView commitAnimations];
    }
    self.tap.enabled = NO;
    if (self.maskMainView.superview) {
        [self.maskMainView removeFromSuperview];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifcationShowLeft object:@(NO)];
}

//显示左视图
-(void)showLeftView:(BOOL)animation{
    if (animation) {
        [UIView beginAnimations:nil context:nil];
    }
    mainControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,self.xShift,self.yShift);
    leftControl.view.transform = CGAffineTransformIdentity;
    self.isShowLeftView = YES;
    self.maskView.alpha = 0;
    if (animation) {
        [UIView commitAnimations];
    }
    
    [leftControl viewWillAppear:YES];
    self.tap.enabled = YES;
    [mainControl.view addSubview:self.maskMainView];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifcationShowLeft object:@(YES)];
}


@end


@implementation UIViewController (SideConteroller)

-(BNRLeftSideController *)leftSideController{
    BNRLeftSideController *sideController = objc_getAssociatedObject(self, &kLeftSideControllerKey);
    if (!sideController) {
        sideController = self.parentViewController.leftSideController;
    }
    
    return sideController;
}

-(void)setLeftSideController:(BNRLeftSideController *)leftSideController{
    objc_setAssociatedObject(self, &kLeftSideControllerKey, leftSideController, OBJC_ASSOCIATION_ASSIGN);
}
@end

