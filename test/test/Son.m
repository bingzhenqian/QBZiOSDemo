//
//  Son.m
//  test
//
//  Created by qianbingzhen on 2018/3/21.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "Son.h"
#import <objc/runtime.h>
@implementation Son : Father
- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, NSStringFromClass([self class]));
        NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, NSStringFromClass([super class]));
    }
    return self;
}
@end

