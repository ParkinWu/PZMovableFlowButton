//
//  PZMoveableFlowButton.h
//  PZMovableFlowButton
//
//  Created by pzwu on 16/3/10.
//  Copyright © 2016年 pzwu. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kPZMovableFlowPadding 1                //默认5 pt边距
#define kPZMovableFlowAdsorptionDistance   100    //上下吸附距离
@class PZMoveableFlowButton;
/**
 *  浮动按钮回调Block
 */
typedef void (^ClickedHandler)(PZMoveableFlowButton * btn);
@interface PZMoveableFlowButton : UIView
/**
 *  创建浮动按钮
 *
 *  @param frame          设置浮动按钮的位置及大小
 *  @param boundary       设置浮动按钮的可活动边界，父视图坐标系为基准
 *  @param superView      父视图，在哪个视图上移动
 *  @param contentImage   按钮的内容图片
 *  @param clickedHandler 点击事件回调
 *
 *  @return 初始化，返回CTHotelMovableFlowButton实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                  AndBoundary:(CGRect)boundary
                       onView:(UIView *)superView
                 contentImage:(UIImage *)contentImage
               clickedHandler:(ClickedHandler)clickedHandler;
/**
 *  移除PZMovableFlowButton
 */
- (void)dismiss;

/**
 *  浮动按钮的当前位置，取的self.center
 */
@property (nonatomic, assign, readonly) CGPoint currentLocation;
@end
