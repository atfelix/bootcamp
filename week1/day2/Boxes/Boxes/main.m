//
//  main.m
//  Boxes
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Box.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Box *theBox = [[Box alloc] initWithHeight:10
                                         Width:5
                                     andLength:2];

        Box *otherBox = [[Box alloc] initWithHeight:100
                                              Width:10
                                          andLength:5];

        NSLog(@"The volume of theBox is %f", [theBox getVolume]);
        NSLog(@"The volume of otherBox is %f", [otherBox getVolume]);
        NSLog(@"%d number of boxes of size theBox will fit in otherBox", [theBox numberBoxesWhichFitinOtherBox:otherBox]);

    }
    return 0;
}
