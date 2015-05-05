//
//  GameScene.m
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "GameScene.h"
#import "Utilites.h"

#import "BallNode.h"
#import "FlipperNode.h"
#import "BrickNode.h"

#import "DrainNode.h"
#import "WallNode.h"
#import "HUDNode.h"

#import "TapToStartNode.h"
#import "GameOverNode.h"

#import <AVFoundation/AVFoundation.h>

@interface GameScene ()

@property (nonatomic)TapToStartNode *tapToStart;
@property (nonatomic)BallNode *ball;
@property (nonatomic)FlipperNode *rightFlipper;
@property (nonatomic)FlipperNode *leftFlipper;

// Time
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceBrickAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSTimeInterval addBrickTimeInterval;

// Sounds
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@property (nonatomic) AVAudioPlayer *gameOverMusic;

@property (nonatomic) BOOL gameOver;
@property (nonatomic) BOOL gameOverDisplayed;
@property (nonatomic) BOOL leftFlipperActive;
@property (nonatomic) BOOL rightFlipperActive;

@end

@implementation GameScene
{
    SKNode *world;
}

- (void)didMoveToView:(SKView *)view
{
    // Game mechanics setup
    self.lastUpdateTimeInterval = 0;
    self.timeSinceBrickAdded = 0;
    self.totalGameTime = 0;
    self.addBrickTimeInterval = 40.0;
    self.leftFlipperActive = NO;
    self.rightFlipperActive = NO;
    self.gameOver = NO;
    
    /* Setup your scene here */
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_test"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    // Some sort of scene...
    world = [SKNode node];
    [self addChild:world];
    
    // Setup physics
    self.physicsWorld.gravity = CGVectorMake(0, -9.8);
    self.physicsWorld.contactDelegate = self;
    
    // Add ball
    self.ball = [BallNode ballAtPosition:CGPointMake(CGRectGetMidX(self.frame), 100)];
    
    // Add flippers
    self.leftFlipper = [FlipperNode leftFlipperAtPosition:CGPointMake(CGRectGetMidX(self.frame)-167, 80)];
    self.rightFlipper = [FlipperNode rightFlipperAtPosition:CGPointMake(self.leftFlipper.position.x+330, self.leftFlipper.position.y)];
    
    // Add Drain/Ground
    DrainNode *drain = [DrainNode drainWithSize:CGSizeMake(self.frame.size.width, 5)];
    
    // Add Walls
    WallNode *wallLeft = [WallNode wallAtPosition:CGPointMake(CGRectGetMinX(self.frame)-10, 300)];
    WallNode *wallRight = [WallNode wallAtPosition:CGPointMake(CGRectGetMaxX(self.frame)+10, 300)];
    
    // Add taptostart label
    self.tapToStart = [TapToStartNode tapToStartAtPosition:CGPointMake(self.size.width / 2, 280)];
    
    // Add score HUD
    HUDNode *hud = [HUDNode hudAtPosition:CGPointMake(0, self.frame.size.height-40) inFrame:self.frame];
    
    [world addChild:self.ball];
    [world addChild:self.tapToStart];
    [world addChild:background];
    [world addChild:wallLeft];
    [world addChild:wallRight];
    [world addChild:self.leftFlipper];
    [world addChild:self.rightFlipper];
    [world addChild:drain];
    [world addChild:hud];
    
    [self setupSounds];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
//    NSLog(@"Contact!");
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
    // Velocity from flipper flip
    if (firstBody.categoryBitMask == CollisionCategoryBall &&
        secondBody.categoryBitMask == CollisionCategoryFlipperLeft)
    {
        if (self.leftFlipperActive)
        {
            NSLog(@"Left Flip<");
            [self.ball.physicsBody applyImpulse:CGVectorMake(5.0, ApplyFlipperVelocity)];
        }
    }
    if (firstBody.categoryBitMask == CollisionCategoryBall &&
        secondBody.categoryBitMask == CollisionCategoryFlipperRight)
    {
        if (self.rightFlipperActive)
        {
            NSLog(@"Right Flip>");
            [self.ball.physicsBody applyImpulse:CGVectorMake(-5.0, ApplyFlipperVelocity)];
        }
    }
    // Game restart on Ball/Drain Contact
    if (firstBody.categoryBitMask == CollisionCategoryBall &&
        secondBody.categoryBitMask == CollisionCategoryDrain)
    {
        NSLog(@"BALL/DRAIN contact");
//        self.gameOver = YES;
        [self loseLife];
        
        // Moves the ball after a *life is lost
        if (!self.gameOver)
        {
//            self.ball.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+100);
            SKAction *moveBall = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame)+[Utilites randomWithMin:-50.0 max:50.0], CGRectGetMidY(self.frame)) duration:0.1];

            [self.ball runAction:moveBall];
        }
    }
    // Game restart on Brick/Drain Contact
    if (firstBody.categoryBitMask == CollisionCategoryDrain &&
        secondBody.categoryBitMask == CollisionCategoryBrick)
    {
        NSLog(@"Bricks have drained");
//        self.gameOver = YES;
        if (!self.gameOver)
        {
            [self addPoints:-100];
        }
        
        
    }
    // Brick Contact Logic and Brick scoring
    if (firstBody.categoryBitMask == CollisionCategoryBall &&
        secondBody.categoryBitMask == CollisionCategoryBrick)
    {
        NSLog(@"POW!");
        BrickNode *brick = (BrickNode *)secondBody.node;
//        BallNode *ball = (BallNode *)secondBody.node;
        [self addPoints:25];
        
        // blue double hit brick
        if ([brick isDamaged] &&
            brick.type == BrickTypeA)
        {
            [brick removeFromParent];
            [self addPoints:250];
        }
        // red single hit brick
        if (brick.type == BrickTypeB)
        {
            [brick removeFromParent];
            [self addPoints:100];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (self.gameOver)
    {
        for (SKNode *node in [self children])
        {
            [node removeFromParent];
        }
        GameScene *scene = [GameScene sceneWithSize:self.view.bounds.size];
        [self.view presentScene:scene];
        [self.gameOverMusic stop];
        [self.backgroundMusic stop];
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    // TAP TO START - Logic and Removal
    if (!self.ball.physicsBody.dynamic)
    {
        [self.tapToStart removeFromParent];
        self.ball.physicsBody.dynamic = YES;
        [self.ball.physicsBody applyImpulse:CGVectorMake([Utilites randomWithMin:1.0 max:20.0], [Utilites randomWithMin:50.0 max:80.0])];
        
        [self spawnBrickRows];
    }
    
    // Touch on Flippers logic
    if (touchLocation.x > 188)
    {
        NSLog(@"Right Flipper Tapped");
        NSArray *sequence = @[[SKAction runBlock:^{self.rightFlipperActive = YES;}],
                              [SKAction rotateToAngle:-45 * M_PI / 180 duration:0.1],
                              [SKAction runBlock:^{self.rightFlipperActive = NO;}]];
        
        [self.rightFlipper runAction:[SKAction sequence:sequence]];
    }
    if (touchLocation.x < 188)
    {
        NSLog(@"Left Flipper Tapped");
        NSArray *sequence = @[[SKAction runBlock:^{self.leftFlipperActive = YES;}],
                              [SKAction rotateToAngle:+45 * M_PI / 180 duration:0.1],
                              [SKAction runBlock:^{self.leftFlipperActive = NO;}]];
        
        [self.leftFlipper runAction:[SKAction sequence:sequence]];
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
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

- (void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    if(self.gameOver)
    {
        [self performGameOver];
        return;
    }
    if (self.lastUpdateTimeInterval)
    {
        self.timeSinceBrickAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    if (self.timeSinceBrickAdded > self.addBrickTimeInterval && !self.gameOver)
    {
        [self spawnBrickRows];
        self.timeSinceBrickAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    // Difficulty increase by game time
    if (self.totalGameTime > 480)
    {
        self.addBrickTimeInterval = 6;
    }
    else if (self.totalGameTime > 240)
    {
        self.addBrickTimeInterval = 12;
    }
    else if (self.totalGameTime > 120)
    {
        self.addBrickTimeInterval = 18;
    }
    else if (self.totalGameTime > 50)
    {
        self.addBrickTimeInterval = 21;
    }
}

#pragma mark - Setup Methods

- (void)setupSounds
{
    // Background sound
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"DST-Blam" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic prepareToPlay];
    [self.backgroundMusic play];
    
    // Gameover sound
    NSURL *gameOverUrl = [[NSBundle mainBundle] URLForResource:@"DST-Drealing" withExtension:@"mp3"];
    self.gameOverMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:gameOverUrl error:nil];
    self.gameOverMusic.numberOfLoops = -1;
    [self.gameOverMusic prepareToPlay];
}

#pragma mark - Custom Methods

- (void)addBrickRow:(CGSize)size
{
    for (int i = 0; i < 6; i++)
    {
        BrickNode *brickA = [BrickNode brickRowOfType:BrickTypeA];
        
        int xPos = size.width/7.5 * (i+.5);
        // increment yPos by 20 for another row(size of brick)
        int yPos = 670;
//        brickA.position = CGPointMake(xPos+44, yPos+220);
        brickA.position = CGPointMake(xPos-10, yPos);
        
        [BrickNode moveBricks:brickA];
        [self addChild:brickA];
    }
    for (int i = 0; i < 8; i++)
    {
        BrickNode *brickA = [BrickNode brickRowOfType:BrickTypeA];
        
        int xPos = size.width/7.5 * (i+.5); // int xPos = size.width/7.5 * (i+.5); i+.5
        int yPos = 690;
        brickA.position = CGPointMake(xPos-10, yPos);
        
        [BrickNode moveBricks:brickA];
        [self addChild:brickA];
    }
    for (int i = 0; i < 8; i++)
    {
        BrickNode *brickB = [BrickNode brickRowOfType:BrickTypeB];
        
        int xPos = size.width/7.5 * (i+.5);
        int yPos = 650;
        brickB.position = CGPointMake(xPos-10, yPos);
        
        [BrickNode moveBricks:brickB];
        [self addChild:brickB];
    }
}

- (void)spawnBrickRows
{
    SKAction *spawn = [SKAction runBlock:^{
        // scene's size
        [self addBrickRow:self.size];
    }];
    [self runAction:spawn];
}

- (void)addPoints:(NSInteger)points
{
    HUDNode *hud = (HUDNode *)[world childNodeWithName:@"HUD"];
    [hud addPoints:points];
}

-(void)loseLife
{
    HUDNode *hud = (HUDNode *)[world childNodeWithName:@"HUD"];
    self.gameOver = [hud loseLife];
}

- (void)performGameOver
{
    if(!self.gameOverDisplayed)
    {
        GameOverNode *gameOver = [GameOverNode gameOverAtPosition:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidX(self.view.bounds))];
        [self addChild:gameOver];
        
        self.gameOverDisplayed = YES;
        
        [self.backgroundMusic stop];
        [self.gameOverMusic play];
    }
}

@end
























