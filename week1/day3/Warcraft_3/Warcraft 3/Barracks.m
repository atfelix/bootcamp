//
//  Barracks.m
//  
//
//  Created by Daniel Mathews on 2015-07-31.
//
//

#import "Barracks.h"
#import "Footman.h"
#import "Peasant.h"

@implementation Barracks

- (instancetype)init {

    self = [super init];
    if (self) {
        _gold = 1000;
        _food = 80;
    }
    return self;
}

-(id)trainFootman {
    if (![self canTrainFootman]) {
        return nil;
    }

    self.gold -= 135;
    self.food -= 2;

    return [[Footman alloc] init];
}

-(BOOL)canTrainFootman {
    return (self.gold >= 135) && (self.food >= 2);
}

-(Peasant *)trainPeasant {

    if (![self canTrainPeasant]) {
        return nil;
    }

    self.gold -= 90;
    self.food -= 5;

    return [[Peasant alloc] init];
}

-(BOOL)canTrainPeasant {
    return (self.gold >= 90) && (self.food >= 5);
}

@end
