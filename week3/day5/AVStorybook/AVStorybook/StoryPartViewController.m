//
//  ViewController.m
//  AVStorybook
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "StoryPartViewController.h"

#import "StoryPartManager.h"
#import "StoryPart.h"

@interface StoryPartViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) StoryPartManager *manager;
@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;

@end

@implementation StoryPartViewController

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

- (IBAction)toggleRecord:(UIButton *)sender {
    if (self.manager.storyPages[0].audioRecorder.isRecording) {
        [self.manager.storyPages[0].audioRecorder stop];
        [sender setTitle:@"Record Audio"
                forState:UIControlStateNormal];
    }
    else {
        [sender setTitle:@"Stop Recording"
                forState:UIControlStateNormal];
        [self.manager.storyPages[0].audioRecorder record];
    }
}

- (IBAction)playRecording:(UITapGestureRecognizer *)sender {
    if (!self.storyImageView.image) {
        return;
    }

    if (self.manager.storyPages[0].audioPlayer.isPlaying) {
        [self.manager.storyPages[0].audioPlayer stop];
    }
    else {
        [self.manager.storyPages[0].audioPlayer play];
        self.manager.storyPages[0].audioPlayer.currentTime = 0;
    }
}


#pragma mark UIImagePickerControllerDelegate


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.storyImageView.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}


@end
