//
//  HUDNode.h
//  BreakUp
//
//  Created by Apple on 5/2/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HUDNode : SKNode

@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger lives;

+ (instancetype)hudAtPosition:(CGPoint)position inFrame:(CGRect)frame;

- (void)addPoints:(NSInteger)points;
- (BOOL)loseLife;

@end
