//
//  BNRCurBtn.m
//  BNRSDKLib
//
//  Created by JustinYang on 8/15/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import "BNRCurBtn.h"
#import <SAMCategories/SAMCategories.h>
@interface BNRCurBtn()
@property (nonatomic,strong) CAShapeLayer   *maskLayer;
@property (nonatomic,assign) CGRect         originRect;
@end
@implementation BNRCurBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.maskLayer = [CAShapeLayer layer];
//        self.maskLayer.lineWidth = 4;
//        self.maskLayer.strokeColor = [UIColor redColor].CGColor;
//        self.maskLayer.fillColor = nil;
//        
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path moveToPoint:CGPointMake(0, frame.size.height)];
//        [path addQuadCurveToPoint:CGPointMake(frame.size.width, frame.size.height)
//                     controlPoint:CGPointMake(frame.size.width/2., -frame.size.height)];
//        self.maskLayer.path = path.CGPath;
//        
//        [self.layer addSublayer:self.maskLayer];
        
        self.originRect = frame;
    }
    return self;
}

-(CGFloat)height{
    return self.frame.size.height;
}

#define kCurOriginDuty    (1/3.)//动画之前，曲线占视图的高度
-(void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 0;
    [[UIColor sam_colorWithHex:@"383068"] setFill];
    
    CGPoint startPoint = CGPointMake(0, kCurOriginDuty*self.originRect.size.height);
//    if (rect.size.height != self.originRect.size.height) { //表示正在动画
        CGFloat dy = rect.size.height - self.originRect.size.height;
        CGFloat lineUp = dy/4.;
        CGFloat curUp  = dy*3/4.;
        
        startPoint.y = startPoint.y - lineUp;
        
        [path moveToPoint:startPoint];
        
        [path addQuadCurveToPoint:CGPointMake(rect.size.width, startPoint.y)
                     controlPoint:CGPointMake(rect.size.width/2., -startPoint.y)];
        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
        [path addLineToPoint:CGPointMake(0, rect.size.height)];
        [path addLineToPoint:startPoint];
//    }
    [path fill];
    [path stroke];
}
@end
