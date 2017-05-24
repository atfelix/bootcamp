//
//  SearchViewController.m
//  Cats
//
//  Created by atfelix on 2017-05-24.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveSearchTerms:(UIButton *)sender {
    if (self.parameterTextField.text) {
        [self.delegate saveParameters:self.parameterTextField.text];
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
}

@end
