//
//  ViewController.m
//  AVStorybook
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "StoryPartManager.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) StoryPartManager *manager;
@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[StoryPartManager alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Button actions


- (IBAction)getPicture:(UIButton *)sender {
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    imagePC.sourceType = (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                          ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary);

    imagePC.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePC.sourceType];
    imagePC.delegate = self;

    [self presentViewController:imagePC
                       animated:YES
                     completion:nil];
}


#pragma mark UIImagePickerControllerDelegate


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.storyImageView.image = info[UIImagePickerControllerOriginalImage];
    NSLog(@"%@", info[UIImagePickerControllerOriginalImage]);
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}


@end
