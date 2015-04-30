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
    
    [flipperLeft setupPhysicsBodyLeft];
    return flipperLeft;
}

+ (instancetype)rightFlipperAtPosition:(CGPoint)position
{
    FlipperNode *flipperRight = [self spriteNodeWithImageNamed:@"Flipper_Right"];
    
    flipperRight.position = position;
    flipperRight.anchorPoint = CGPointMake(0.8, 0.5);
    flipperRight.name = @"RightFlipper";
    flipperRight.zPosition = 7;
    
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
    
    [flipperRight setupPhysicsBodyRight];
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
