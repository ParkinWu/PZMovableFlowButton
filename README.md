Phone上的AssistiveTouch一样的自动吸附效果。

# 效果图

![效果图](http://7xil26.com1.z0.glb.clouddn.com/2016-03-10%2015_04_17.gif)

# do yourself
看完效果图，有兴趣自己做一个吧，也不是很难。
# 思路
主要就是位置的确定，以及`UIPanGestureRecognizer`的使用，根据当前button的不同位置，来确定应该被吸附到哪一侧。
# 接口
```

#define kPZMovableFlowPadding 1                //默认5 pt边距
#define kPZMovableFlowAdsorptionDistance   100    //上下吸附距离
@class PZMoveableFlowButton;
/**
 *  浮动按钮回调Block
 */
typedef void (^ClickedHandler)(PZMoveableFlowButton * btn);
@interface PZMoveableFlowButton : UIView
/**
 *  创建浮动按钮
 *
 *  @param frame          设置浮动按钮的位置及大小
 *  @param boundary       设置浮动按钮的可活动边界，父视图坐标系为基准
 *  @param superView      父视图，在哪个视图上移动
 *  @param contentImage   按钮的内容图片
 *  @param clickedHandler 点击事件回调
 *
 *  @return 初始化，返回CTHotelMovableFlowButton实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                  AndBoundary:(CGRect)boundary
                       onView:(UIView *)superView
                 contentImage:(UIImage *)contentImage
               clickedHandler:(ClickedHandler)clickedHandler;
/**
 *  移除PZMovableFlowButton
 */
- (void)dismiss;

/**
 *  浮动按钮的当前位置，取的self.center
 */
@property (nonatomic, assign, readonly) CGPoint currentLocation;
@end
```



