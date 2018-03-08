//
//  TestOperation.h
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/2/28.
//  Copyright © 2018年 qian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestOperation : NSObject
+(instancetype)sharedInstance;

/*
 Test NSInvocationOperation
 */
- (void)testNSInvocationOperation;

/*
 Test NSBlockOperation
 */
- (void)testNSBlockOperation;

/*
 Test CustomOperation
 */
- (void)testCustomOperation;

/*
 Test NSOperationQueue
 */
- (void)testNSOperationQueue;

/*
 Test NSOperationQueue AddOperation
 */
- (void)testNSOperationQueueAddOperation;

/*
 Test NSOperationQueue Dependency
 */
- (void)testNSOperationDependency;
@end
