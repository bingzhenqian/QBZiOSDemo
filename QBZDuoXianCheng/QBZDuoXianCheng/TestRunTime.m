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
#import <UIKit/UIKit.h>
@interface TestRunSub:NSObject
-(void)runSub;

@end
@implementation TestRunSub
-(void)runSub
{
    NSLog(@"runSub");
}
@end

@interface TestRunSub1:NSObject
-(void)runSub1;

@end
@implementation TestRunSub1
-(void)runSub1
{
    NSLog(@"runSub1");
}
@end
@interface TestRunSub2:NSObject
-(void)runSub1;

@end
@implementation TestRunSub2
-(void)runSub1
{
    NSLog(@"runSub2");
}
@end


@interface TestRunTime()
{
    NSInteger *aaa;
    NSArray *array1;
}
@property (nonatomic,assign) NSUInteger uint;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSMutableDictionary *muDic;


@end

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
+(instancetype)sharedInstance1
{
    NSLog(@"sharedInstance1");
    NSLog(@"changeMethod");
    return [TestRunTime sharedInstance1];
}

-(void)test
{
    
}

-(void)printTest
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%s",__func__);
}
/*
    runtime 方法
 */
-(void)runtimeTest
{
    unsigned int count=0;
    
    //获取类属性列表
    NSLog(@"################     获取类属性列表");

    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for(int i = 0;i<count;i++)
    {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"%s",propertyName);
    }
    
    //获取类成员变量列表
    NSLog(@"################     获取类成员变量列表");
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for(int i = 0;i<count;i++)
    {
        const char *ivarName = ivar_getName(ivarList[i]);
        NSLog(@"%s",ivarName);
    }
    
    //获取类方法列表
    NSLog(@"################     获取类方法列表");
    Method *methodList = class_copyMethodList([self class], &count);
    for(int i = 0;i<count;i++)
    {
        SEL methodName = method_getName(methodList[i]);
        NSLog(@"%@",NSStringFromSelector(methodName));
    }
    
    //获取类协议列表
    NSLog(@"################     获取类协议列表");
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for(int i = 0;i<count;i++)
    {
        const char *protocolName = protocol_getName(protocolList[i]);
        NSLog(@"%s",protocolName);
    }
}

/*
    方法调用流程
 struct objc_class {
 Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
 
 #if !__OBJC2__
 Class _Nullable super_class                              OBJC2_UNAVAILABLE;
 const char * _Nonnull name                               OBJC2_UNAVAILABLE;
 long version                                             OBJC2_UNAVAILABLE;
 long info                                                OBJC2_UNAVAILABLE;
 long instance_size                                       OBJC2_UNAVAILABLE;
 struct objc_ivar_list * _Nullable ivars                  OBJC2_UNAVAILABLE;
 struct objc_method_list * _Nullable * _Nullable methodLists                    OBJC2_UNAVAILABLE;
 struct objc_cache * _Nonnull cache                       OBJC2_UNAVAILABLE;
 struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
 #endif
 
 } OBJC2_UNAVAILABLE;
 */
-(void)sendMethod
{
    /*
        1.从对象cache中查找，有就调用
        2.没有到methodLists中查找，有就调用
        3.没有就到父类chche中查找，有就调用
        4.没有就到父类methodLists中查找，有就调用
        5.循环，到根类都没有，转向拦截调用
        6.没有写拦截调用方法，程序报错
     */
    
}

/*
    动态添加方法
 */
//https://www.jianshu.com/p/91708b5b0501
//http://blog.csdn.net/sharpyl/article/details/54315234
void run (id self,SEL _cmd)
{
    NSLog(@"run");
}
-(void)runrun
{
    NSLog(@"runrun");
}

-(void)runrun1
{
    NSLog(@"runrun1");
    [self runrun1];
}
+(BOOL)resolveClassMethod:(SEL)sel
{
    return [super resolveClassMethod:sel];
}

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if(sel == @selector(run))
    {
        class_addMethod(self, sel, (IMP)run, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

/*
    返回其他对象来处理aSelector方法
 */
-(id)forwardingTargetForSelector:(SEL)aSelector
{
    if(aSelector == @selector(runSub))
    {
        return [TestRunSub new];
    }
    return nil;
}

/*
    消息转发  可以让多个对象响应
 */
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if(aSelector == @selector(runSub1))
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return  [super methodSignatureForSelector:aSelector];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = [anInvocation selector];
    TestRunSub1 *sub1 = [TestRunSub1 new];
    TestRunSub2 *sub2 = [TestRunSub2 new];
    if([sub1 respondsToSelector:selector])
    {
        [anInvocation invokeWithTarget:sub1];
    }
    if([sub2 respondsToSelector:selector])
    {
        [anInvocation invokeWithTarget:sub2];
    }
}
//崩溃
-(void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"error");
}
/*
    关联属性
 */
//添加关联属性的key 也可以添加控件
static const void *associateObjectKey;
- (void)addAssociateObject
{
    //OBJC_ASSOCIATION_RETAIN_NONATOMIC 语义
    objc_setAssociatedObject(self, associateObjectKey, [UIButton new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIButton *button = objc_getAssociatedObject(self, associateObjectKey);
    NSLog(@"%@",button);
}

/*
    方法交换
 */
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //替换和被替换方法
        Method fromMethod = class_getInstanceMethod([self class], @selector(runrun));
        Method toMethod = class_getInstanceMethod([self class], @selector(runrun1));
        //动态添加成功
        if(class_addMethod(self, @selector(runrun1) , method_getImplementation(toMethod), method_getTypeEncoding(toMethod))){
            //动态添加成功，说明以前没有，替换方法
            class_replaceMethod(self, @selector(runrun1), method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
        }else{
            //动态添加不成功，说明以前有，直接交换方法
            method_exchangeImplementations(fromMethod, toMethod);

        }
    });
    
//    //获得viewController的生命周期方法的selector
//    SEL systemSel = @selector(runrun);
//    //自己实现的将要被交换的方法的selector
//    SEL swizzSel = @selector(runrun1);
//    //两个方法的Method
//    Method systemMethod = class_getInstanceMethod([self class], systemSel);
//    Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
//
//    //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
//    BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
//    if (isAdd) {
//        //如果成功，说明类中不存在这个方法的实现
//        //将被交换方法的实现替换到这个并不存在的实现
//        class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
//    }else{
//        //否则，交换两个方法的实现
//        method_exchangeImplementations(systemMethod, swizzMethod);
//    }
    
  
}


@end














