//
//  BNRCirleView.m
//  BNRSDKLib
//
//  Created by JustinYang on 8/12/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import "BNRCirleView.h"
#import <SAMCategories/SAMCategories.h>
#define kCirleWidth     8
#define kGradientRange  0.09

#define kStartAngle     (M_PI*(90+51)/180.)
#define kTotalAngle     (M_PI*258/180.)
@interface BNRCirleView()
/**
 *  circle ring
 */
@property (nonatomic,strong) CAShapeLayer *animateLayer;
@end
@implementation BNRCirleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.color1 = [UIColor sam_colorWithHex:@"3ad1b9"];
        self.color2 = [UIColor sam_colorWithHex:@"3d5bfb"];
        self.color3 = [UIColor sam_colorWithHex:@"c03cec"];
        
        self.duty1 = 0.33;
        self.duty2 = 0.33;
        self.duty3 = 1 - self.duty1 - self.duty2;
        
        self.animateLayer = [CAShapeLayer new];
        self.animateLayer.frame = self.bounds;
        self.animateLayer.fillColor = [UIColor clearColor].CGColor;
        self.animateLayer.lineCap = kCALineCapRound;
        self.animateLayer.lineWidth = kCirleWidth;
        self.animateLayer.strokeColor = [UIColor blackColor].CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.)
                        radius:(self.bounds.size.width/2.-kCirleWidth/2.) startAngle:kStartAngle endAngle:(kStartAngle+kTotalAngle) clockwise:YES];
        self.animateLayer.path = path.CGPath;
        self.animateLayer.strokeEnd = 0;
        
    }
    return self;
}
-(void)animateArc{
    self.animateLayer.strokeEnd = 0;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [self.animateLayer addAnimation:animation forKey:@"animation"];
    
}
/*
-(void)updateLayout{
    while (self.subviews.count) {
        [[self.subviews lastObject] removeFromSuperview];
    }
    while (self.layer.sublayers.count) {
        [[self.layer.sublayers lastObject] removeFromSuperlayer];
    }
    
    CGRect rect = self.bounds;
    CGFloat radius = (self.bounds.size.width/2.-kCirleWidth/2.);
    CGFloat startAngle = M_PI*2/3.;
    CAShapeLayer *colorLayer = [CAShapeLayer layer];
    colorLayer.frame = rect;
    [self.layer addSublayer:colorLayer];
    
    if (self.duty1 > 0 && self.duty1 < kGradientRange) {
        self.duty1 = kGradientRange;
    }
    if (self.duty2 > 0 && self.duty2 < kGradientRange) {
        self.duty2 = kGradientRange;
    }
    self.duty3 = 1 - self.duty1 - self.duty2;
    
    if (self.duty3 > 0 && self.duty3 < kGradientRange) {
        self.duty3 = kGradientRange;
        if (self.duty2 > 3*kGradientRange) {
            self.duty2 = 1-self.duty1-self.duty3;
        }else if(self.duty1 > 3*kGradientRange){
            self.duty1 = 1-self.duty2-self.duty3;
        }
    }
    
    CGFloat totalRadian = 5*M_PI/3;
    if (self.duty1 > 0) {
        CAShapeLayer *colorLayer1 = [CAShapeLayer layer];
        colorLayer1.frame = rect;
        colorLayer1.fillColor = [UIColor clearColor].CGColor;
        colorLayer1.lineCap = kCALineCapRound;
        colorLayer1.lineWidth = kCirleWidth;
        colorLayer1.strokeColor = self.color1.CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(rect.size.width/2., rect.size.height/2.)
                        radius:radius
                    startAngle:startAngle
                      endAngle:(startAngle+(self.duty1-(self.duty2>0?kGradientRange:(self.duty3>0?kGradientRange:0)))*totalRadian)
                     clockwise:YES];
        colorLayer1.path = path.CGPath;
        [colorLayer addSublayer:colorLayer1];
        
        startAngle = (startAngle+(self.duty1+(self.duty2>0?kGradientRange:(self.duty3>0?kGradientRange:0)))*totalRadian);
    }
    
    if (self.duty2 > 0){
        CAShapeLayer *colorLayer1 = [CAShapeLayer layer];
        colorLayer1.frame = rect;
        colorLayer1.fillColor = [UIColor clearColor].CGColor;
        colorLayer1.lineCap = kCALineCapRound;
        colorLayer1.lineWidth = kCirleWidth;
        colorLayer1.strokeColor = self.color2.CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(rect.size.width/2., rect.size.height/2.)
                        radius:radius
                    startAngle:startAngle
                      endAngle:(startAngle+(self.duty2-(self.duty3>0?kGradientRange:0))*totalRadian)
                     clockwise:YES];
        colorLayer1.path = path.CGPath;
        [colorLayer addSublayer:colorLayer1];
        
        startAngle = (startAngle+(self.duty2-(self.duty3>0?kGradientRange:0))*totalRadian);
    }

    if (self.duty3 > 0) {
        CAShapeLayer *colorLayer1 = [CAShapeLayer layer];
        colorLayer1.frame = rect;
        colorLayer1.fillColor = [UIColor clearColor].CGColor;
        colorLayer1.lineCap = kCALineCapRound;
        colorLayer1.lineWidth = kCirleWidth;
        colorLayer1.strokeColor = self.color3.CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(rect.size.width/2., rect.size.height/2.)
                        radius:radius
                    startAngle:startAngle
                      endAngle:(startAngle+self.duty3*totalRadian)
                     clockwise:YES];
        colorLayer1.path = path.CGPath;
        [colorLayer addSublayer:colorLayer1];
    }
    
    startAngle = M_PI*2/3.;
    CGFloat side = 2*radius*sin(kGradientRange*totalRadian);
    if (self.duty1 > 0 && self.duty2 > 0) {
        CAGradientLayer *gradient1 = [CAGradientLayer layer];
        gradient1.frame = CGRectMake(0, 0, side, side);
        gradient1.colors = @[(__bridge id)self.color1.CGColor,(__bridge id)self.color2.CGColor];
        gradient1.locations = @[@0,@1];
        gradient1.startPoint = CGPointMake(0, 0);
        gradient1.endPoint = CGPointMake(1, 0);
        [colorLayer addSublayer:gradient1];
        CGFloat tm = 3*M_PI/2.-(startAngle+self.duty1*totalRadian);//startAngle+self.duty1*totalRadian-4*M_PI/3;
        gradient1.transform = CATransform3DMakeRotation(-tm, 0, 0, 1);
        gradient1.position = CGPointMake(rect.size.width/2.- sin(tm)*radius,
                                         rect.size.height/2. - cos(tm)*radius);
//        CGPointMake(rect.size.width/2.-cos(startAngle+self.duty1*totalRadian-M_PI)*radius,
//                                         rect.size.height/2.-sin(startAngle+self.duty1*totalRadian-M_PI)*radius);
        [colorLayer addSublayer:gradient1];
    }else if(self.duty1 > 0 && self.duty3 > 0){
        CAGradientLayer *gradient1 = [CAGradientLayer layer];
        gradient1.frame = CGRectMake(0, 0, side, side);
        gradient1.colors = @[(__bridge id)self.color1.CGColor,(__bridge id)self.color3.CGColor];
        gradient1.locations = @[@0,@1];
        gradient1.startPoint = CGPointMake(0, 0);
        gradient1.endPoint = CGPointMake(1, 0);
        [colorLayer addSublayer:gradient1];
        CGFloat tm = 3*M_PI/2.-(startAngle+self.duty1*totalRadian);
        gradient1.transform = CATransform3DMakeRotation(-tm, 0, 0, 1);
        gradient1.position = CGPointMake(rect.size.width/2.- sin(tm)*radius,
                                         rect.size.height/2. - cos(tm)*radius);
        [colorLayer addSublayer:gradient1];
    
    }
    
    if(self.duty2 > 0 && self.duty3 > 0){
        CAGradientLayer *gradient1 = [CAGradientLayer layer];
        gradient1.frame = CGRectMake(0, 0, side, side);
        gradient1.colors = @[(__bridge id)self.color2.CGColor,(__bridge id)self.color3.CGColor];
        gradient1.locations = @[@0,@1];
        gradient1.startPoint = CGPointMake(0, 0);
        gradient1.endPoint = CGPointMake(1, 0);
        [colorLayer addSublayer:gradient1];
        CGFloat tm = 3*M_PI/2.-(startAngle+(self.duty1+self.duty2)*totalRadian);
        gradient1.transform = CATransform3DMakeRotation(-tm, 0, 0, 1);
        gradient1.position = CGPointMake(rect.size.width/2.- sin(tm)*radius,
                                         rect.size.height/2. - cos(tm)*radius);
        [colorLayer addSublayer:gradient1];
    }
    
    [self.layer addSublayer:colorLayer];
    colorLayer.mask = self.animateLayer;
}
*/
-(void)updateLayout{
    while (self.subviews.count) {
        [[self.subviews lastObject] removeFromSuperview];
    }
    while (self.layer.sublayers.count) {
        [[self.layer.sublayers lastObject] removeFromSuperlayer];
    }
    
    CGRect rect = self.bounds;
    CGFloat radius = (self.bounds.size.width/2.-kCirleWidth/2.);
    CGFloat startAngle = kStartAngle;
    CAShapeLayer *colorLayer = [CAShapeLayer layer];
    colorLayer.frame = rect;
    [self.layer addSublayer:colorLayer];
    
    if (self.duty1 > 0 && self.duty1 < kGradientRange) {
        self.duty1 = kGradientRange;
    }
    if (self.duty2 > 0 && self.duty2 < kGradientRange) {
        self.duty2 = kGradientRange;
    }
    self.duty3 = 1 - self.duty1 - self.duty2;
    
    if (self.duty3 > 0 && self.duty3 < kGradientRange) {
        self.duty3 = kGradientRange;
        if (self.duty2 > 3*kGradientRange) {
            self.duty2 = 1-self.duty1-self.duty3;
        }else if(self.duty1 > 3*kGradientRange){
            self.duty1 = 1-self.duty2-self.duty3;
        }
    }
    
    CGFloat totalRadian = kTotalAngle;
    if (self.duty1 > 0) {
        CAShapeLayer *colorLayer1 = [CAShapeLayer layer];
        colorLayer1.frame = rect;
        colorLayer1.fillColor = [UIColor clearColor].CGColor;
        colorLayer1.lineCap = kCALineCapRound;
        colorLayer1.lineWidth = kCirleWidth;
        colorLayer1.strokeColor = self.color1.CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(rect.size.width/2., rect.size.height/2.)
                        radius:radius
                    startAngle:startAngle
                      endAngle:(startAngle+(self.duty1)*totalRadian)
                     clockwise:YES];
        colorLayer1.path = path.CGPath;
        [colorLayer addSublayer:colorLayer1];
        
        startAngle = (startAngle+(self.duty1)*totalRadian);
    }
    
    if (self.duty2 > 0){
        CAShapeLayer *colorLayer1 = [CAShapeLayer layer];
        colorLayer1.frame = rect;
        colorLayer1.fillColor = [UIColor clearColor].CGColor;
        colorLayer1.lineCap = kCALineCapRound;
        colorLayer1.lineWidth = kCirleWidth;
        colorLayer1.strokeColor = self.color2.CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(rect.size.width/2., rect.size.height/2.)
                        radius:radius
                    startAngle:startAngle
                      endAngle:(startAngle+(self.duty2)*totalRadian)
                     clockwise:YES];
        colorLayer1.path = path.CGPath;
        [colorLayer addSublayer:colorLayer1];
        
        startAngle = (startAngle+(self.duty2)*totalRadian);
    }
    
    if (self.duty3 > 0) {
        CAShapeLayer *colorLayer1 = [CAShapeLayer layer];
        colorLayer1.frame = rect;
        colorLayer1.fillColor = [UIColor clearColor].CGColor;
        colorLayer1.lineCap = kCALineCapRound;
        colorLayer1.lineWidth = kCirleWidth;
        colorLayer1.strokeColor = self.color3.CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(rect.size.width/2., rect.size.height/2.)
                        radius:radius
                    startAngle:startAngle
                      endAngle:(startAngle+self.duty3*totalRadian)
                     clockwise:YES];
        colorLayer1.path = path.CGPath;
        [colorLayer addSublayer:colorLayer1];
    }
    
    startAngle = kStartAngle;
    CGFloat side = radius*sin(kGradientRange*totalRadian);
    if (self.duty1 > 0 && self.duty2 > 0) {
        CAGradientLayer *gradient1 = [CAGradientLayer layer];
        gradient1.frame = CGRectMake(0, 0, side, side);
        gradient1.colors = @[(__bridge id)self.color1.CGColor,(__bridge id)self.color2.CGColor];
        gradient1.locations = @[@0,@1];
        gradient1.startPoint = CGPointMake(0, 0);
        gradient1.endPoint = CGPointMake(1, 0);
        [colorLayer addSublayer:gradient1];
        CGFloat tm = 3*M_PI/2.-(startAngle+self.duty1*totalRadian);//startAngle+self.duty1*totalRadian-4*M_PI/3;
        gradient1.transform = CATransform3DMakeRotation(-tm, 0, 0, 1);
        gradient1.position = CGPointMake(rect.size.width/2.- sin(tm)*radius,
                                         rect.size.height/2. - cos(tm)*radius);
        //        CGPointMake(rect.size.width/2.-cos(startAngle+self.duty1*totalRadian-M_PI)*radius,
        //                                         rect.size.height/2.-sin(startAngle+self.duty1*totalRadian-M_PI)*radius);
        [colorLayer addSublayer:gradient1];
    }else if(self.duty1 > 0 && self.duty3 > 0){
        CAGradientLayer *gradient1 = [CAGradientLayer layer];
        gradient1.frame = CGRectMake(0, 0, side, side);
        gradient1.colors = @[(__bridge id)self.color1.CGColor,(__bridge id)self.color3.CGColor];
        gradient1.locations = @[@0,@1];
        gradient1.startPoint = CGPointMake(0, 0);
        gradient1.endPoint = CGPointMake(1, 0);
        [colorLayer addSublayer:gradient1];
        CGFloat tm = 3*M_PI/2.-(startAngle+self.duty1*totalRadian);
        gradient1.transform = CATransform3DMakeRotation(-tm, 0, 0, 1);
        gradient1.position = CGPointMake(rect.size.width/2.- sin(tm)*radius,
                                         rect.size.height/2. - cos(tm)*radius);
        [colorLayer addSublayer:gradient1];
        
    }
    
    if(self.duty2 > 0 && self.duty3 > 0){
        CAGradientLayer *gradient1 = [CAGradientLayer layer];
        gradient1.frame = CGRectMake(0, 0, side, side);
        gradient1.colors = @[(__bridge id)self.color2.CGColor,(__bridge id)self.color3.CGColor];
        gradient1.locations = @[@0,@1];
        gradient1.startPoint = CGPointMake(0, 0);
        gradient1.endPoint = CGPointMake(1, 0);
        [colorLayer addSublayer:gradient1];
        CGFloat tm = 3*M_PI/2.-(startAngle+(self.duty1+self.duty2)*totalRadian);
        gradient1.transform = CATransform3DMakeRotation(-tm, 0, 0, 1);
        gradient1.position = CGPointMake(rect.size.width/2.- sin(tm)*radius,
                                         rect.size.height/2. - cos(tm)*radius);
        [colorLayer addSublayer:gradient1];
    }
    
    [self.layer addSublayer:colorLayer];
    colorLayer.mask = self.animateLayer;
    
    
    [self animateArc];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(0, 0);
    CGPoint point3 = CGPointMake(0, 0);
    
    CGPoint center = CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.);
    CGFloat radius = (self.bounds.size.width/2.-kCirleWidth/2.);
    if (self.duty1 > 0.000001) {
        CGFloat tm = kStartAngle + self.duty1/2.*kTotalAngle;
        point1 = CGPointMake(center.x-cos(tm-M_PI)*radius,
                             center.y-sin(tm-M_PI)*radius);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        view.backgroundColor = [UIColor blueColor];
        [self addSubview:view];
        
        view.center = point1;

    }
    
    if (self.duty2 > 0.000001) {
        CGFloat tm = kStartAngle + (self.duty1+self.duty2/2.)*kTotalAngle;
        point2 = CGPointMake(center.x-cos(tm-M_PI)*radius,
                             center.y-sin(tm-M_PI)*radius);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        view.backgroundColor = [UIColor blueColor];
        [self addSubview:view];
        
        view.center = point2;
    }
    if (self.duty3 > 0.000001) {
        CGFloat tm = kStartAngle + (self.duty1+self.duty2+self.duty3/2.)*kTotalAngle;
        point3 = CGPointMake(center.x-cos(tm-M_PI)*radius,
                             center.y-sin(tm-M_PI)*radius);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        view.backgroundColor = [UIColor blueColor];
        [self addSubview:view];
        
        view.center = point3;
    }
    
}
@end
