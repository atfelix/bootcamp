//
//  StoryPart.h
//  AVStorybook
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AVFoundation;

@interface StoryPart : NSObject

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;

-(instancetype)initWithString:(NSString *)string;

@end
