//
//  ProtocolTests.m
//  W1D5
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <XCTest/XCTest.h>

@protocol  MyProtocol <NSObject>

-(void) putYourMethodsHere;

@end

@interface MyClass : NSObject <MyProtocol>

-(void)putYourMethodsHere;

@end

@implementation MyClass

-(void)putYourMethodsHere {}

@end

@interface ProtocolTests : XCTestCase

@end

@implementation ProtocolTests

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
    BOOL conformsToProtocol  = [MyClass conformsToProtocol:@protocol(MyProtocol)];
    XCTAssertTrue(conformsToProtocol);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
