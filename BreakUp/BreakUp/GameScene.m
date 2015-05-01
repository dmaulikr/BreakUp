//
//  GameScene.m
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "GameScene.h"
#import "BallNode.h"
#import "FlipperNode.h"
#import "DrainNode.h"
#import "BrickNode.h"
#import "TapToStartNode.h"
#import "WallNode.h"
#import "Utilites.h"

@interface GameScene ()

@property (nonatomic)TapToStartNode *tapToStart;
@property (nonatomic)BallNode *ball;
@property (nonatomic)FlipperNode *rightFlipper;
@property (nonatomic)FlipperNode *leftFlipper;

@end

BOOL leftFlipperActive;
BOOL rightFlipperActive;

@implementation GameScene
{
    SKNode *world;
}

-(void)didMoveToView:(SKView *)view
{
    leftFlipperActive = NO;
    rightFlipperActive = NO;
    
    /* Setup your scene here */
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_test"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    world = [SKNode node];
    [self addChild:world];
    
    self.ball = [BallNode ballAtPosition:CGPointMake(200, 100)];
    self.leftFlipper = [FlipperNode leftFlipperAtPosition:CGPointMake(CGRectGetMidX(self.frame)-168, 80)];
    self.rightFlipper = [FlipperNode rightFlipperAtPosition:CGPointMake(self.leftFlipper.position.x+330, self.leftFlipper.position.y)];
    DrainNode *drain = [DrainNode drainWithSize:CGSizeMake(self.frame.size.width, 5)];
    WallNode *wallLeft = [WallNode wallAtPosition:CGPointMake(CGRectGetMinX(self.frame), 300)];
    WallNode *wallRight = [WallNode wallAtPosition:CGPointMake(CGRectGetMaxX(self.frame), 300)];
//    BrickNode *brick = [BrickNode brickAtPosition:CGPointMake(100, 500)];
    self.tapToStart = [TapToStartNode tapToStartAtPosition:CGPointMake(self.size.width / 2, 280)];
    
    self.physicsWorld.gravity = CGVectorMake(0, -9.8);
    self.physicsWorld.contactDelegate = self;
    
    [world addChild:self.ball];
    [world addChild:self.tapToStart];
    [world addChild:background];
    [world addChild:wallLeft];
    [world addChild:wallRight];
    [world addChild:self.leftFlipper];
    [world addChild:self.rightFlipper];
    [world addChild:drain];
//    [world addChild:brick];
    
    [self addBrickRow];
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"Contact!");
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    //Velocity from flipper flip
    if (firstBody.categoryBitMask == CollisionCategoryBall && secondBody.categoryBitMask == CollisionCategoryFlipperLeft)
    {
        if (leftFlipperActive)
        {
            NSLog(@"Left Flip<");
            [self.ball.physicsBody applyImpulse:CGVectorMake(5.0, 50.0)];
        }
    }
    if (firstBody.categoryBitMask == CollisionCategoryBall && secondBody.categoryBitMask == CollisionCategoryFlipperRight)
    {
        if (rightFlipperActive)
        {
            NSLog(@"Right Flip>");
            [self.ball.physicsBody applyImpulse:CGVectorMake(-5.0, 50.0)];
        }
    }
    //Game restart on Drain Contact
    if (firstBody.categoryBitMask == CollisionCategoryBall && secondBody.categoryBitMask == CollisionCategoryDrain)
    {
        for (SKNode *node in [self children])
        {
            [node removeFromParent];
        }
        NSLog(@"Drain and Ball");
        GameScene *scene = [GameScene sceneWithSize:self.view.bounds.size];
        [self.view presentScene:scene];
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
//    NSLog(@"Touch Loc %f", touchLocation.x);
    
    
    // TAP TO START - Logic and Removal
    if (!self.ball.physicsBody.dynamic)
    {
        [self.tapToStart removeFromParent];
        self.ball.physicsBody.dynamic = YES;
        [self.ball.physicsBody applyImpulse:CGVectorMake([Utilites randomWithMin:1.0 max:20.0], [Utilites randomWithMin:50.0 max:100.0])];
    }
    

    // Touch on Flippers logic
    if (touchLocation.x > 188)
    {
        NSLog(@"Right Flipper Tapped");
        NSArray *sequence = @[[SKAction runBlock:^{rightFlipperActive = YES;}],
                              [SKAction rotateToAngle:-45 * M_PI / 180 duration:0.1],
                              [SKAction runBlock:^{rightFlipperActive = NO;}]];
        
        [self.rightFlipper runAction:[SKAction sequence:sequence]];
    }
    if (touchLocation.x < 188)
    {
        NSLog(@"Left Flipper Tapped");
        NSArray *sequence = @[[SKAction runBlock:^{leftFlipperActive = YES;}],
                              [SKAction rotateToAngle:+45 * M_PI / 180 duration:0.1],
                              [SKAction runBlock:^{leftFlipperActive = NO;}]];
        
        [self.leftFlipper runAction:[SKAction sequence:sequence]];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    if (touchLocation.x > 188)
    {
        NSLog(@"Right Flipper Tapped");
        NSArray *sequence = @[[SKAction rotateToAngle:0 * M_PI / 180 duration:0.1]];
        
        [self.rightFlipper runAction:[SKAction sequence:sequence]];
    }
    if (touchLocation.x < 188)
    {
        NSLog(@"Left Flipper Tapped");
        NSArray *sequence = @[[SKAction rotateToAngle:0 * M_PI / 180 duration:0.1]];
        
        [self.leftFlipper runAction:[SKAction sequence:sequence]];
    }
    
}


-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}

- (void)addBrickRow
{
    BrickNode *brickA = [BrickNode brickRowOfType:BrickTypeA];
    
    float y = self.frame.size.height-100 - brickA.size.height;
    float x = [Utilites randomWithMin:10+brickA.size.width max:self.frame.size.width-brickA.size.width-10];
    
    brickA.position = CGPointMake(x, y);
    [world addChild:brickA];
}

@end
























