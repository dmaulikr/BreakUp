//
//  TrailingSpriteNode.m
//  BreakUp
//
//  Created by Apple on 5/11/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "TrailingSpriteNode.h"

@implementation TrailingSpriteNode

+ (instancetype)trailingSpriteAtPosition:(CGPoint)position
{
    
    TrailingSpriteNode *trailSprite = [self spriteNodeWithImageNamed:@"YourTexture"];
//    trailSprite1.zRotation = sprite.zRotation;
    trailSprite.blendMode = SKBlendModeAdd;
    trailSprite.position = position;
    [trailSprite runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0 duration:0.1],
                                                 [SKAction removeFromParent]]]];
    
    return trailSprite;
}

@end
