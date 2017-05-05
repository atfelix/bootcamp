//
//  PlayerTests.m
//  W1D5
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Player.h"
#import "AppleMusic.h"
#import "Spotify.h"

@interface PlayerTests : XCTestCase

@property (nonatomic) Player *player;

@end

@implementation PlayerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.player = [[Player alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAppleExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    self.player.delegate = [[AppleMusic alloc] init];
    [self.player play];
}

- (void)testSpotifyExample {
    self.player.delegate = [[Spotify alloc] init];
    [self.player play];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
