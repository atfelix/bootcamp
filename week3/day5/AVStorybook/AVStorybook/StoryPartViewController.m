//
//  ViewController.m
//  AVStorybook
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "StoryPartViewController.h"

#import "StoryPart.h"

@interface StoryPartViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;

@end

@implementation StoryPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storyPart = [[StoryPart alloc] initWithString:@"banana"];
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
    if (self.storyPart.audioRecorder.isRecording) {
        [self.storyPart.audioRecorder stop];
        [sender setTitle:@"Record Audio"
                forState:UIControlStateNormal];
    }
    else {
        [sender setTitle:@"Stop Recording"
                forState:UIControlStateNormal];
        [self.storyPart.audioRecorder record];
    }
}

- (IBAction)playRecording:(UITapGestureRecognizer *)sender {
    if (!self.storyImageView.image) {
        return;
    }

    if (self.storyPart.audioPlayer.isPlaying) {
        [self.storyPart.audioPlayer stop];
    }
    else {
        [self.storyPart.audioPlayer play];
        self.storyPart.audioPlayer.currentTime = 0;
    }
}


#pragma mark UIImagePickerControllerDelegate


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.storyImageView.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}


@end
