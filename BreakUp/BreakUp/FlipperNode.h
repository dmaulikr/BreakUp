//
//  FlipperNode.h
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FlipperNode : SKSpriteNode

+ (instancetype)leftFlipperAtPosition:(CGPoint)position;
+ (instancetype)rightFlipperAtPosition:(CGPoint)position;


@end
