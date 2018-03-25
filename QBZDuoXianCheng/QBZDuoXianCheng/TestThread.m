//
//  TestThread.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/5.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "TestThread.h"
#import <UIKit/UIKit.h>
@interface TestThread()
@property (nonatomic,assign) NSUInteger ticketNumber;
@end

@implementation TestThread
//单例
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
    NSThread
 */
#pragma mark
-(void)testThread
{
    //创建三种
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [thread1 start];
    
    //创建 并运行
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    
    //直接创建
    [self performSelectorInBackground:@selector(run) withObject:nil];
    //主线程中创建
    [self performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(run:) withObject:@5 waitUntilDone:YES];
}

- (void)run:(NSNumber *)num
{
    NSLog(@"%@   %@",[NSThread currentThread],num);
    NSLog(@"run");

}


-(void)run
{
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"run");
}

/*
    线程通讯
 */
- (void)testDownloadImageInSubThread
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(download) object:nil];
    [thread start];

}
- (void)download
{
    NSURL *imageUrl = [NSURL URLWithString:@"https://ysc-demo-1254961422.file.myqcloud.com/YSC-phread-NSThread-demo-icon.jpg"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    //主线程刷新
    [self performSelectorOnMainThread:@selector(update:) withObject:image waitUntilDone:NO];
}

-(void)update:(UIImage*)image
{
    NSLog(@"%@",image);
}

/*
    线程同步
 */

- (void)saleTicketInThread
{
    _ticketNumber = 50;
    NSThread *thread1 =  [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    NSThread *thread2 =   [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    NSThread *thread3 =   [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    thread1.name = @"thread1";
    thread2.name = @"thread2";
    thread3.name = @"thread3";
    [NSThread detachNewThreadSelector:@selector(saleTicket) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(saleTicket) toTarget:self withObject:nil];
    [thread1 start];
    [thread2 start];
    [thread3 start];
}

- (void)saleTicket
{
    while(1){
        //锁
        @synchronized(self){
            if(_ticketNumber>0){
                _ticketNumber --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%lu 窗口：%@", (unsigned long)_ticketNumber, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];

            }else{
                NSLog(@"票已经售完");
                return;
            }
            
        }
    }
}
@end


