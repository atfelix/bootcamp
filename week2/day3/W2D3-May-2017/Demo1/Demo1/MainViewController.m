//
//  MainViewController.m
//  Demo1
//
//  Created by steve on 2017-05-09.
//  Copyright © 2017 steve. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

/*
CUSTOM DOCUMENTATION (NB. Swift syntax is different + uses markdown)
*/

/**
 Another complicated function.
 
 @Param firstName The firstName used to generate the fullName.
 @Returns The fullName.
 
 @Remark
 There's a counterpart function that concatenates the first and last name into a full name.
 
 @SeeAlso  createFullName(_:lastname:)
 
 @Todo Support middle name in the next version.
 
 @Warning A wonderful crash will be the result of a `nil` argument.
 
 @Version 1.1
 
 @Author Steve
 
 @Note Too much documentation for such a small function.
 */
- (NSString *)fullNameFrom:(NSString *)firstName lastName:(NSString *)lastName {
  return [firstName stringByAppendingString:lastName];
}


@end
