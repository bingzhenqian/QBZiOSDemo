//
//  TestGCD.h
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/2/28.
//  Copyright © 2018年 qian. All rights reserved.
//
//参考 https://www.jianshu.com/p/2d57c72016c6
#import <Foundation/Foundation.h>

@interface TestGCD : NSObject
+ (instancetype)sharedInstance;

/*
 同步执行并发队列  在当前线程一个个执行
 */
- (void)syncConcurrent;
/*
 异步执行并发队列  开多线程同时执行
 */
- (void)asyncConcurrent;
/*
 同步执行 串行队列  在当前线程一个个执行
 */
- (void)syncSerial;
/*
 异步执行 串行队列  开一条新线程一个个执行
 */
- (void)asyncSerial;
/*
 同步执行 主队列    阻塞线程
 */
- (void)syncMain;
/*
 异步执行 主队列    在主线程中一个个执行
 */
- (void)asyncMain;



/*
    线程中通讯
 */
- (void)communication;


/*
    栅栏方法
 */
- (void)barrier;

/*
    延迟执行
 */
- (void)after;

/*
    一次执行
 */
- (void)once;

/*
    快速迭代
 */
- (void)apply;

/*
 GCD队列组
 */
- (void)groupNotif;

/*
 GCD队列组等待
 */
- (void)groupWait;

/*
 队列组
 */
- (void)groupEnterAndLeave;

/*
    信号量
 */
- (void)semaphore;

/*
    线程安全卖票
*/
- (void)safeThread;



/*
 线程安全卖票
 */
- (void)safeThread1;
@end
