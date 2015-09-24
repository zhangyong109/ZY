//
//  ____Tests.m
//  轨迹动画Tests
//
//  Created by ZY on 15/4/21.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface ____Tests : XCTestCase

@end

@implementation ____Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testViewDidLoad {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}
- (void)testTrue2 {
    NSLog(@"2222222222222222222222");
    XCTAssert(1, @"Can not be zero");
}

- (void)testTrue1 {
    NSLog(@"1111111111111111111111");
    XCTAssert(1, @"Can not be zero");
}

- (void)testTrue3 {
    NSLog(@"3333333333333333333333");
    XCTAssert(1, @"Can not be zero");
}

- (void)testAtrue {
    NSLog(@"0000000000000000000000");
    XCTAssert(1, @"Can not be zero");
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
