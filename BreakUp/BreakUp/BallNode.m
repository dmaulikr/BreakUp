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
    BallNode *ball = [self spriteNodeWithImageNamed:@"Pinball"];
    ball.position = position;
    ball.name = @"Pinball";
    ball.zPosition = 8;
//    ball.size = CGSizeMake(0.5, 0.5);
//    ball.xScale = 0.8;
//    ball.yScale = 0.8;
    
    [ball setupPhysicsBody];
//    if (ball.position.y > 200)
//    {
//        ball.physicsBody.restitution = 1.0;
//    }
    
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
