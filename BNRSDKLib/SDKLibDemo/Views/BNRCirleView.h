//
//  BNRCirleView.h
//  BNRSDKLib
//
//  Created by JustinYang on 8/12/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PointAtQuadrant) {
    PointAtQuadrant1,
    PointAtQuadrant2,
    PointAtQuadrant3,
    PointAtQuadrant4
};

typedef struct {
    PointAtQuadrant quadrant;
    CGPoint         point;
};

@interface BNRCirleView : UIView
@property (nonatomic,strong) UIColor *color1;
@property (nonatomic,strong) UIColor *color2;
@property (nonatomic,strong) UIColor *color3;

@property (nonatomic)        CGFloat duty1;
@property (nonatomic)        CGFloat duty2;
@property (nonatomic)        CGFloat duty3;

-(void)updateLayout;
-(void)animateArc;
@end
