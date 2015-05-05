//
//  HUDNode.m
//  BreakUp
//
//  Created by Apple on 5/2/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "HUDNode.h"
#import "Utilites.h"

@implementation HUDNode

// Considering not having a HUD and just display score at the end

+ (instancetype)hudAtPosition:(CGPoint)position inFrame:(CGRect)frame
{
    HUDNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 999;
    hud.name = @"HUD";
    hud.lives = MaxLives;
    
    SKSpriteNode *lastLifeBar;
    
    // Add pinball life icon
    SKSpriteNode *pinballLife = [SKSpriteNode spriteNodeWithImageNamed:@"Ball"];
    pinballLife.position = CGPointMake(position.x+20, -10);
    
    
    // Add initial lives
    for (int i = 0; i < hud.lives; i++)
    {
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"Ball"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d", i+1];
//        lifeBar.position = CGPointMake(pinballLife.position.x + pinballLife.size.width + (10 * i), pinballLife.position.y);
        
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil)
        {
            lifeBar.position = CGPointMake(pinballLife.position.x, pinballLife.position.y);
        }
        else
        {
            lifeBar.position = CGPointMake(lastLifeBar.position.x+10, pinballLife.position.y);
        }
        
        lastLifeBar = lifeBar;
    }
    
    // Add score
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 30;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    scoreLabel.position = CGPointMake(frame.size.width-70, pinballLife.position.y-20);
    [hud addChild:scoreLabel];
    
    return hud;
}

- (void)addPoints:(NSInteger)points
{
    self.score += points;
    
    SKLabelNode *scoreLabel = (SKLabelNode *)[self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.score]; //setting to point
}

- (BOOL)loseLife
{
    if (self.lives > 0)
    {
        NSString *lifeNodeName = [NSString stringWithFormat:@"Life%ld", (long)self.lives];
        SKNode *lifeToRemove = [self childNodeWithName:lifeNodeName];
        [lifeToRemove removeFromParent];
        self.lives--; // decrement lives
    }
    
    return self.lives == 0;
}

@end
