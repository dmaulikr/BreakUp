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
//    BrickNode *trailSprite1;
    brick.damaged = NO;
    SKShader *bloom = [SKShader shaderWithFileNamed:@"bloom"];

    NSArray *textures;
    
    if (type == BrickTypeRed)
    {
        brick = [self spriteNodeWithImageNamed:@"Red_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Red_Brick"]];
        brick.type = BrickTypeRed;
    }
    if (type == BrickTypePink)
    {
        brick = [self spriteNodeWithImageNamed:@"Pink_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Pink_Brick"]];
        brick.type = BrickTypePink;
    }
    if (type == BrickTypeCyan)
    {
        brick = [self spriteNodeWithImageNamed:@"Cyan_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Cyan_Brick"]];
        brick.type = BrickTypeCyan;
    }
    if (type == BrickTypeBlue)
    {
        brick = [self spriteNodeWithImageNamed:@"Blue_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Blue_Brick"]];
        brick.type = BrickTypeBlue;
    }
    if (type == BrickTypeGreen)
    {
        brick = [self spriteNodeWithImageNamed:@"Green_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Green_Brick"]];
        brick.type = BrickTypeGreen;
    }
    if (type == BrickTypeYellow)
    {
        brick = [self spriteNodeWithImageNamed:@"Yellow_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Yellow_Brick"]];
        brick.type = BrickTypeCyan;
    }
    if (type == BrickTypePurple)
    {
        brick = [self spriteNodeWithImageNamed:@"Purple_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Purple_Brick"]];
        brick.type = BrickTypeBlue;
    }
    brick.zPosition = 8;
    brick.name = @"Brick";
    [brick setupPhysicsBody];
    brick.shader = bloom;
    brick.blendMode = SKBlendModeAdd;

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
        if (self.type == BrickTypeRed)
        {
            textures = @[[SKTexture textureWithImageNamed:@"Red_Brick_Damaged"]];
        }
        if (self.type == BrickTypePink)
        {
            textures = @[[SKTexture textureWithImageNamed:@"Pink_Brick_Damaged"]];
        }
        if (self.type == BrickTypeYellow)
        {
            textures = @[[SKTexture textureWithImageNamed:@"Yellow_Brick_Damaged"]];
        }
        if (self.type == BrickTypePurple)
        {
            textures = @[[SKTexture textureWithImageNamed:@"Purple_Brick_Damaged"]];
        }
        if (self.type == BrickTypeGreen)
        {
            textures = @[[SKTexture textureWithImageNamed:@"Green_Brick_Damaged"]];
        }
        if (self.type == BrickTypeCyan)
        {
            textures = @[[SKTexture textureWithImageNamed:@"Cyan_Brick_Damaged"]];
        }
        if (self.type == BrickTypeBlue)
        {
            textures = @[[SKTexture textureWithImageNamed:@"Blue_Brick_Damaged"]];
        }
        
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
