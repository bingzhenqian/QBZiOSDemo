//
//  TestRequest.h
//  TestRequest
//
//  Created by qianbingzhen on 2018/3/14.
//  Copyright © 2018年 qian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestRequest : NSObject
+ (instancetype)sharedInstance;
- (void)getRequest;
- (void)postRequest;
- (void)downloadRequest;
@end
