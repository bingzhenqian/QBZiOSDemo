//
//  TestUIViewAnimationViewController.m
//  QBZTestAnimation
//
//  Created by qianbingzhen on 2018/3/14.
//  Copyright © 2018年 qian. All rights reserved.
//https://www.jianshu.com/p/5abc038e4d94

#import "TestUIViewAnimationViewController.h"

@interface TestUIViewAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UIView *testView1;

@end

@implementation TestUIViewAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/*
 testAnimation
 */
-(IBAction)testAnimation:(id)sender
{
    
    [UIView beginAnimations:@"someAnimation" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(printStart)];//开始前运行方法
    [UIView setAnimationDidStopSelector:@selector(printStop)];//结束运行方法
    [UIView setAnimationDuration:3.0];//持续时间
//    [UIView setAnimationDelay:2.0];//延迟时间
//    [UIView setAnimationStartDate:[NSDate date]];//开始时间
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//线性
    [UIView setAnimationRepeatCount:3];//重复次数
    [UIView setAnimationRepeatAutoreverses:YES];//是否调用相反动画
    [UIView setAnimationBeginsFromCurrentState:YES];//设置是否从当前状态开始播放动画
    //设置过渡效果
    //view需要过渡效果的View
    //cache是否使用视图缓存，YES：视图在开始和结束时渲染一次；NO：视图在每一帧都渲染
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.testView cache:YES];
    self.testView.center = CGPointMake(100, 100);
    [UIView commitAnimations];
}
-(void)printStart
{
    NSLog(@"%s",__func__);
}

-(void)printStop
{
    NSLog(@"%s",__func__);

}
/*
    testAnimationWithBlock
 */
-(IBAction)testAnimationWithBlock:(id)sender
{
//    [UIView animateWithDuration:1.0 animations:^{
//        self.testView.center = CGPointMake(100, 100);
//    }];
//
//    [UIView animateWithDuration:2.0 animations:^{
//        self.testView.center = CGPointMake(100, 100);
//    } completion:^(BOOL finished) {
//        [self printStop];
//    }];
//
//    [UIView animateWithDuration:2.0 delay:1.0 options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionTransitionFlipFromLeft) animations:^{
//        self.testView.center = CGPointMake(100, 100);
//    } completion:^(BOOL finished) {
//        [self printStop];
//    }];
//
//
//    [UIView animateWithDuration:2.0 delay:1.0 usingSpringWithDamping:100.0f initialSpringVelocity:5.0f options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionTransitionFlipFromLeft) animations:^{
//        self.testView.center = CGPointMake(100, 100);
//    } completion:^(BOOL finished) {
//        [self printStop];
//    }];
//
//    //关键帧动画
//    self.testView.center = CGPointMake(100, 100);
//
//    [UIView animateKeyframesWithDuration:9.0 delay:0.0f options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromLeft) animations:^{
//        //添加关键帧
////        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
////            self.testView.center = CGPointMake(100, 100);
////        }];
//        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
//            self.testView.center = CGPointMake(300, 100);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.2 animations:^{
//            self.testView.center = CGPointMake(300, 300);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.2 animations:^{
//            self.testView.center = CGPointMake(100, 300);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.2 animations:^{
//            self.testView.center = CGPointMake(100, 100);
//        }];
//
//    } completion:^(BOOL finished) {
//
//    }];
    
    //转场动画
    //单个试图
//    [UIView transitionWithView:self.testView duration:2.0 options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromTop) animations:^{
//        self.testView.center = CGPointMake(100, 100);
//    } completion:^(BOOL finished) {
//
//    }];
    //多个试图
//    [UIView transitionFromView:self.testView toView:self.testView1 duration:2.0 options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear) completion:^(BOOL finished) {
//
//    }];
    
    // 缩放 + 透明度动画
    self.testView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:3 animations:^{
        self.testView.transform = CGAffineTransformMakeScale(1,1);
        self.testView.alpha = 1.0;
        [UIView beginAnimations:@"flash" context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.testView.alpha = 0;
        [UIView commitAnimations];
    }];
  
    
}

/*
    testBezierPath
 https://www.jianshu.com/p/c5cbb5e05075
 */
- (IBAction)testBezierPath:(id)sender
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 500)];
    [path addLineToPoint:CGPointMake(300, 500)];
    [path addLineToPoint:CGPointMake(300, 550)];
    [path addQuadCurveToPoint:CGPointMake(100, 550) controlPoint:CGPointMake(200, 650)];
    [path addLineToPoint:CGPointMake(100, 500)];
    [path closePath];
    CAShapeLayer*shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor= [UIColor clearColor].CGColor;
    shapeLayer.strokeColor= [UIColor greenColor].CGColor;
    shapeLayer.lineWidth=3;
    shapeLayer.path= path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.duration = 2.0;
    animation1.fromValue = [NSNumber numberWithFloat:0.25];
    animation1.toValue = [NSNumber numberWithFloat:0.0f];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.0;
    animation.fromValue = [NSNumber numberWithFloat:0.5f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1,animation];
    group.duration = 2.0;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer addAnimation:group forKey:nil];

    
}


//https://www.jianshu.com/p/1bf7fc25f17e  iOS动画系列



















@end
