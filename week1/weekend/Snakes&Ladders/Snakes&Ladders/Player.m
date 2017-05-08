//
//  Player.m
//  Snakes&Ladders
//
//  Created by atfelix on 2017-05-07.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Player.h"

#import "InputCollector.h"

@implementation Player

-(instancetype)init {
    return [[Player alloc] initWithName:@"default"];
}

-(instancetype)initWithName:(NSString *)nameString {

    self = [super init];
    if (self) {
        _currentSquare = 0;
        _name = nameString;
    }
    return self;
}

-(NSString *)description {
    return self.name;
}

@end
