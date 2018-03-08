//
//  TestLocks.h
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/6.
//  Copyright © 2018年 qian. All rights reserved.
//https://www.jianshu.com/p/8b8a01dd6356

#import <Foundation/Foundation.h>

@interface TestLocks : NSObject
+(instancetype)sharedInstance;

/*
1 Test OSSpinLock
 */
- (void)testOSSpinLock;


/*
2 Test os_unfair_lock_t
 */
- (void)testOsUnfairLock;

/*
3    test dispatch_semaphore
 */
- (void)testDispatchSemaphore;

/*
4 test pthreadLock
 */
- (void)testpthreadLock;

/*
5 test pthread recursive 递归锁 允许在同一线程中多次加锁
 */
- (void)testpthreadRecursive;

/*
6 test NSLock
 */
- (void)testNSLock;

/*
 7test NSCondition 条件锁
 */
- (void)testNSCondition;

/*
8 test NSRecursiveLock 递归锁
 */
- (void)testNSRecursiveLock;

/*
9 test @synchronized
 */
- (void)testSynchronized;

/*
 10 test NSConditionLock
 */
- (void)testNSConditionLock;
@end
