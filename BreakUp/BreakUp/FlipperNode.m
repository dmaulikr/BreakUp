//
//  FlipperNode.m
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "FlipperNode.h"
#import "Utilites.h"

@interface FlipperNode ()

@end

@implementation FlipperNode


+ (instancetype)leftFlipperAtPosition:(CGPoint)position
{
    FlipperNode *flipperLeft = [self spriteNodeWithImageNamed:@"Demo_Flipper_Left"];
//    SKShader *bloom = [SKShader shaderWithFileNamed:@"bloom"];
    
    flipperLeft.position = position;
    flipperLeft.anchorPoint = CGPointMake(0.1, 0.8);
    flipperLeft.name = @"LeftFlipper";
    flipperLeft.zPosition = 7;
    
    CGFloat offsetX = flipperLeft.frame.size.width * flipperLeft.anchorPoint.x;
    CGFloat offsetY = flipperLeft.frame.size.height * flipperLeft.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 25 - offsetX, 71 - offsetY);
    CGPathAddLineToPoint(path, NULL, 166 - offsetX, 17 - offsetY);
    CGPathAddLineToPoint(path, NULL, 169 - offsetX, 14 - offsetY);
    CGPathAddLineToPoint(path, NULL, 171 - offsetX, 12 - offsetY);
    CGPathAddLineToPoint(path, NULL, 172 - offsetX, 9 - offsetY);
    CGPathAddLineToPoint(path, NULL, 171 - offsetX, 6 - offsetY);
    CGPathAddLineToPoint(path, NULL, 170 - offsetX, 3 - offsetY);
    CGPathAddLineToPoint(path, NULL, 169 - offsetX, 1 - offsetY);
    CGPathAddLineToPoint(path, NULL, 164 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 6 - offsetX, 39 - offsetY);
    CGPathAddLineToPoint(path, NULL, 2 - offsetX, 43 - offsetY);
    CGPathAddLineToPoint(path, NULL, 1 - offsetX, 47 - offsetY);
    CGPathAddLineToPoint(path, NULL, 1 - offsetX, 53 - offsetY);
    CGPathAddLineToPoint(path, NULL, 2 - offsetX, 59 - offsetY);
    CGPathAddLineToPoint(path, NULL, 4 - offsetX, 64 - offsetY);
    CGPathAddLineToPoint(path, NULL, 8 - offsetX, 67 - offsetY);
    CGPathAddLineToPoint(path, NULL, 13 - offsetX, 69 - offsetY);
    CGPathAddLineToPoint(path, NULL, 18 - offsetX, 71 - offsetY);
    
    
    // Angle_Flipper
//    CGPathMoveToPoint(path, NULL, 21 - offsetX, 78 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 149 - offsetX, 32 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 152 - offsetX, 30 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 154 - offsetX, 25 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 154 - offsetX, 21 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 153 - offsetX, 18 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 149 - offsetX, 15 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 2 - offsetX, 68 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 4 - offsetX, 72 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 8 - offsetX, 76 - offsetY);
    
    CGPathCloseSubpath(path);
    
    flipperLeft.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    
    
    
    [flipperLeft setupPhysicsBodyLeft];
//    flipperLeft.shader = bloom;
//    flipperLeft.blendMode = SKBlendModeAdd;
    return flipperLeft;
}

+ (instancetype)rightFlipperAtPosition:(CGPoint)position
{
    FlipperNode *flipperRight = [self spriteNodeWithImageNamed:@"Demo_Flipper_Right"];
//    SKShader *bloom = [SKShader shaderWithFileNamed:@"bloom"];
    
    flipperRight.position = position;
    flipperRight.anchorPoint = CGPointMake(0.9, 0.8);
    flipperRight.name = @"RightFlipper";
    flipperRight.zPosition = 7;
    
    CGFloat offsetX = flipperRight.frame.size.width * flipperRight.anchorPoint.x;
    CGFloat offsetY = flipperRight.frame.size.height * flipperRight.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 149 - offsetX, 71 - offsetY);
    CGPathAddLineToPoint(path, NULL, 3 - offsetX, 14 - offsetY);
    CGPathAddLineToPoint(path, NULL, 2 - offsetX, 12 - offsetY);
    CGPathAddLineToPoint(path, NULL, 1 - offsetX, 9 - offsetY);
    CGPathAddLineToPoint(path, NULL, 2 - offsetX, 5 - offsetY);
    CGPathAddLineToPoint(path, NULL, 3 - offsetX, 3 - offsetY);
    CGPathAddLineToPoint(path, NULL, 6 - offsetX, 1 - offsetY);
    CGPathAddLineToPoint(path, NULL, 11 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 172 - offsetX, 46 - offsetY);
    CGPathAddLineToPoint(path, NULL, 172 - offsetX, 53 - offsetY);
    CGPathAddLineToPoint(path, NULL, 172 - offsetX, 58 - offsetY);
    CGPathAddLineToPoint(path, NULL, 170 - offsetX, 62 - offsetY);
    CGPathAddLineToPoint(path, NULL, 166 - offsetX, 66 - offsetY);
    CGPathAddLineToPoint(path, NULL, 162 - offsetX, 69 - offsetY);
    CGPathAddLineToPoint(path, NULL, 157 - offsetX, 71 - offsetY);
    
    // Angle_Flipper
//    CGPathMoveToPoint(path, NULL, 146 - offsetX, 78 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 16 - offsetX, 32 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 14 - offsetX, 29 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 13 - offsetX, 26 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 12 - offsetX, 23 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 13 - offsetX, 20 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 16 - offsetX, 16 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 163 - offsetX, 71 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 160 - offsetX, 75 - offsetY);
//    CGPathAddLineToPoint(path, NULL, 156 - offsetX, 77 - offsetY);
    
    CGPathCloseSubpath(path);
    
    flipperRight.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    
    
    
    [flipperRight setupPhysicsBodyRight];
//    flipperRight.shader = bloom;
//    flipperRight.blendMode = SKBlendModeAdd;
    return flipperRight;
}

- (void)setupPhysicsBodyRight
{
    self.physicsBody.affectedByGravity = NO;
    
    self.physicsBody.categoryBitMask = CollisionCategoryFlipperRight;
    self.physicsBody.collisionBitMask = CollisionCategoryBall;
    self.physicsBody.contactTestBitMask = CollisionCategoryBall;
    self.physicsBody.dynamic = NO;
    self.physicsBody.restitution = 0.5; //bounce
}

- (void)setupPhysicsBodyLeft
{
    self.physicsBody.affectedByGravity = NO;
    
    self.physicsBody.categoryBitMask = CollisionCategoryFlipperLeft;
    self.physicsBody.collisionBitMask = CollisionCategoryBall;
    self.physicsBody.contactTestBitMask = CollisionCategoryBall;
    self.physicsBody.dynamic = NO;
    self.physicsBody.restitution = 0.5; //bounce
}


@end
