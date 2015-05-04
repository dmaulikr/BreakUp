//
//  DrainNode.m
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "DrainNode.h"
#import "Utilites.h"

@implementation DrainNode

+ (instancetype)drainWithSize:(CGSize)size
{
    DrainNode *drain = [self spriteNodeWithColor:[SKColor greenColor] size:size];
    drain.name = @"Drain";
    drain.position = CGPointMake(size.width/2, size.height/2-70);
    drain.zPosition = 7;
    
    [drain setupPhysicsBody];
    return drain;
    
}

- (void)setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryDrain;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryBall | CollisionCategoryBrick;
}

@end
