//
//  Ball.m
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "BallNode.h"
#import "Utilites.h"

@implementation BallNode

+ (instancetype)ballAtPosition:(CGPoint)position
{
//    SKShader *bloom = [SKShader shaderWithFileNamed:@"bloom"];
    BallNode *ball = [self spriteNodeWithImageNamed:@"Pinball"];
    ball.position = position;
    ball.name = @"Pinball";
    ball.zPosition = 8;
    
//    ball.shader = bloom;
//    ball.blendMode = SKBlendModeAdd;
    [ball setupPhysicsBody];
    
    return ball;
}

- (void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width / 2]; // width / 2
//    self.physicsBody.affectedByGravity = YES;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryBall;
    self.physicsBody.collisionBitMask = CollisionCategoryFlipperLeft | CollisionCategoryFlipperRight | CollisionCategoryBrick | CollisionCategoryWall | CollisionCategoryFlipperGuard;
    self.physicsBody.contactTestBitMask = CollisionCategoryDrain | CollisionCategoryBrick | CollisionCategoryFlipperLeft | ~CollisionCategoryWall;
    self.physicsBody.usesPreciseCollisionDetection = YES;
//    self.physicsBody.restitution = 1.0; // BOUNCE
    self.physicsBody.density = 1.5;
//    self.physicsBody.linearDamping = 1.5;
    
}

@end
