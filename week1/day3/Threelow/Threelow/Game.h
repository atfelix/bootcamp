//
//  Game.h
//  Threelow
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#ifndef Game_h
#define Game_h

@protocol Game <NSObject>

-(void) takeTurn;
-(void) playGame;

@end


#endif /* Game_h */
