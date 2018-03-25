//
//  TestRunLoop.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/1.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "TestRunLoop.h"
/*
    CFRunLoopRef RunLoop对象 NSRunLoop
 
 
    CFRunLoopMode  RunLoop的运行模式
    kCFRunLoopDefaultMode  默认模式，滑动界面时RunLoop停止
    UITrackingRunLoopMode  滑动界面时RunLoop开启
    kCFRunLoopCommonModes  兼容上面两种
 
    CFRunLoopSourceRef RunLoop事件源对象
    Source0 非基于Port 用户事件
    Source1 基于Port 系统事件
 
    CFRunLoopTimerRef  RunLoop定时源对象
 
    CFRunLoopObserverRef RunLoop观察者对象 可以监听RunLoop状态
 */
@interface TestRunLoop()
{
    NSThread *thread;
}
@end
@implementation TestRunLoop
+(instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/*
    Test RunLoop
 */
-(void)testCFRun
{
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    //NSDefaultRunLoopMode 滑动情况下不工作
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //NSDefaultRunLoopMode 滑动情况下工作
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    //两种情况下都工作
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    /*相当于
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
     */
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
}


/*
 typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
 kCFRunLoopEntry = (1UL << 0),               // 即将进入Loop：1
 kCFRunLoopBeforeTimers = (1UL << 1),        // 即将处理Timer：2
 kCFRunLoopBeforeSources = (1UL << 2),       // 即将处理Source：4
 kCFRunLoopBeforeWaiting = (1UL << 5),       // 即将进入休眠：32
 kCFRunLoopAfterWaiting = (1UL << 6),        // 即将从休眠中唤醒：64
 kCFRunLoopExit = (1UL << 7),                // 即将从Loop中退出：128
 kCFRunLoopAllActivities = 0x0FFFFFFFU       // 监听全部状态改变
 };

 
 */
/*
 Test CFRunLoopObserverRef
 */
-(void)testCFRunLoopObserverRef
{
    //创建观察者
    CFRunLoopObserverRef observer =CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"监听到runloop变化  %zd",activity);
    });
    //添加到runloop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
}

/*
    test AddThreadForever
 */
-(void)testAddThreadForever
{
    thread = [[NSThread alloc] initWithTarget:self selector:@selector(run1) object:nil];
    [thread start];
    
}
-(void)run1
{
    NSLog(@"Run");
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"Run end");
}

-(void)run
{
    NSLog(@"Run");
}
@end
