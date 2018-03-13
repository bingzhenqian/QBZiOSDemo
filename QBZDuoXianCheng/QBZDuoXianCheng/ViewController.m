//
//  ViewController.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/2/28.
//  Copyright © 2018年 qian. All rights reserved.
//
/*
 同步  不开线程   异步   开新的线程
                同步                         异步
 串行      在当前线程一个一个执行        其他线程中一个一个执行
 并行      在当前线程一个一个执行        在多个线程中一起执行
*/
#import "ViewController.h"
#import "TestGCD.h"
#import "TestOperation.h"
#import "TestRunLoop.h"
#import "TestThread.h"
#import "TestLocks.h"
#import "TestBlock.h"
#import "TestRunTime.h"
#import "TestKVO.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testThread];
    [self thread];
    [self gcd];
    [self operation];
    [self runloop];
    [self lock];
    [self block];
    [self runTime];
    [self kvo];
}

- (void)thread
{
//    [[TestThread sharedInstance] testThread];
//    [[TestThread sharedInstance] testDownloadImageInSubThread];
//    [[TestThread sharedInstance] saleTicketInThread];
}

- (void)gcd
{
//        [[TestGCD sharedInstance] syncConcurrent];
//        [[TestGCD sharedInstance] asyncConcurrent];
//        [[TestGCD sharedInstance] syncSerial];
//        [[TestGCD sharedInstance] asyncSerial];
//        [[TestGCD sharedInstance] syncMain];
//        [[TestGCD sharedInstance] asyncMain];
//        [[TestGCD sharedInstance] communication];
//        [[TestGCD sharedInstance] barrier];
//        [[TestGCD sharedInstance] after];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [[TestGCD sharedInstance] once];
//        });
//        [[TestGCD sharedInstance] apply];
//        [[TestGCD sharedInstance] groupNotif];
//        [[TestGCD sharedInstance] groupWait];
//        [[TestGCD sharedInstance] groupEnterAndLeave];
//        [[TestGCD sharedInstance] semaphore];
//        [[TestGCD sharedInstance] safeThread];
    //    [[TestGCD sharedInstance] safeThread1];

}
- (void)operation
{
    //    [[TestOperation sharedInstance] testNSInvocationOperation];
    //    [[TestOperation sharedInstance] testNSBlockOperation];
//        [[TestOperation sharedInstance] testCustomOperation];
    //    [[TestOperation sharedInstance] testNSOperationQueue];
    //    [[TestOperation sharedInstance] testNSOperationQueueAddOperation];
    //    [[TestOperation sharedInstance] testNSOperationDependency];

}

- (void)runloop
{
    //    [[TestRunLoop sharedInstance] testCFRun];
//    [[TestRunLoop sharedInstance] testCFRunLoopObserverRef];
//    [[TestRunLoop sharedInstance] testAddThreadForever];
    
}

-(void)lock
{
//    [[TestLocks sharedInstance] testOSSpinLock];
//    [[TestLocks sharedInstance] testOsUnfairLock];
//    [[TestLocks sharedInstance] testDispatchSemaphore];
//    [[TestLocks sharedInstance] testpthreadLock];
//    [[TestLocks sharedInstance] testpthreadRecursive];
//    [[TestLocks sharedInstance] testNSLock];
//    [[TestLocks sharedInstance] testNSCondition];
//    [[TestLocks sharedInstance] testNSRecursiveLock];
//    [[TestLocks sharedInstance] testSynchronized];
//    [[TestLocks sharedInstance] testNSConditionLock];

    

}

- (void)block
{
//    [[TestBlock sharedInstance] testBlock];
//    [[TestBlock sharedInstance] testBlockIvar];
//    int number =  [[TestBlock sharedInstance] testBlockPra:^int(int a) {
//        return a%900;
//    }];
//    NSLog(@"number is %d",number);
    
//    [[TestBlock sharedInstance] testBlockWithRe:^float(int a, int b) {
//        NSLog(@"%d",a*b);
//        return a*b;
//    }];
//    [[TestBlock sharedInstance] testBlocksPra];
//    [[TestBlock sharedInstance] testBlocksSelf];

}

-(void)runTime
{
//    [[TestRunTime sharedInstance] printTest];
//    [[TestRunTime sharedInstance] runtimeTest];
//    [[TestRunTime sharedInstance] performSelector:@selector(run) withObject:nil];
//    [TestRunTime performSelector:@selector(run) withObject:nil];
//    [[TestRunTime sharedInstance] performSelector:@selector(runSub) withObject:nil];
//    [[TestRunTime sharedInstance] performSelector:@selector(runSub1) withObject:nil];
//    [[TestRunTime sharedInstance] performSelector:@selector(runSub2) withObject:nil];
//    [[TestRunTime sharedInstance] addAssociateObject];
//    [[TestRunTime sharedInstance] performSelector:@selector(runrun)];
}
-(void)kvo
{
//    [[TestKVO sharedInstance] testKVO];
}


- (IBAction)pressed:(id)sender {
    NSLog(@"press");
    [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"nav_arbitrate@2x.png"] afterDelay:4.0 inModes:@[NSDefaultRunLoopMode]];
}

#pragma mark - NSThread
- (void)testThread
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(testThreadPrint) object:nil];
    thread.name = @"testThread";
    [thread start];
}
- (void)testThreadPrint
{
    NSLog(@"This is Thread %@",[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
