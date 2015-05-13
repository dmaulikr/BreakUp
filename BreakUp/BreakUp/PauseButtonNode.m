//
//  PauseButtonNode.m
//  BreakUp
//
//  Created by Apple on 5/13/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "PauseButtonNode.h"

@implementation PauseButtonNode

+ (instancetype)pauseButtonAtPosition:(CGPoint)position
{
    PauseButtonNode *pauseButton = [self spriteNodeWithImageNamed:@"Pause_Button"];
    pauseButton.position = position;
    pauseButton.name = @"PauseButton";
    pauseButton.zPosition = 99;
    return pauseButton;
}

@end
