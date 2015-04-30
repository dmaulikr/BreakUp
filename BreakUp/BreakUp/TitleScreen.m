//
//  TitleScreen.m
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "TitleScreen.h"
#import "GameScene.h"


@implementation TitleScreen

-(void)didMoveToView:(SKView *)view
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    GameScene *gameScene = [GameScene sceneWithSize:self.view.bounds.size];
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
    
    [self.view presentScene:gameScene transition:transition];
}

@end
