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
    BallNode *ball = [self spriteNodeWithImageNamed:@"Ball"];
    ball.position = position;
    ball.name = @"Ball";
    ball.zPosition = 8;
    
    [ball setupPhysicsBody];
    
    return ball;
}

- (void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width / 2]; // width / 2
//    self.physicsBody.affectedByGravity = YES;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryBall;
    self.physicsBody.collisionBitMask = CollisionCategoryFlipper | CollisionCategoryBrick | CollisionCategoryWall;
    self.physicsBody.contactTestBitMask = CollisionCategoryDrain | CollisionCategoryBrick | CollisionCategoryFlipper | ~CollisionCategoryWall;
    self.physicsBody.usesPreciseCollisionDetection = YES;
//    self.physicsBody.restitution = 1.5; // BOUNCE
    self.physicsBody.density = 1.5;
//    self.physicsBody.linearDamping = 1.5;
}


@end
