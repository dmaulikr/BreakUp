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

//+ (instancetype)brickAtPosition:(CGPoint)position
//{
//    BrickNode *brick = [BrickNode spriteNodeWithImageNamed:@"Brick"];
//    brick.name = @"Brick";
//    brick.position = position;
//    brick.zPosition = 8;
//    
//    [brick setupPhysicsBody];
//    return brick;
//}

+ (instancetype)brickRowOfType:(BrickType)type
{
    BrickNode *brick;
    brick.damaged = NO;
    NSArray *textures;
    
    if (type == BrickTypeA)
    {
        brick = [self spriteNodeWithImageNamed:@"Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Brick"]];
        brick.type = BrickTypeA;
    }
//    brick.name = @"Brick";
//    brick.position = position;
    brick.zPosition = 8;
   
    [brick setupPhysicsBody];
    return brick;
}


-(BOOL)isDamaged
{
    NSArray *textures;
    
    if (!_damaged)
    {
//        [self removeActionForKey:@"animation"]; // removes the animation runAction
        if (self.type == BrickTypeA)
        {
            textures = @[[SKTexture textureWithImageNamed:@"Broken_Brick"]];
        }
//        else
//        {
//            textures = @[[SKTexture textureWithImageNamed:@""]];
//        }
        
        SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.4];
        [self runAction:[SKAction repeatActionForever:animation] withKey:@"damage_animation"];
        
        _damaged = YES;
        
        return NO;
    }    
    return _damaged;
}

- (void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryBrick;
    self.physicsBody.collisionBitMask = CollisionCategoryBall | CollisionCategoryWall;
    self.physicsBody.contactTestBitMask = CollisionCategoryBall;
}

@end
