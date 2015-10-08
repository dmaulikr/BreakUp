# BreakUp
##### TechStack: Objective-C, SpriteKit, and Sketch for in-game assets.

iOS game which is a mash-up of Pinball and Breakout with the objective of surviving as long as possible and obtaining a highscore. 

### GameScene

 Logic for the flipper to rotate. You can also see detection for the user's touch location--in this example being the right side.
 ```
    if (touchLocation.x > 188 && touchLocation.y < 500)
    {
        NSArray *sequence = @[[SKAction runBlock:^{self.rightFlipperActive = YES;}],
                              [SKAction rotateToAngle:-45 * M_PI / 180 duration:0.1],
                              [SKAction runBlock:^{self.rightFlipperActive = NO;}]];
        
        [self.rightFlipper runAction:[SKAction sequence:sequence]];
    }
```
 When the flipper is touched it will run an action which briefly allows it to apply velocity to the ball on contact.
```
        if (self.rightFlipperActive)
        {
            [self.ball.physicsBody applyImpulse:CGVectorMake(-5.0, ApplyFlipperVelocity)];
            [self runAction:self.flipperSFX];
        }
```
