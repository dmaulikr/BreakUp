//
//  AudioMuteButtonNode.m
//  BreakUp
//
//  Created by Apple on 5/13/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "AudioMuteButtonNode.h"

@implementation AudioMuteButtonNode

+ (instancetype)AudioButtonAtPosition:(CGPoint)position
{
    AudioMuteButtonNode *audioButton = [self spriteNodeWithImageNamed:@"Audio_Mute_Off"];
    audioButton.position = position;
    audioButton.name = @"AudioMute";
    audioButton.zPosition = 9999;
    return audioButton;
}

@end
