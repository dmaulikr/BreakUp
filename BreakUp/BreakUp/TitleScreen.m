//
//  TitleScreen.m
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "TitleScreen.h"
#import "GameScene.h"
#import <AVFoundation/AVFoundation.h>


@interface TitleScreen ()

@property (nonatomic) AVAudioPlayer *backgroundMusic;

@end

@implementation TitleScreen

-(void)didMoveToView:(SKView *)view
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"DST-GlassView" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic prepareToPlay];
    [self.backgroundMusic play];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    GameScene *gameScene = [GameScene sceneWithSize:self.view.bounds.size];
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.8];
    
    [self.view presentScene:gameScene transition:transition];
    
    [self.backgroundMusic stop];
}

@end
