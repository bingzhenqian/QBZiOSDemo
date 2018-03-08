//
//  TestLocks.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/6.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "TestLocks.h"
#import <libkern/OSAtomic.h>
#import <os/lock.h>
#import <pthread.h>
@implementation TestLocks
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
    Test OSSpinLock
 */
- (void)testOSSpinLock
{
    __block OSSpinLock oslock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1，准备上锁");
        sleep(4);
        OSSpinLockLock(&oslock);
        NSLog(@"线程1");
        sleep(1);
//        OSSpinLockUnlock(&oslock);
        NSLog(@"线程1，解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2，准备上锁");
        sleep(4);
        OSSpinLockLock(&oslock);
        NSLog(@"线程2");
        sleep(1);
        OSSpinLockUnlock(&oslock);
        NSLog(@"线程2，解锁");
    });
}

/*
 Test os_unfair_lock_t
 */
- (void)testOsUnfairLock
{
    __block os_unfair_lock_t oslock = &OS_UNFAIR_LOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1，准备上锁");
        sleep(4);
        BOOL isLock = os_unfair_lock_trylock(oslock);
        NSLog(@"线程1");
        sleep(1);
        isLock?os_unfair_lock_unlock(oslock):@"";
        NSLog(@"线程1,解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2，准备上锁");
        sleep(4);
        BOOL isLock = os_unfair_lock_trylock(oslock);
        NSLog(@"线程2");
        sleep(1.5);
        isLock?os_unfair_lock_unlock(oslock):@"";
        NSLog(@"线程2,解锁");
    });
    
}
/*
 test dispatch_semaphore  信号量
 */
- (void)testDispatchSemaphore
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*3.0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) , ^{
        NSLog(@"线程1加锁");
        dispatch_semaphore_wait(semaphore, time);
        sleep(1);
        NSLog(@"线程1");
        dispatch_semaphore_signal(semaphore);
        NSLog(@"线程1,解锁");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2加锁");
        dispatch_semaphore_wait(semaphore, time);
        sleep(1);
        NSLog(@"线程2");
        dispatch_semaphore_signal(semaphore);
        NSLog(@"线程2,解锁");
    });
}

/*
 test pthreadLock  互斥锁
 */
- (void)testpthreadLock
{
    static pthread_mutex_t plock;
    pthread_mutex_init(&plock, NULL);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1加锁");
        pthread_mutex_lock(&plock);
        NSLog(@"线程1");
        sleep(1);
        pthread_mutex_unlock(&plock);
        NSLog(@"线程1解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2加锁");
        pthread_mutex_lock(&plock);
        NSLog(@"线程2");
        sleep(1);
        pthread_mutex_unlock(&plock);
        NSLog(@"线程2解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程3加锁");
        pthread_mutex_lock(&plock);
        NSLog(@"线程3");
        sleep(1);
        pthread_mutex_unlock(&plock);
        NSLog(@"线程3解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程4加锁");
        pthread_mutex_lock(&plock);
        NSLog(@"线程4");
        sleep(1);
        pthread_mutex_unlock(&plock);
        NSLog(@"线程4解锁");
    });
}

/*
    test pthread recursive 递归锁 允许在同一线程中多次加锁
 */
- (void)testpthreadRecursive
{
    static pthread_mutex_t plock;
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);//
    pthread_mutex_init(&plock, &attr);
    pthread_mutexattr_destroy(&attr);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecusiveBlock)(int);
        RecusiveBlock = ^(int value){
            NSLog(@"加锁 %d",value);

            pthread_mutex_lock(&plock);//加锁
            if(value>0)
            {
                value--;
                RecusiveBlock(value);
            }
            pthread_mutex_unlock(&plock);
            NSLog(@"解锁 %d",value);

        };
        RecusiveBlock(10);
    });
}

/*
    test NSLock
 */
- (void)testNSLock
{
    NSLock *lock = [NSLock new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1加锁");
        [lock lock];
        NSLog(@"线程1");
        sleep(1);
        [lock unlock];
        NSLog(@"线程1解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2加锁");
        [lock lock];
        NSLog(@"线程2");
        sleep(1);
        [lock unlock];
        NSLog(@"线程2解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程3加锁");
        [lock lock];
        NSLog(@"线程3");
        sleep(1);
        [lock unlock];
        NSLog(@"线程3解锁");
    });
}

/*
 test NSCondition 条件锁
 */
- (void)testNSCondition
{
    __block NSCondition *condition = [NSCondition new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1加锁");
        [condition lock];
        NSLog(@"线程1");
        [condition wait];
        NSLog(@"线程1等待");
        sleep(1.0);

        [condition unlock];
        NSLog(@"线程1解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2加锁");
        [condition lock];
        NSLog(@"线程2");
        [condition waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
        NSLog(@"线程2等待");
        sleep(1.0);

        [condition unlock];
        NSLog(@"线程2解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程3加锁");
        [condition lock];
        NSLog(@"线程3");
        [condition wait];
        NSLog(@"线程3等待");
        sleep(1.0);

        [condition unlock];
        NSLog(@"线程3解锁");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程4加锁");
        [condition lock];
        NSLog(@"线程4");
        [condition wait];
        NSLog(@"线程4等待");
        sleep(1.0);

        [condition unlock];
        NSLog(@"线程4解锁");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3.0);
        [condition signal];
        NSLog(@"随机唤醒线程");
        sleep(1.0);
        [condition broadcast];
        NSLog(@"唤醒所有线程");


    });
    
}
/*
 test NSRecursiveLock 递归锁
 */
- (void)testNSRecursiveLock
{
    NSRecursiveLock *rLock = [NSRecursiveLock new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value) {
            [rLock lock];
            if (value > 0) {
                NSLog(@"线程%d", value);
                RecursiveBlock(value - 1);
            }
            [rLock unlock];
            NSLog(@"线程%d解锁", value+1);

        };
        RecursiveBlock(4);
    });
    
}

/*
 test @synchronized
 */
- (void)testSynchronized
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self){
            sleep(2);
            NSLog(@"线程1");
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self){
            sleep(2);
            NSLog(@"线程2");
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self){
            sleep(2);
            NSLog(@"线程3");
        }
    });
}

/*
 10 test NSConditionLock
 用condition来控制线程执行顺序
 */
- (void)testNSConditionLock
{
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    NSConditionLock *clock = [[NSConditionLock alloc] initWithCondition:0];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if([clock tryLockWhenCondition:0]){
            NSLog(@"线程1");
            [clock unlockWithCondition:1];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [clock lockWhenCondition:10];
        NSLog(@"线程2");
        [clock unlockWithCondition:11];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [clock lockWhenCondition:11];
        NSLog(@"线程3");
        [clock unlockWithCondition:12];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [clock lockWhenCondition:1];
        NSLog(@"线程4");
        [clock unlockWithCondition:10];
    });
}
@end


















