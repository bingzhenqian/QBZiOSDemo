//
//  TestTestUITests.m
//  TestTestUITests
//
//  Created by qianbingzhen on 2018/3/9.
//  Copyright © 2018年 qian. All rights reserved.
//https://onevcat.com/2015/09/ui-testing/  OneV's Den
//https://www.jianshu.com/p/aae160cb9cc4  iOS UI自动化测试
//https://www.jianshu.com/p/beca453f7a24   iOS UI测试

#import <XCTest/XCTest.h>

@interface TestTestUITests : XCTestCase

@end

@implementation TestTestUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //XCUIApplication
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"testButton"] tap];
    XCUIElement *textView = app.alerts.staticTexts[@"Empty username/password"];
    XCUIElementQuery *alerts = app.alerts;
    NSLog(@"%@",alerts);
    NSPredicate *alertCount = [NSPredicate predicateWithFormat:@"count == 1"];
    NSPredicate *labelExist = [NSPredicate predicateWithFormat:@"exists == 1"];
    [self expectationForPredicate:alertCount evaluatedWithObject:alerts handler:nil];
    [self expectationForPredicate:labelExist evaluatedWithObject:textView handler:nil];
    
    [self waitForExpectationsWithTimeout:5 handler: nil];
    
}
- (void)testA {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *usertextfieldTextField = app.textFields[@"userTextField"];
    [usertextfieldTextField tap];
    [usertextfieldTextField typeText:@"qqq"];
    
    XCUIElement *passwordtextfieldTextField = app.textFields[@"passwordTextField"];
    [passwordtextfieldTextField tap];
    [passwordtextfieldTextField tap];
    [passwordtextfieldTextField typeText:@"111"];
    [app/*@START_MENU_TOKEN@*/.buttons[@"loginButton"]/*[[".buttons[@\"login\"]",".buttons[@\"loginButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
}

@end














