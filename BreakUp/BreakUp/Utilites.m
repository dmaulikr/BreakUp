//
//  Utilites.m
//  BreakUp
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "Utilites.h"

@implementation Utilites

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max
{
    return arc4random()%(max - min) + min;
}

@end
