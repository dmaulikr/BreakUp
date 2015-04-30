//
//  WallNode.m
//  BreakUp
//
//  Created by Apple on 4/29/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "WallNode.h"
#import "Utilites.h"

@implementation WallNode

+ (instancetype)wallAtPosition:(CGPoint)position
{
    WallNode *wall = [self spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(10, 5000)];
    wall.name = @"Wall";
    wall.position = position;
    wall.zPosition = 10;
    
    [wall setupPhysicsBody];
    return wall;
}

- (void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryWall;
    self.physicsBody.collisionBitMask = CollisionCategoryBall;
    self.physicsBody.contactTestBitMask = CollisionCategoryBall;
}

@end
