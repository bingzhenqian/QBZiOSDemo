//
//  TestCAAnimationViewController.m
//  QBZTestAnimation
//
//  Created by qianbingzhen on 2018/3/13.
//  Copyright © 2018年 qian. All rights reserved.
//
//https://www.jianshu.com/p/d05d19f70bac


#import <QuartzCore/QuartzCore.h>
#import "TestCAAnimationViewController.h"
static int count = 0;
@interface TestCAAnimationViewController ()<CAAnimationDelegate>
{
    CALayer *myLayer;
}
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UIView *testView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TestCAAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testKeyFrameAnimation];
//    [self testKeyFrameAnimationPath];
    // Do any additional setup after loading the view.
    
    
    myLayer = [CALayer new];
    myLayer.frame = CGRectMake(0, 0, 300, 300);
    myLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:myLayer];

}

/*
    CAAnimation关系
        协议：    CAMediaTimingFunction//动画效果 线性/先快后慢
        子类：CAPropertyAnimation  , CATransition, CAAnimationGroup
    CAPropertyAnimation 子类：
            CABasicAnimation   //基础动画
            CAKeyframeAnimation//关键帧动画
    CABasicAnimation 子类：
            CASpringAnimation //弹簧动画
 */

- (void)testAnimation
{

}
//keyPath查询  https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/Key-ValueCodingExtensions/Key-ValueCodingExtensions.html#//apple_ref/doc/uid/TP40004514-CH12-SW8
/*
    value类型
 CGPoint         NSValue
 
 CGSize          NSValue
 
 CGRect          NSValue
 
 CATransform3D   NSValue
 
 CGAffineTransform  NSAffineTransform (OS X only)
 

 */
/*
 animationWithKeyPath的值：
 
 　 transform.scale = 比例轉換
 
 transform.scale.x = 闊的比例轉換
 
 transform.scale.y = 高的比例轉換
 
 transform.rotation.z = 平面圖的旋轉M_PI
 transform.rotation.x = 平面圖的旋轉M_PI

 opacity = 透明度
 
 margin
 
 zPosition//图层前后顺序
 
 backgroundColor    背景颜色
 
 cornerRadius    圆角
 
 borderWidth    //边框宽度
 
 bounds
 
 contents
 
 contentsRect
 
 cornerRadius
 
 frame//
 
 hidden//隐藏
 
 mask//蒙版
 
 masksToBounds
 
 opacity//透明度
 
 position//位置
 
 shadowColor//阴影颜色
 
 shadowOffset //阴影
 
 shadowOpacity//阴影不透明度
 
 shadowRadius//影子半径
 strokeStart //画线
 strokeEnd //画线
 */
- (IBAction)position:(id)sender
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:self.view.center];
    //是否在播放完成后移除。这是一个非常重要的属性，有的时候我们希望动画播放完成，但是保留最终的播放效果是，这个属性一定要改为NO，否则无效。
    animation.removedOnCompletion = NO;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    switch (count) {
        case 0:
            //播放完成后不复原
            animation.fillMode = kCAFillModeForwards;
            break;
        case 1:
            //播放完成后复原
            animation.fillMode = kCAFillModeBackwards;
            
            break;
        case 2:
            animation.fillMode = kCAFillModeBoth;
            break;
        case 3:
            //移除动画效果
            animation.fillMode = kCAFillModeRemoved;
            break;
        default:
            break;
    }
    if(count<3)
    {
        count ++;
    }else{
        count = 0;
    }
    [self.testView.layer addAnimation:animation forKey:@"PositionAni"];
}


- (IBAction)positionX:(id)sender
{
    [self.testView.layer setShadowOffset:CGSizeMake(2,2)];
    [self.testView.layer setShadowOpacity:1];
    [self.testView.layer setShadowColor:[UIColor grayColor].CGColor];
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    animation.fromValue
    = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    animation.toValue
    = [NSValue valueWithCGSize:CGSizeMake(20, 20)];
    animation.autoreverses=YES;
    animation.duration=1.0;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.testView.layer addAnimation:animation forKey:@"PositionAni"];
}

