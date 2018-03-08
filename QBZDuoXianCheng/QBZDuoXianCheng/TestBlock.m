//
//  TestBlock.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/8.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "TestBlock.h"
static int staNumber = 30;
@implementation TestBlock
+(instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/*
    test block block 作为代码段
 */
- (void)testBlock
{
    void (^block)(void) = ^(void){
        NSLog(@"%@",NSStringFromSelector(_cmd));
    };
    block();
}

/*
 test block block 作为变量
 */
- (void)testBlockIvar
{
    int (^ivarBlock)(int a)=^(int a){
        return a*10;
    };
    
    NSLog(@"%d",ivarBlock(20));
    
}


/*
 test block block 作为参数
 */
- (int)testBlockPra:(int(^)(int))myBlock
{
    return myBlock(987);
}

/*
 test block block 作为回调
 */
- (void)testBlockWithRe:(reBlock)block
{
    if(block)
    {
        block(5,20);
    }
}

/*
 test block Pra
 */
- (void)testBlocksPra
{
    //静态全局变量，全局变量，函数参数 不会被复制到block中，所以可以直接改值
    //参数变化需要用 __block标记，标记之后就是传递的指针，否则传递的是值
    //https://www.jianshu.com/p/ee9756f3d5f6
    __block int pra = 20;
    int dealPra = [self testBlockPra:^int(int a) {
        staNumber = 50;
        pra = 23;
        return pra;
    }];
    NSLog(@"dealPra %d",dealPra);
    NSLog(@"staNumber %d",staNumber);

}

/*
 test block Self
 */
- (void)testBlocksSelf
{
    //https://www.jianshu.com/p/a19f6dbb14da
    //block内部对self是强引用，会导致循环引用，需要用__weak
    //block内部不知道self什么时候释放，需要对self做强引用
    
    __weak typeof(self) weakSelf = self;
    int dealPra = [self testBlockPra:^int(int a) {
        __strong typeof(self) strongSelf = weakSelf;
        NSLog(@"%@",strongSelf.description);
        return 20;
    }];
    NSLog(@"%d",dealPra);

}


@end
