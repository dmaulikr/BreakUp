//
//  BrickNode.m
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "BrickNode.h"
#import "Utilites.h"

@implementation BrickNode

+ (instancetype)brickAtPosition:(CGPoint)position
{
    BrickNode *brick = [BrickNode spriteNodeWithImageNamed:@"Brick"];
    brick.name = @"Brick";
    brick.position = position;
    brick.zPosition = 8;
    
    [brick setupPhysicsBody];
    return brick;
}

- (void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    
    self.physicsBody.categoryBitMask = CollisionCategoryBrick;
    self.physicsBody.collisionBitMask = CollisionCategoryBall | CollisionCategoryWall;
    self.physicsBody.contactTestBitMask = CollisionCategoryBall;
}

@end
