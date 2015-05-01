//
//  BrickNode.h
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, BrickType)
{
    BrickTypeA
};

@interface BrickNode : SKSpriteNode

//+ (instancetype)brickAtPosition:(CGPoint)position;
@property (nonatomic, getter = isDamaged) BOOL damaged;
@property (nonatomic) BrickType type;

+ (instancetype)brickRowOfType:(BrickType)type;

@end
