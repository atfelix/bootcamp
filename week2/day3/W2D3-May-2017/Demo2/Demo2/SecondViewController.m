//
//  SecondViewController.m
//  Demo2
//
//  Created by steve on 2017-05-09.
//  Copyright © 2017 steve. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //  [self performSelector:@selector(nextViewController) withObject:self afterDelay:10];
    
}

- (void)setData:(NSString *)data {
  _data = data;
}

-(void)dealloc {

}

- (void)nextViewController {
  // go to the next VC as a modal segue
  
}

// create unwind segue here




@end
