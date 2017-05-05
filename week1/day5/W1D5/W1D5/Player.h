//
//  Player.h
//  W1D5
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlayerDelegate <NSObject>

-(void) playMusic;

@end

@interface Player : NSObject

@property (nonatomic) id<PlayerDelegate> delegate;

-(void) play;

@end
