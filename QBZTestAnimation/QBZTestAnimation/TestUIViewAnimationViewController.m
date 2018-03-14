//
//  TestUIViewAnimationViewController.m
//  QBZTestAnimation
//
//  Created by qianbingzhen on 2018/3/14.
//  Copyright © 2018年 qian. All rights reserved.
//

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
    [UIView transitionFromView:self.testView toView:self.testView1 duration:2.0 options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear) completion:^(BOOL finished) {
        
    }];
}

























@end
