//
//  TestRunLoop.h
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/1.
//  Copyright © 2018年 qian. All rights reserved.
//
//https://www.jianshu.com/p/d260d18dd551  iOS多线程：『RunLoop』详尽总结
//https://blog.ibireme.com/2015/05/18/runloop/ 深入理解RunLoop

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TestRunLoop : NSObject
+(instancetype)sharedInstance;

/*
 Test RunLoop
 */
-(void)testCFRun;
/*
 Test CFRunLoopObserverRef
 */
-(void)testCFRunLoopObserverRef;
/*
 test AddThreadForever
 */
-(void)testAddThreadForever;
@end
