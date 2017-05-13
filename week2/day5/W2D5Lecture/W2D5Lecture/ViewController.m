//
//  ViewController.m
//  W2D5Lecture
//
//  Created by atfelix on 2017-05-12.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches moved in view controller");
}

- (IBAction)magentaBoxTapped:(id)sender {
    NSLog(@"magenta box tapped");
}

- (IBAction)viewBoxTapped:(id)sender {
    NSLog(@"view box tapped");
}

@end
