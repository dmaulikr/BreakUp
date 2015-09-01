//
//  GCUserAuthHelper.m
//  BreakUp
//
//  Created by Apple on 9/1/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

#import "GCUserAuthHelper.h"

@implementation GCUserAuthHelper

@synthesize gameCenterAvailable;

#pragma mark Initialization

static GCUserAuthHelper *sharedHelper = nil;
+ (GCUserAuthHelper *) sharedInstance
{
    if (!sharedHelper)
    {
        sharedHelper = [[GCUserAuthHelper alloc] init];
    }
    return sharedHelper;
}

- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (id)init {
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc =
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self
                   selector:@selector(authenticationChanged)
                       name:GKPlayerAuthenticationDidChangeNotificationName
                     object:nil];
        }
    }
    return self;
}

- (void)authenticationChanged {
    
    if ([GKLocalPlayer localPlayer].isAuthenticated &&
        !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated &&
               userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
    
}

#pragma mark User functions

- (void)authenticateLocalUser {
    
    if (!gameCenterAvailable) return;
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        [[GKLocalPlayer localPlayer]
         authenticateHandler];
    } else {
        NSLog(@"Already authenticated!");
    }
}

#pragma mark - leaderboard and achievements

+ (void) reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent
{
    GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier: identifier];
    if (achievement)
    {
        achievement.percentComplete = percent;
        achievement.showsCompletionBanner = YES;
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:identifier]) {
            //Tell analytics if you want to
        }
        
        NSArray *achievements = @[achievement];
        [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
            if (error != nil) {
                NSLog(@"Error in reporting achievements: %@", error);
            } else {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:identifier];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }];
    }
}

+ (void) reportScore: (Float64) score forIdentifier: (NSString*) identifier
{
    GKScore* highScore = [[GKScore alloc] initWithLeaderboardIdentifier:identifier];
    highScore.value = score;
    [GKScore reportScores:@[highScore] withCompletionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"Error in reporting scores: %@", error);
        }
    }];
}

@end
