//
//  MainVC.m
//  BNRSDKLib
//
//  Created by JustinYang on 8/10/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import "MainVC.h"
#import <SAMCategories/SAMCategories.h>
#import "BNRSDKLib.h"
#import "BNRCirleView.h"
#import "BNRFlipNumber.h"
#import "JTNumberScrollAnimatedView.h"
#import "BNRCurBtn.h"
@interface MainVC ()
@property (nonatomic,strong) UIView *testView;
@property (nonatomic,strong) dispatch_source_t timer;

@property (nonatomic,strong) UIScrollView   *scroll;

@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) BNRCurBtn *btn;
@property (weak, nonatomic) IBOutlet JTNumberScrollAnimatedView *scrollNumberView;
@end

@implementation MainVC
static BOOL isStop;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scroll.contentSize = CGSizeMake(kScreenWidth, 2*kScreenHeight);
    self.scroll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scroll];
    
    [self transparentNavigationBar];

    self.view.backgroundColor = [UIColor sam_colorWithHex:@"1a1634"];
    BNRCirleView *view1 = [[BNRCirleView alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    view1.backgroundColor = [UIColor sam_colorWithHex:@"1a1634"];
    [view1 updateLayout];
    [self.scroll addSubview:view1];

    JTNumberScrollAnimatedView *number = [[JTNumberScrollAnimatedView alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (isStop == NO) {
            int a = arc4random()%100;
            int b = arc4random()%(100-a);
            int c = 100 - a - b;
            view1.duty1 = a/100.;
            view1.duty2 = b/100.;
            view1.duty3 = c/100.;
            [view1 updateLayout];
            [view1 animateArc];
        }
        [number setValue:[NSNumber numberWithInt:(rand() % 100)]];
        [number startAnimation];
        
        self.scrollNumberView.frame = CGRectMake(150, 100, 100, 30);
        [self.scrollNumberView setValue:@89];
        [self.scrollNumberView startAnimation];
        self.scrollNumberView.backgroundColor = [UIColor redColor];
    });
    dispatch_resume(self.timer);
    
    
    
    number.textColor = [UIColor whiteColor];
    number.font = [UIFont fontWithName:@"HelveticaNeue" size:42];
    
    number.minLength = 3;
    [self.scroll addSubview:number];
    number.layer.masksToBounds = YES;
    
    [number setValue:[NSNumber numberWithInt:(rand() % 100)]];
    [number startAnimation];

    
    self.scroll.scrollEnabled = NO;
    
    
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 10, 10)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.scroll addSubview:self.redView];
    
    
    self.btn = [[BNRCurBtn alloc] initWithFrame:CGRectMake(0, kScreenHeight-100, kScreenWidth, 72)];
    [self.scroll addSubview:self.btn];
    self.btn.backgroundColor = [UIColor clearColor];
    
    
    
}
- (IBAction)pushLeftSide:(id)sender {
    isStop = isStop==NO?YES:NO;
    UIViewController *left = [[UIViewController alloc] init];
    left.view.backgroundColor = [UIColor greenColor];
    UIViewController *main = [[UIViewController alloc] init];
    main.view.backgroundColor = [UIColor blueColor];
    
     BNRLeftSideController *controller = [[BNRLeftSideController alloc] initWithLeftView:left andMainView:main andBackgroundImage:nil];
    controller.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)panHandle:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        isStop = isStop==NO?YES:NO;
        
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (isStop) {
                self.btn.frame = CGRectMake(0, kScreenHeight-100-78, kScreenWidth, 150);
            }else{
                 self.btn.frame = CGRectMake(0, kScreenHeight-100, kScreenWidth, 72);
            }
        } completion:^(BOOL finished) {
           
        }];
    }
  
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (isStop) {
            self.scroll.contentOffset = CGPointMake(0, kScreenHeight);
        }else{
            self.scroll.contentOffset = CGPointMake(0, 0);
        }
    } completion:nil];
}

@end
