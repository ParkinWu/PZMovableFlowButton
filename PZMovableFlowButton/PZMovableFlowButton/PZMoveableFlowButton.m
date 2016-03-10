//
//  PZMoveableFlowButton.m
//  PZMovableFlowButton
//
//  Created by pzwu on 16/3/10.
//  Copyright © 2016年 pzwu. All rights reserved.
//



#import "PZMoveableFlowButton.h"


@interface PZMoveableFlowButton()
@property (nonatomic, assign) CGRect boundary;//可移动区域
@property (nonatomic, copy) ClickedHandler clickedHandler;
@end

@implementation PZMoveableFlowButton

- (instancetype)initWithFrame:(CGRect)frame
                  AndBoundary:(CGRect)boundary
                       onView:(UIView *)superView
                 contentImage:(UIImage *)contentImage
               clickedHandler:(ClickedHandler)clickedHandler {
    self = [super initWithFrame:frame];
    if (self) {
        [superView addSubview:self];
        self.boundary = boundary;
        self.clickedHandler = clickedHandler;
        
        [self initContentViewWithImage:contentImage];
        [self initGestures];
        
    }
    return self;
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)initContentViewWithImage:(UIImage *)contentImage{
    UIImageView * contentImageView = [[UIImageView alloc] initWithImage:contentImage];
    contentImageView.frame = self.bounds;
    [self addSubview:contentImageView];
}
#pragma mark - 初始化手势
- (void)initGestures {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
    [self addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    [self addGestureRecognizer:tapGesture];
}


/**
 *  如果当前button位置超出可移动边界，则重新定位，将其移动到边界内
 */
- (void)relocatPosition {
    CGRect currentframe = self.frame;
    
    
    CGFloat adsorptionDistanceTop = CGRectGetMinY(_boundary) +  kPZMovableFlowAdsorptionDistance;
    CGFloat adsorptionDistanceBottom = CGRectGetMaxY(_boundary) - kPZMovableFlowAdsorptionDistance;
    //先检测Y轴方向是否满足吸附条件
    if (self.center.y >= adsorptionDistanceBottom) {
        currentframe.origin.y = CGRectGetMaxY(_boundary) - kPZMovableFlowPadding - CGRectGetHeight(currentframe);
        currentframe = [self detectBoundary:currentframe];
        [self moveTo:currentframe];
        return;
    }
    
    if (self.center.y <= adsorptionDistanceTop) {
        currentframe.origin.y = CGRectGetMinY(_boundary) + kPZMovableFlowPadding;
        currentframe = [self detectBoundary:currentframe];
        [self moveTo:currentframe];
        return;
    }
    
    //检测X轴是否满足吸附条件
    CGFloat boundaryCenterX = (CGRectGetMaxX(_boundary) + CGRectGetMinX(_boundary)) / 2.0;
    
    if (self.center.x <= boundaryCenterX) {
        currentframe.origin.x = CGRectGetMinX(_boundary) + kPZMovableFlowPadding;
    } else {
        currentframe.origin.x = CGRectGetMaxX(_boundary) - CGRectGetWidth(currentframe) - kPZMovableFlowPadding;
    }
    //检测是否超出边界
    currentframe = [self detectBoundary:currentframe];
    [self moveTo:currentframe];
    return;
    
    
    
}
/**
 *  检测是否超出边界，超出边界后，自动吸附到最近的边界处
 *
 *  @param currentframe 当前位置
 *
 *  @return 吸附后的位置
 */
- (CGRect)detectBoundary:(CGRect)currentframe {
    //左侧出界
    if (CGRectGetMinX(self.frame) < CGRectGetMinX(_boundary) + kPZMovableFlowPadding) {
        currentframe.origin.x = CGRectGetMinX(_boundary) + kPZMovableFlowPadding;
    }
    //上边出界
    if (CGRectGetMinY(self.frame) < CGRectGetMinY(_boundary) + kPZMovableFlowPadding) {
        currentframe.origin.y = CGRectGetMinY(_boundary) + kPZMovableFlowPadding;
    }
    //右边出界
    if (CGRectGetMaxX(self.frame) > CGRectGetMaxX(_boundary) - kPZMovableFlowPadding) {
        currentframe.origin.x = CGRectGetMaxX(_boundary) - CGRectGetWidth(self.frame) -   kPZMovableFlowPadding;
    }
    //下面出界
    if (CGRectGetMaxY(self.frame) > CGRectGetMaxY(_boundary) - kPZMovableFlowPadding) {
        currentframe.origin.y = CGRectGetMaxY(_boundary) - CGRectGetHeight(self.frame) -   kPZMovableFlowPadding;
    }
    return currentframe;
    
}
/**
 *  移动到某个位置
 *
 *  @param frame
 */
- (void)moveTo:(CGRect)frame {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
    }];
}
/**
 *  重写currentLocation的getter
 *
 *  @return 返回当前button的center
 */
- (CGPoint)currentLocation {
    return self.center;
}
#pragma mark - 手势处理方法

- (void)panGestureHandler:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan translationInView:self];
        CGPoint currentCenter = self.center;
        currentCenter.x += translation.x;
        currentCenter.y += translation.y;
        self.center = currentCenter;
        [pan setTranslation:CGPointMake(0, 0) inView:self.superview];
    } else {
        [self relocatPosition];
    }
    
    
}
- (void)tapGestureHandler:(UITapGestureRecognizer *)tap {
    self.clickedHandler(self);
}
@end
