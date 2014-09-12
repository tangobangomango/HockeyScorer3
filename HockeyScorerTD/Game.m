//
//  Game.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/2/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "Game.h"

@implementation Game

#pragma mark - NSCoding protocol methods

//keys in these two methods must match

//needed by HSVC to prepare data for loading in loadGames method
//NSKeyedUnarchiver there defaults to this init method becuase of protocol
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.opponent = [aDecoder decodeObjectForKey:@"Opponent"];
        self.dateOfGame = [aDecoder decodeObjectForKey:@"DateOfGame"];
        self.shotsOnGoal = [aDecoder decodeIntegerForKey:@"ShotsOnGoal"];
        self.shotsNotOnGoal = [aDecoder decodeIntegerForKey:@"ShotsNotOnGoal"];
        self.passesCompleted = [aDecoder decodeIntegerForKey:@"PassesCompleted"];
        self.passesNotCompleted = [aDecoder decodeIntegerForKey:@"PassesNotCompleted"];
        self.takeaways = [aDecoder decodeIntegerForKey:@"Takeaways"];
        self.giveaways = [aDecoder decodeIntegerForKey:@"Giveaways"];
        self.faceoffsWon = [aDecoder decodeIntegerForKey:@"FaceoffsWon"];
        self.faceoffsLost = [aDecoder decodeIntegerForKey:@"FaceoffsLost"];
        self.shifts = [aDecoder decodeIntegerForKey:@"Shifts"];
        self.blockedShots = [aDecoder decodeIntegerForKey:@"BlockedShots"];
    }
    return self;
}


//needed by HSVC to prepare data for saving in saveGames method
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    //separate encoder for each property
    [aCoder encodeObject:self.opponent forKey:@"Opponent"];
    [aCoder encodeObject:self.dateOfGame forKey:@"DateOfGame"];
    [aCoder encodeInteger:self.shotsOnGoal forKey:@"ShotsOnGoal"];
    [aCoder encodeInteger:self.shotsNotOnGoal forKey:@"ShotsNotOnGoal"];
    [aCoder encodeInteger:self.passesCompleted forKey:@"PassesCompleted"];
    [aCoder encodeInteger:self.passesNotCompleted forKey:@"PassesNotCompleted"];
    [aCoder encodeInteger:self.takeaways forKey:@"Takeaways"];
    [aCoder encodeInteger:self.giveaways forKey:@"Giveaways"];
    [aCoder encodeInteger:self.faceoffsWon forKey:@"FaceoffsWon"];
    [aCoder encodeInteger:self.faceoffsLost forKey:@"FaceoffsLost"];
    [aCoder encodeInteger:self.shifts forKey:@"Shifts"];
    [aCoder encodeInteger:self.blockedShots forKey:@"BlockedShots"];
    
    
}

@end
