//
//  TestRunTime.h
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/7.
//  Copyright © 2018年 qian. All rights reserved.
//https://www.jianshu.com/p/6b905584f536
//http://southpeak.github.io/2014/10/25/objective-c-runtime-1/
//http://www.cocoachina.com/ios/20150901/13173.html

#import <Foundation/Foundation.h>
@protocol TestProtocol
@optional
-(void)testProtocol;
@end
@interface TestRunTime : NSObject<TestProtocol>
+(instancetype)sharedInstance;
+(instancetype)sharedInstance1;
-(void)printTest;
/*
 runtime 方法
 */
-(void)runtimeTest;
-(void)runrun;
-(void)sendMethod;
/*
 关联属性
 */
//添加关联属性的key 也可以添加控件

-(void)addAssociateObject;

@end
