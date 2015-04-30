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

//@property (nonatomic) SKAction *tapActionLeft;
//@property (nonatomic) SKAction *tapActionRight;

@end

@implementation FlipperNode


+ (instancetype)leftFlipperAtPosition:(CGPoint)position
{
    FlipperNode *flipperLeft = [self spriteNodeWithImageNamed:@"Flipper_left"];
    
    flipperLeft.position = position;
    flipperLeft.anchorPoint = CGPointMake(0.2, 0.5);
    flipperLeft.name = @"LeftFlipper";
    flipperLeft.zPosition = 7;
    //    flipperLeft.size = CGSizeMake(flipperLeft.size.width, flipperLeft.size.height);
    
    CGFloat offsetX = flipperLeft.frame.size.width * flipperLeft.anchorPoint.x;
    CGFloat offsetY = flipperLeft.frame.size.height * flipperLeft.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 24 - offsetX, 60 - offsetY);
    CGPathAddLineToPoint(path, NULL, 144 - offsetX, 48 - offsetY);
    CGPathAddLineToPoint(path, NULL, 146 - offsetX, 46 - offsetY);
    CGPathAddLineToPoint(path, NULL, 149 - offsetX, 44 - offsetY);
    CGPathAddLineToPoint(path, NULL, 151 - offsetX, 39 - offsetY);
    CGPathAddLineToPoint(path, NULL, 152 - offsetX, 34 - offsetY);
    CGPathAddLineToPoint(path, NULL, 151 - offsetX, 30 - offsetY);
    CGPathAddLineToPoint(path, NULL, 149 - offsetX, 23 - offsetY);
    CGPathAddLineToPoint(path, NULL, 144 - offsetX, 20 - offsetY);
    CGPathAddLineToPoint(path, NULL, 25 - offsetX, 14 - offsetY);
    CGPathAddLineToPoint(path, NULL, 12 - offsetX, 39 - offsetY);
    CGPathAddLineToPoint(path, NULL, 13 - offsetX, 48 - offsetY);
    CGPathAddLineToPoint(path, NULL, 15 - offsetX, 54 - offsetY);
    CGPathAddLineToPoint(path, NULL, 19 - offsetX, 58 - offsetY);
    
    CGPathCloseSubpath(path);
    
    flipperLeft.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    

    
    
    
    
    
    [flipperLeft setupPhysicsBody];
    return flipperLeft;
}

+ (instancetype)rightFlipperAtPosition:(CGPoint)position
{
    FlipperNode *flipperRight = [self spriteNodeWithImageNamed:@"Flipper_Right"];
    
    flipperRight.position = position;
    flipperRight.anchorPoint = CGPointMake(0.8, 0.5);
    flipperRight.name = @"RightFlipper";
    flipperRight.zPosition = 7;
//    flipperRight.centerRect = 5;
//    flipperRight.size = CGSizeMake(flipperRight.size.width, flipperRight.size.height);
    
    CGFloat offsetX = flipperRight.frame.size.width * flipperRight.anchorPoint.x;
    CGFloat offsetY = flipperRight.frame.size.height * flipperRight.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 138 - offsetX, 60 - offsetY);
    CGPathAddLineToPoint(path, NULL, 20 - offsetX, 47 - offsetY);
    CGPathAddLineToPoint(path, NULL, 15 - offsetX, 43 - offsetY);
    CGPathAddLineToPoint(path, NULL, 13 - offsetX, 40 - offsetY);
    CGPathAddLineToPoint(path, NULL, 12 - offsetX, 33 - offsetY);
    CGPathAddLineToPoint(path, NULL, 13 - offsetX, 29 - offsetY);
    CGPathAddLineToPoint(path, NULL, 15 - offsetX, 24 - offsetY);
    CGPathAddLineToPoint(path, NULL, 21 - offsetX, 20 - offsetY);
    CGPathAddLineToPoint(path, NULL, 138 - offsetX, 14 - offsetY);
    CGPathAddLineToPoint(path, NULL, 152 - offsetX, 37 - offsetY);
    CGPathAddLineToPoint(path, NULL, 152 - offsetX, 46 - offsetY);
    CGPathAddLineToPoint(path, NULL, 148 - offsetX, 54 - offsetY);
    CGPathAddLineToPoint(path, NULL, 144 - offsetX, 58 - offsetY);
    
    CGPathCloseSubpath(path);
    
    flipperRight.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    
    [flipperRight setupPhysicsBody];
    return flipperRight;
}

- (void)setupPhysicsBody
{
//    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    
    self.physicsBody.categoryBitMask = CollisionCategoryFlipper;
    self.physicsBody.collisionBitMask = CollisionCategoryBall;
    self.physicsBody.contactTestBitMask = CollisionCategoryBall;
    self.physicsBody.dynamic = NO;
    self.physicsBody.restitution = 0.5; //bounce
    
}

//- (void)performTapLeft
//{
//    [self runAction:self.tapActionLeft];
//}
//
//- (void)performTapRight
//{
//    [self runAction:self.tapActionRight];
//}
//
//-(SKAction *)tapActionLeft
//{
//    if (_tapActionLeft != nil)
//    {
//        return _tapActionLeft;
//    }
//
//    NSArray *textures = @[[SKTexture textureWithImageNamed:@"Flipper_Left_Rotate20"],
//                          [SKTexture textureWithImageNamed:@"Flipper_Left"]];
//    
//    _tapActionLeft = [SKAction animateWithTextures:textures timePerFrame:0.25];
//    
//    return _tapActionLeft;
//}
//
//-(SKAction *)tapActionRight
//{
//    if (_tapActionRight != nil)
//    {
//        return _tapActionRight;
//    }
//    
//    NSArray *textures = @[[SKTexture textureWithImageNamed:@"Flipper_Right_Rotate20"],
//                          [SKTexture textureWithImageNamed:@"Flipper_Right"]];
//    
//    _tapActionRight = [SKAction animateWithTextures:textures timePerFrame:0.25];
//    
//    return _tapActionRight;
//}

@end
