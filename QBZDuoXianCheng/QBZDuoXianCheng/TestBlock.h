//
//  TestBlock.h
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/8.
//  Copyright © 2018年 qian. All rights reserved.
//https://www.jianshu.com/p/649fca982c6e  一篇文章看懂iOS代码块Block
//https://www.jianshu.com/p/3f8040766a7f iOS之Block深度学习

#import <Foundation/Foundation.h>
typedef float(^reBlock)(int a,int b);
@interface TestBlock : NSObject
+(instancetype)sharedInstance;

/*
 test block
 */
- (void)testBlock;

/*
 test block block 作为变量
 */
- (void)testBlockIvar;
/*
 test block block 作为参数
 */
- (int)testBlockPra:(int(^)(int))myBlock;

/*
 test block block 作为回调
 */
- (void)testBlockWithRe:(reBlock)block;

/*
 test block pra block里面参数修饰
 */
- (void)testBlocksPra;

/*
 test block self block里面self修饰
 */
- (void)testBlocksSelf;
@end
