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


+ (instancetype)brickRowOfType:(BrickType)type
{
    BrickNode *brick;
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
    if (type == BrickTypeBlue)
    {
        brick = [self spriteNodeWithImageNamed:@"Blue_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Blue_Brick"]];
        brick.type = BrickTypeBlue;
    }
    if (type == BrickTypeCyan)
    {
        brick = [self spriteNodeWithImageNamed:@"Cyan_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Cyan_Brick"]];
        brick.type = BrickTypeCyan;
    }
    if (type == BrickTypeGreen)
    {
        brick = [self spriteNodeWithImageNamed:@"Green_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Green_Brick"]];
        brick.type = BrickTypeGreen;
    }
    if (type == BrickTypePurple)
    {
        brick = [self spriteNodeWithImageNamed:@"Purple_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Purple_Brick"]];
        brick.type = BrickTypePurple;
    }
    if (type == BrickTypeYellow)
    {
        brick = [self spriteNodeWithImageNamed:@"Yellow_Brick"];
        textures = @[[SKTexture textureWithImageNamed:@"Yellow_Brick"]];
        brick.type = BrickTypeYellow;
    }
    brick.zPosition = 6;
    brick.name = @"Brick";
    [brick setupPhysicsBody];
    brick.shader = bloom;
    brick.blendMode = SKBlendModeAdd;

    return brick;
}

+ (instancetype)moveBricks:(BrickNode *)brick
{
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
