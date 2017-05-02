//
//  Box.h
//  Boxes
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Box : NSObject

@property (nonatomic) float height;
@property (nonatomic) float width;
@property (nonatomic) float length;

-(instancetype) initWithHeight: (float) height Width: (float) width andLength: (float) length;

-(float) getVolume;

-(int) numberBoxesWhichFitinOtherBox: (Box *) otherBox;

@end
