//
//  TestGCD.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/2/28.
//  Copyright © 2018年 qian. All rights reserved.
//

/*
    GCD异步任务处理
    可以用dispatch_group_enter  dispatch_group_leave来控制异步任务完成
    dispatch_group_wait 参数forever等待完成
    dispatch_group_notify 指定group完成
    dispatch_semaphore_t 信号量控制任务完成顺序
 */
#import "TestGCD.h"
@interface TestGCD()
{
    dispatch_semaphore_t semaphore;
    BOOL isComeon;
}
@property (nonatomic,assign) NSUInteger number;
@end
@implementation TestGCD

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/*
    同步执行并发队列
 */
- (void)syncConcurrent
{
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"syncConcurrent ---- begin");
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"syncConcurrent ---- end");

}
/*
    异步执行并发队列
 */
- (void)asyncConcurrent
{
    NSLog(@"asyncConcurrent ---- begin");
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncConcurrent ---- end");
}

/*
    同步执行 串行队列
 */
- (void)syncSerial
{
    NSLog(@"syncSerial ---- begin");
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"syncSerial ---- end");

}
/*
    异步执行 串行队列
 */
- (void)asyncSerial
{
    NSLog(@"asyncSerial ---- begin");
    NSLog(@"%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncSerial ---- end");

}
/*
    同步执行 主队列
 */
- (void)syncMain
{
    NSLog(@"syncMain ---- end");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"syncMain ---- end");

}
/*
 异步执行 主队列
 */
- (void)asyncMain
{
    NSLog(@"asyncMain ---- end");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncMain ---- end");

}
/*
 线程中通讯
 */
- (void)communication
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t concurrentQueue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++){
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%@",[NSThread currentThread]);
        }
        dispatch_async(concurrentQueue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1   %@",[NSThread currentThread]);
        });
        dispatch_async(concurrentQueue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2   %@",[NSThread currentThread]);
        });
        dispatch_async(concurrentQueue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3   %@",[NSThread currentThread]);
        });
    });
}


/*
 栅栏方法
 */
- (void)barrier
{
    //并行队列
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    //异步执行
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1      %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2      %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3      %@",[NSThread currentThread]);
        }
    });
    //dispatch_barrier_async 不会阻塞主线程的    NSLog(@"7      %@",[NSThread currentThread]);
    //dispatch_barrier_sync 会阻塞主线程的    NSLog(@"7      %@",[NSThread currentThread]);等到1，2，3线程执行完，立即执行NSLog(@"7      %@",[NSThread currentThread]);

    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"########      %@",[NSThread currentThread]);

    });
    
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"4      %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"5      %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"6      %@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"7      %@",[NSThread currentThread]);
    NSLog(@"7      %@",[NSThread currentThread]);
    NSLog(@"7      %@",[NSThread currentThread]);

}

/*
 延迟执行
 */
- (void)after
{
    NSLog(@"%@",[NSThread currentThread]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.9*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"after action ");
    });
}

/*
 一次执行
 */
- (void)once
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"once");
    });
}

/*
 快速迭代
 */
- (void)apply
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"apply  begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zu   %@",index,[NSThread currentThread]);
    });
    NSLog(@"apply  end");

}

/*
    GCD队列组
 */
- (void)groupNotif
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0; i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1 ------ %@",[NSThread currentThread]);
        }
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0; i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2 ------ %@",[NSThread currentThread]);
        }
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0; i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3 ------ %@",[NSThread currentThread]);
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"end ------ %@",[NSThread currentThread]);
    });
}

/*
 GCD队列组等待
 */
- (void)groupWait
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0; i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1 ------ %@",[NSThread currentThread]);
        }
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0; i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2 ------ %@",[NSThread currentThread]);
        }
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0; i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3 ------ %@",[NSThread currentThread]);
        }
    });
    //等待1.1秒后执行下面语句 如果换DISPATCH_TIME_FOREVER 就是等待group执行完再往下执行
//    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 1.1*NSEC_PER_SEC));
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"end group");
}

/*
 队列组
 */
//dispatch_group_enter  dispatch_group_leave 一组相当于dispatch_group_async
- (void)groupEnterAndLeave
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for(int i = 0; i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1 ------ %@",[NSThread currentThread]);
        }
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for(int i = 0; i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2 ------ %@",[NSThread currentThread]);
        }
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for(int i = 0; i<2;i++)
        {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3 ------ %@",[NSThread currentThread]);
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"notify");
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"end");
}


/*
 信号量
 */
- (void)semaphore
{
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1     %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2     %@",[NSThread currentThread]);
        }
//        dispatch_semaphore_signal(semaphore);
    });
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:1];

        NSLog(@"barrier");

    });
    dispatch_async(queue, ^{
        for(int i = 0;i<2;i++)
        {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3     %@",[NSThread currentThread]);
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"end");
}
/*
 线程安全卖票
 */
- (void)safeThread
{
    isComeon = YES;
    semaphore = dispatch_semaphore_create(1);

    _number = 50;
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    __block TestGCD *test = self;
    dispatch_async(queue1, ^{
        [test saleTicket];
    });
    
    dispatch_async(queue2, ^{
        [test saleTicket];
    });
    
    
    
}

- (void)saleTicket
{
    
    while(isComeon){
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        if(_number>0){
            _number--;
            NSLog(@"%@",[NSThread currentThread]);
            
            [NSThread sleepForTimeInterval:0.1];
            NSLog(@"还剩     %lu     张票",(unsigned long)_number);
        }else{
            NSLog(@"卖完了");
            dispatch_semaphore_signal(semaphore);
            isComeon = NO;
        }
        dispatch_semaphore_signal(semaphore);

    }
}

- (void)test
{
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_create(0, DISPATCH_QUEUE_c);

}

/*
 线程安全卖票
 */
- (void)safeThread1
{
    isComeon = YES;
    semaphore = dispatch_semaphore_create(1);
    
    _number = 50;
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    __block TestGCD *test = self;
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, queue1, ^{
//        [test saleTicket1];
//
//    });
//    dispatch_group_async(group, queue2, ^{
//        [test saleTicket1];
//
//    });
//
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    NSLog(@"票卖完了，下次赶早");
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(queue1, ^{
        
        [test saleTicket1];
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue2, ^{
        [test saleTicket1];
        dispatch_group_leave(group);

    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"票卖完了，下次赶早");
}

- (void)saleTicket1
{
    
    while(isComeon){
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);


        if(_number>0){
            _number--;
            NSLog(@"%@",[NSThread currentThread]);
            
            [NSThread sleepForTimeInterval:0.1];
            dispatch_semaphore_signal(semaphore);

            NSLog(@"还剩     %lu     张票",(unsigned long)_number);
        }else{
            NSLog(@"卖完了");
            isComeon = NO;
            dispatch_semaphore_signal(semaphore);

        }
    }


}
@end
