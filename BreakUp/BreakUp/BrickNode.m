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


// Add a new brick row with different color for patterns...
//+ (instancetype)brickRowOfType:(BrickType)type AndBrickColor:(SKColor *)color
//{
//    BrickNode *brick;
//    SKShader *bloom = [SKShader shaderWithFileNamed:@"bloom"];
//    brick.damaged = NO;
//    
////    NSArray *textures;
//    if (type == BrickTypeA)
//    {
//        brick = [self spriteNodeWithColor:color size:CGSizeMake(50, 20)];
////        textures = @[[SKTexture textureWithImageNamed:@"Brick_Double_Hit"]];
//        brick.type = BrickTypeA;
//    }
//    if (type == BrickTypeB)
//    {
//        brick = [self spriteNodeWithColor:color size:CGSizeMake(50, 20)];
////        textures = @[[SKTexture textureWithImageNamed:@"Brick"]];
//        brick.type = BrickTypeB;
//    }
////    brick.name = @"Brick";
////    brick.position = position;
//    brick.zPosition = 8;
//
//    
//    [brick setupPhysicsBody];
//    brick.shader = bloom;
//    return brick;
//}

+ (instancetype)brickRowOfType:(BrickType)type
{
    BrickNode *brick;
    BrickNode *trailSprite1;
    brick.damaged = NO;
    SKShader *bloom = [SKShader shaderWithFileNamed:@"bloom"];

    NSArray *textures;
    
    if (type == BrickTypeA)
    {
        brick = [self spriteNodeWithImageNamed:@"Red_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Red_Brick"]];
        trailSprite1 = [self spriteNodeWithImageNamed:@"Red_Brick"];
        brick.type = BrickTypeA;
    }
    if (type == BrickTypeB)
    {
        brick = [self spriteNodeWithImageNamed:@"Pink_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Pink_Brick"]];
        trailSprite1 = [self spriteNodeWithImageNamed:@"Pink_Brick"];
        brick.type = BrickTypeB;
    }
//    brick.name = @"Brick";
//    brick.position = position;
    brick.zPosition = 8;
   
    brick.name = @"Brick";
    [brick setupPhysicsBody];
    brick.shader = bloom;
    brick.blendMode = SKBlendModeAdd;
//    SKNode *sprite = [world childNodeWithName:@"Brick"];
    
//    trailSprite1 = [SKSpriteNode spriteNodeWithImageNamed:@"Red_Brick"];
    trailSprite1.zRotation = brick.zRotation;
    trailSprite1.blendMode = SKBlendModeAdd;
    trailSprite1.position = CGPointMake(brick.position.x, brick.position.y -2);
    
    [brick addChild:trailSprite1];
    
    [trailSprite1 runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0 duration:1.0],
                                                 [SKAction removeFromParent]]]];
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

//+ (instancetype)addTrailingSprite:(NSString *)texture AndWorld:(SKNode *)world
//{
//    
//}


-(BOOL)isDamaged       // RCL: find out how to animate this over the colored physics body
{
    NSArray *textures;
    
    if (!_damaged)
    {
//        [self removeActionForKey:@"animation"]; // removes the animation runAction
        if (self.type == BrickTypeA)
        {
            textures = @[[SKTexture textureWithImageNamed:@"Red_Brick_Damaged"]];
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
