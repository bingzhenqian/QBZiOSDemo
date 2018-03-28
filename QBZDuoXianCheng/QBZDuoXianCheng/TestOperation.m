//
//  TestOperation.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/2/28.
//  Copyright © 2018年 qian. All rights reserved.
//
/*
    Operation异步任务处理
    Dependency 控制依赖
*/
#import "TestOperation.h"
#import "QBZOperation.h"
@interface TestOperation()
@property (nonatomic, strong) NSInvocationOperation *invocationOperation;
@property (nonatomic, strong) NSBlockOperation *blockOperation ;
@property (nonatomic, strong) QBZOperation *customOperation ;

@end
@implementation TestOperation
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
    Test NSInvocationOperation
 */
- (void)testNSInvocationOperation
{
    //运行在主线程
    _invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    [_invocationOperation start];
}
/*
    Test NSBlockOperation
 */
- (void)testNSBlockOperation
{
    
    //运行在主线程
    __block TestOperation *test = self;
    _blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [test run];
    }];
    //addExecutionBlock 添加的代码块运行在子线程中
    [_blockOperation addExecutionBlock:^{
        NSLog(@"1   %@",[NSThread currentThread]);
    }];
    [_blockOperation addExecutionBlock:^{
        NSLog(@"2   %@",[NSThread currentThread]);
    }];
    [_blockOperation addExecutionBlock:^{
        NSLog(@"3   %@",[NSThread currentThread]);
    }];
    [_blockOperation start];
}

/*
    Test CustomOperation
 */
- (void)testCustomOperation
{
    //运行在主线程
    _customOperation = [[QBZOperation alloc] init];
    [_customOperation start];
}


- (void)run
{
    NSLog(@"%@",[NSThread currentThread]);
}


/*
    Test NSOperationQueue
 */
- (void)testNSOperationQueue
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //maxConcurrentOperationCount 1表示串行 多个表示并行
    queue.maxConcurrentOperationCount = 3;
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"1   %@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"2   %@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"3   %@",[NSThread currentThread]);
    }];

}
/*
 Test NSOperationQueue AddOperation
 */
- (void)testNSOperationQueueAddOperation
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //maxConcurrentOperationCount 1表示串行 多个表示并发
    queue.maxConcurrentOperationCount = 3;
//    __block TestOperation *test = self;
    _blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"1   %@",[NSThread currentThread]);
    }];
    _invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    [queue addOperation:_blockOperation];
    [queue addOperation:_invocationOperation];
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"3   %@",[NSThread currentThread]);
    }];
}
/*
 Test NSOperationQueue Dependency
 */
- (void)testNSOperationDependency
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//        [NSThread sleepForTimeInterval:1];
        NSLog(@"1   %@",[NSThread currentThread]);

    }];
//    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//        [NSThread sleepForTimeInterval:1];
        NSLog(@"2   %@",[NSThread currentThread]);
        
    }];

    //op2在op1执行完之后执行
    [op2 addDependency:op1];
//    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
//        [NSThread sleepForTimeInterval:1];
        NSLog(@"3   %@",[NSThread currentThread]);
        
    }];
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    [op3 addDependency:op2];
    [op4 addDependency:op3];

    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];

}
@end
