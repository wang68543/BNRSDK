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

#define kDutyOfWidth  (6*kScreenWidth/8.)
#define InitAlpha 1

const char *kLeftSideControllerKey = "BNRLeftSideController";

@interface BNRLeftSideController ()
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic) BOOL isShowLeftView;
@property (nonatomic) int hitWidth;
@end

@implementation BNRLeftSideController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _hitWidth = 50;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);

    leftControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,-kScreenWidth/2.,0);
    
    self.maskView.alpha = InitAlpha;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:NO];
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
        self.hitWidth = 50;
        
        leftControl = LeftView;
        mainControl = MainView;
        leftControl.leftSideController = self;
        mainControl.leftSideController = self;
        [self addChildViewController:leftControl];
        [self addChildViewController:mainControl];
        
        
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [imgview setImage:image];
        [self.view addSubview:imgview];
        
        //滑动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [mainControl.view addGestureRecognizer:pan];
        
        
        //单击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [tap setNumberOfTapsRequired:1];
        [mainControl.view addGestureRecognizer:tap];

        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipLeftHandle:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [mainControl.view addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightHanle:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [mainControl.view addGestureRecognizer:swipeRight];
        
        [self.view addSubview:leftControl.view];
        
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor grayColor];
        _maskView.alpha = InitAlpha;
        [self.view addSubview:_maskView];
        
        [self.view addSubview:mainControl.view];
        
        leftControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,-kScreenWidth/2.,0);
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
    
    CGFloat leftShiftfac = (point.x*kScreenWidth)/(2*kDutyOfWidth);
    if (point.x < kDutyOfWidth) {
        mainControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, point.x, 0);
        leftControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,-kScreenWidth/2.+leftShiftfac,0);
        self.maskView.alpha = InitAlpha*(1 - point.x/kDutyOfWidth);
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (point.x < kDutyOfWidth/2.) {
            [self showMainView];
        }else{
            [self showLeftView];
        }
        couldPan = NO;
    }
    
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded && self.isShowLeftView) {
        [self showMainView];
    }

}

- (void)swipLeftHandle:(UISwipeGestureRecognizer *)swip{
    if (swip.state == UIGestureRecognizerStateEnded && self.isShowLeftView) {
        [self showMainView];
    }
}
-(void)swipeRightHanle:(UISwipeGestureRecognizer *)swip{
    if (swip.state == UIGestureRecognizerStateEnded && self.isShowLeftView == NO) {
        [self showLeftView];
    }
}
#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformIdentity;
    leftControl.view.transform =  CGAffineTransformTranslate(CGAffineTransformIdentity,-kScreenWidth/2.,0);;
    self.maskView.alpha = InitAlpha;
    self.isShowLeftView = NO;
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,kDutyOfWidth,0.);
    leftControl.view.transform = CGAffineTransformIdentity;
    self.isShowLeftView = YES;
    self.maskView.alpha = 0;
    [UIView commitAnimations];
    
    
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

