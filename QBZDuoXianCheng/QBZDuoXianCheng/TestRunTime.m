//
//  TestRunTime.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/7.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "TestRunTime.h"
#import <objc/runtime.h>
#import <objc/NSObjCRuntime.h>
@implementation TestRunTime
+(instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(void)test
{
}
@end
