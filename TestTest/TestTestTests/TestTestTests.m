//
//  TestTestTests.m
//  TestTestTests
//
//  Created by qianbingzhen on 2018/3/9.
//  Copyright © 2018年 qian. All rights reserved.
//https://www.jianshu.com/p/8bbec078cabe  iOS单元测试(作用及入门提升)
//http://liuyanwei.jumppo.com/2016/03/10/iOS-unit-test.html  刘彦玮iOS的单元测试

/*
    测试用例流程
    给出变量和预期
    计算实际值
    断言判断预期和实际计算值是否符合
 */
#import <XCTest/XCTest.h>
#import "AFNetworking.h"
#import "STAlertView.h"
#define WAIT do {\
[self expectationForNotification:@"RSBaseTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:30 handler:nil];\
} while (0);

#define NOTIFY \
[[NSNotificationCenter defaultCenter]postNotificationName:@"RSBaseTest" object:nil];

@interface TestTestTests : XCTestCase
@property (nonatomic,strong) STAlertView *stAlertView;
@property (nonatomic,strong) UIButton *button;
@end

@implementation TestTestTests

- (void)setUp {
    [super setUp];
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        sleep(2);
        // Put the code you want to measure the time of here.
    }];
}
- (void)testRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    [manager GET:@"http://www.weather.com.cn/adat/sk/101110101.html" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        XCTAssertNotNil(responseObject,@"返回出错");
        NOTIFY
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        XCTAssertNil(error,@"请求出错");
        NOTIFY
    }];
    WAIT
}
- (void)testAlert
{
    self.stAlertView = [[STAlertView alloc]initWithTitle:@"验证码" message:nil textFieldHint:@"请输入手机验证码" textFieldValue:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" cancelButtonBlock:^{
        //点击取消返回后执行
        NSLog(@"cancel");
        NOTIFY //继续执行
    } otherButtonBlock:^(NSString *b) {
        //点击确定后执行
        NSLog(@"comeon");
        NOTIFY //继续执行
    }];
    [self.stAlertView show];
    
}
- (void)testAlert1
{
    UIAlertView *view= [[UIAlertView alloc] initWithTitle:@"标题" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [view show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        NSLog(@"cancel");
        NOTIFY //继续执行
    }else{
        NSLog(@"comeon");
        NOTIFY //继续执行

    }
}

/*
    期望
 */
- (void)testAsynExample
{
    //设置预期，如果预期通过，要调用fulfill，未通过打印"断言未满足"
    XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"断言未满足"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        sleep(2);
        //两秒后判断断言是否满足
        XCTAssertEqual(@"a", @"a");
        //断言通过，调用fulfill宣布测试满足
        [exp fulfill];
    }];
    //只有1秒，测试不通过
    [self waitForExpectations:@[exp] timeout:3.0];
    
}
/*
 通过谓词判断
 */
- (void)testThatBackgroundImageChanges
{
    //设置预期，如果预期通过，要调用fulfill，未通过打印"断言未满足"

//    XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"断言未满足"];
    XCTAssertNil([self.button backgroundImageForState:UIControlStateNormal]);
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(UIButton *button, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [button backgroundImageForState:UIControlStateNormal]!=nil;
    }];
    [self expectationForPredicate:predicate evaluatedWithObject:self.button handler:nil];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(5);
        dispatch_async(dispatch_get_main_queue(),^{
            [weakself.button setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        });

    });
    [self waitForExpectationsWithTimeout:10 handler:nil];
//    [self waitForExpectations:@[exp] timeout:10];
}

- (void)testAsynExample1
{
    [self expectationForNotification:(@"监听通知的名称xxx") object:nil handler:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"监听通知的名称xxx" object:nil];
    //设置延迟多少秒后，如果没有满足测试条件就报错
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

@end















