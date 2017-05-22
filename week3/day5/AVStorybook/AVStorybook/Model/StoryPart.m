//
//  StoryPart.m
//  AVStorybook
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "StoryPart.h"

@interface StoryPart ()

@property (nonatomic, strong) NSURL *savedAudioURL;

@end

@implementation StoryPart

- (instancetype)initWithString:(NSString *)string {

    self = [super init];
    if (self) {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                            NSUserDomainMask,
                                                                            YES) firstObject];
        _savedAudioURL = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:string]];
        [self createAudioRecorder];
    }
    return self;
}

-(void)createAudioPlayer {
    NSError *error = nil;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_savedAudioURL
                                                          error:&error];
    if (error) {
        [self logError:error
           withMessage:[NSString stringWithFormat:@"Error creating audio player: %@", error.localizedDescription]];
    }
}

-(void)createAudioRecorder {
    NSError *error = nil;
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:_savedAudioURL
                                                 settings:@{AVFormatIDKey: @(kAudioFormatMPEG4AAC),
                                                            AVSampleRateKey: @(44100),
                                                            AVNumberOfChannelsKey:@(2)
                                                            }
                                                    error:&error];
    [self logError:error
       withMessage:[NSString stringWithFormat:@"Error creating audio player:%@", error.localizedDescription]];

}

-(void)logError:(NSError *)error withMessage:(NSString *)string {
    if (error != nil) {
        NSLog(@"%@", string);
    }
}

@end
