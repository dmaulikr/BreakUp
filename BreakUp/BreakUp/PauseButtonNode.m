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
    
    [pauseButton setupPhysicsBody];
    return pauseButton;
}

- (void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.contactTestBitMask = 0;
    self.physicsBody.collisionBitMask = 0;
}

@end
