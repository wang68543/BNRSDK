//
//  BNRFlipNumber.m
//  BNRSDKLib
//
//  Created by JustinYang on 8/15/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import "BNRFlipNumber.h"
@interface BNRFlipNumber()
@property (nonatomic)   NSInteger value;
@end

@implementation BNRFlipNumber

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setNumber:(NSInteger)number{
//    self.text= @"00";
//    [self.layer removeAllAnimations];
//    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
//    rotationAnimation.duration = 1.0;
//    rotationAnimation.cumulative = YES;
//    self.text = [NSString stringWithFormat:@"%@",@(number)];
//    [self.layer addAnimation:rotationAnimation forKey:@"rorationAnimation"];
    number = number%1000;
    self.value = number;
    NSInteger count = number>99?3:2;
    for (int i = 0; i < count; i++) {
        NSInteger unit = number%10;
//        UILabel *label1 = [UILabel alloc]
    }
}

-(void)setIsRedPoint:(BOOL)isRedPoint{

}
@end
