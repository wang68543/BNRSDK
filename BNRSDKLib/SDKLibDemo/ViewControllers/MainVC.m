//
//  MainVC.m
//  BNRSDKLib
//
//  Created by JustinYang on 8/10/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import "MainVC.h"
#import "BNRMacro.h"
#import "BNRLeftSideController.h"
@interface MainVC ()
@property (nonatomic,strong) UIView *testView;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.testView = [[UIView alloc] initWithFrame:self.view.bounds];
//    self.testView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:self.testView];
    
}
- (IBAction)pushLeftSide:(id)sender {
    UIViewController *left = [[UIViewController alloc] init];
    left.view.backgroundColor = [UIColor greenColor];
    UIViewController *main = [[UIViewController alloc] init];
    main.view.backgroundColor = [UIColor blueColor];
    
     BNRLeftSideController *controller = [[BNRLeftSideController alloc] initWithLeftView:left andMainView:main andBackgroundImage:nil];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)panHandle:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    if (point.x < 7*kScreenWidth/8.) {
        self.testView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, point.x
                                                             , 0);
    }
   
    NSLog(@"location point:%@",NSStringFromCGPoint([sender locationInView:self.view]));
    NSLog(@"trans point :%@",NSStringFromCGPoint([sender translationInView:self.view]));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
