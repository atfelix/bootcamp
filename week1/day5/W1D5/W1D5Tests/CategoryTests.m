//
//  CategoryTests.m
//  W1D5
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSString+AddStar.h"

@interface CategoryTests : XCTestCase

@end

@implementation CategoryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    NSString *string = @"Hello, World";
    NSString *newString = [string addStar];

    XCTAssertTrue([newString isEqualToString:@"Hello, World*"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
