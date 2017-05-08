//
//  Player.h
//  Snakes&Ladders
//
//  Created by atfelix on 2017-05-07.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, assign) NSInteger currentSquare;
@property (nonatomic, copy) NSString *name;

-(instancetype) initWithName:(NSString *) nameString;
-(NSString *) score;

@end