- (IBAction)positionXX:(id)sender
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue
    = [NSNumber numberWithFloat:M_PI];
    animation.toValue
    = [NSNumber numberWithFloat:-M_PI];
    animation.autoreverses=YES;
    animation.duration=1.0;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.testView.layer addAnimation:animation forKey:@"PositionAni"];
}
- (IBAction)positionXXX:(id)sender
{
    self.testView.layer.zPosition=20;
    self.testView1.layer.zPosition=40;
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"zPosition"];
    animation.toValue
    = [NSNumber numberWithFloat:60];
    animation.autoreverses=YES;
    animation.duration=1.0;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    
    [self.testView.layer addAnimation:animation forKey:@"PositionAni"];
}


#pragma mark - 关键帧动画
//绕方框
- (void)testKeyFrameAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 4.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(300, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    animation.values =@[value1,value2,value3,value4,value5];
    [self.testView1.layer addAnimation:animation forKey:@"positionKeyFrame"];
    
}
//沿着椭圆绕
-(void)testKeyFrameAnimationPath
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 4.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //创建path
    CGMutablePathRef path = CGPathCreateMutable();
    //椭圆path
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 200, 200, 100));
    //赋值
    animation.path = path;
    CGPathRelease(path);
    [self.testView1.layer addAnimation:animation forKey:@"KeyFrameAnimationPath"];

}

#pragma mark - 转场动画
/*
  The name of the transition. Current legal transition types include
 `fade'渐变, `moveIn'覆盖, `push'推出 and `reveal'揭开. Defaults to `fade'.
 
 type的enum值如下：
 kCATransitionFade 渐变
 kCATransitionMoveIn 覆盖
 kCATransitionPush 推出
 kCATransitionReveal 揭开
 
 subtype的enum值如下：
 kCATransitionFromRight 从右边
 kCATransitionFromLeft 从左边
 kCATransitionFromTop 从顶部
 kCATransitionFromBottom 从底部
 
 还有一些私有动画类型，效果很炫酷，不过不推荐使用。
 　　私有动画类型的值有："cube"、"suckEffect"、"oglFlip"、 "rippleEffect"、"pageCurl"、"pageUnCurl"等等。
 */
- (IBAction)testTranstion:(id)sender
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    self.imageView.image = [UIImage imageNamed:@"111.png"];
    [self.imageView.layer addAnimation:animation forKey:@"transitionBG"];

}

#pragma mark - 弹簧动画
- (IBAction)testSpringAnimation:(id)sender
{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    animation.mass = 100.0;  //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    animation.stiffness = 50000; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
    animation.damping = 100.0;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
    animation.initialVelocity = 5.f;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    animation.duration = animation.settlingDuration;
    animation.toValue = [NSNumber numberWithFloat:1.9];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.testView.layer addAnimation:animation forKey:@"frameAni"];
    
   
}


#pragma mark - 组动画
- (IBAction)testGroupAnimation:(id)sender
{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation1.duration = 4.0;
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];

    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation2.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];

    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation3.toValue = [NSNumber numberWithFloat:0.8];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1,animation2,animation3];
    group.duration = 4.0;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.testView.layer addAnimation:group forKey:@"group"];
    
}

#pragma mark - CATransaction事务
- (void)testCATransaction
{
    //手动创建的layer才能显式使用CATransaction动画

    //运动的layer
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    //显式事务默认开启动画效果,kCFBooleanTrue关闭
    [CATransaction setValue:(id)kCFBooleanFalse
                     forKey:kCATransactionDisableActions];
    //动画执行时间
    [CATransaction setValue:[NSNumber numberWithFloat:2.0f] forKey:kCATransactionAnimationDuration];
    [CATransaction setCompletionBlock:^{
        myLayer.backgroundColor = [UIColor redColor].CGColor;

    }];
    //Animatable 带隐式动画
    myLayer.backgroundColor = [UIColor blueColor].CGColor;
    [CATransaction commit];
}
- (void)animationDidStart:(CAAnimation *)anim
{
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
