//
//  W1D5Tests.m
//  W1D5Tests
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface W1D5Tests : XCTestCase

@end

@implementation W1D5Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) fly {}

-(void) run {}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    SEL aSelector1 = @selector(fly);
    BOOL result1 = [W1D5Tests instancesRespondToSelector:aSelector1];
    XCTAssertTrue(result1);
}

- (void) test2 {

    SEL aSelector = NSSelectorFromString(@"run");
    XCTAssertTrue([W1D5Tests instancesRespondToSelector:aSelector]);

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
