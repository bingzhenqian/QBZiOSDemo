//
//  TestKVO.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/12.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "TestKVO.h"
//https://www.jianshu.com/p/a0cf1b450371  iOS - KVO 底层详解及与 KVC 的关系


/*
    KVC调用顺序
    set方法，_qbz赋值，qbz赋值，setValue: forUndefinedKey方法
 */
@interface Person:NSObject
{
//    NSString *_qbz;
//    NSString *qbz;
}
@property(nonatomic,copy)NSString *name;
//@property(nonatomic,copy)NSString *_qbz;

@property(nonatomic,assign) float height;

@property(nonatomic,assign)NSInteger age;

@end
@implementation Person
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(nullable id)valueForUndefinedKey:(NSString *)key
{
    return nil;
    
}

//-(void)setQbz:(NSString*)qbz
//{
//    NSLog(@"qbz setted");
//}
@end
@interface TestKVO()

@end
@implementation TestKVO
+(instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)testKVO
{
    Person *person = [Person new];
    person.height = 180;
    person.name =@"qbz";
    //po person->isa  Person
    person.age = 20;
    //addObserver 之后，person的isa指针变成了NSKVONotifying_Person  po person->isa  NSKVONotifying_Person

    [person addObserver:self forKeyPath:@"height" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    //赋值时，是调用NSKVONotifying_Person的setValue方法，类似
    /*
     [person setValue:182 forKey:@"height"];
     [self willChangeValueForKey:@"height"];//调用observeValueForKeyPath方法
     [self didChangeValueForKey:@"height"];//调用observeValueForKeyPath方法
     */
    person.height = 182;
    [person setValue:@"asda" forKey:@"qbz"];
    NSLog(@"%@",person);
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@",change);
}
@end
