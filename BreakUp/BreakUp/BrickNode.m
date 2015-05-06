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
        brick = [self spriteNodeWithImageNamed:@"Brick_Double_Hit"];
        textures = @[[SKTexture textureWithImageNamed:@"Brick_Double_Hit"]];
        brick.type = BrickTypeA;
    }
    if (type == BrickTypeB)
    {
        brick = [self spriteNodeWithImageNamed:@"Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Brick"]];
        brick.type = BrickTypeB;
    }
//    brick.name = @"Brick";
//    brick.position = position;
    brick.zPosition = 8;
   
    [brick setupPhysicsBody];
    return brick;
}

+ (instancetype)moveBricks:(BrickNode *)brick
{
//    BrickNode *brick;
    NSArray *sequence = @[[SKAction waitForDuration:0.0],
                          [SKAction moveByX:0 y:BrickDropSpeed duration:BrickDurationSpeed]];
    SKAction *repeatMove = [SKAction repeatActionForever:[SKAction sequence:sequence]];
    
    [brick runAction:repeatMove];
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
            textures = @[[SKTexture textureWithImageNamed:@"Brick_Double_Hit_Cracked"]];
        }
//        else
//        {
//            textures = @[[SKTexture textureWithImageNamed:@""]];
//        }
        
        SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
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
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = CollisionCategoryBrick;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryBall | CollisionCategoryDrain;
    self.physicsBody.restitution = 0.5;
}

@end
