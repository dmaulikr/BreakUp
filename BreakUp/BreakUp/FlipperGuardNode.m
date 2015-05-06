//
//  FlipperGuardNode.m
//  BreakUp
//
//  Created by Apple on 5/6/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "FlipperGuardNode.h"
#import "Utilites.h"

@implementation FlipperGuardNode

+ (instancetype)leftFlipperGuardAtPosition:(CGPoint)position
{
    FlipperGuardNode *leftGuard = [self spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(50, 5)];
    leftGuard.position = position;
    leftGuard.zRotation = M_PI/-6.0f;
    
    [leftGuard setupPhysicsBody];
    return leftGuard;
}

+ (instancetype)rightFlipperGuardAtPosition:(CGPoint)position
{
    FlipperGuardNode *rightGuard = [self spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(50, 5)];
    rightGuard.position = position;
    rightGuard.zRotation = M_PI/6.0f;
    
    [rightGuard setupPhysicsBody];
    return rightGuard;
}

- (void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryFlipperGuard;
    self.physicsBody.collisionBitMask = CollisionCategoryBall;
    self.physicsBody.contactTestBitMask = CollisionCategoryBall;
    self.physicsBody.dynamic = NO;
    self.physicsBody.restitution = 0.5; //bounce
}


@end
