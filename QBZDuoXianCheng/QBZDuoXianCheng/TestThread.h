//
//  TestThread.h
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/5.
//  Copyright © 2018年 qian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestThread : NSObject
+ (instancetype)sharedInstance;
/*
 NSThread
 */
-(void)testThread;
/*
 线程通讯
 */
- (void)testDownloadImageInSubThread;
/*
 线程同步
 */
- (void)saleTicketInThread;

@end
