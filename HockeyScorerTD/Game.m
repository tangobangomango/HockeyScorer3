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

//needed by GLVC to prepare data for loading in loadGames method
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
        
        self.goals = [aDecoder decodeIntegerForKey:@"Goals"];
        self.assists = [aDecoder decodeIntegerForKey:@"Assists"];
        self.plus = [aDecoder decodeIntegerForKey:@"Plus"];
        self.minus = [aDecoder decodeIntegerForKey:@"Minus"];
        self.penaltyMinutes = [aDecoder decodeIntegerForKey:@"PenaltyMinutes"];
        self.penaltiesDrawn = [aDecoder decodeIntegerForKey:@"PenaltiesDrawn"];
        self.shiftsPP = [aDecoder decodeIntegerForKey:@"PowerPlayShifts"];
        self.shiftsPK = [aDecoder decodeIntegerForKey:@"PenaltyKillShifts"];
        self.position =[aDecoder decodeObjectForKey:@"Position"];
        self.notes =[aDecoder decodeObjectForKey:@"Notes"];
        
        self.teamGoals = [aDecoder decodeIntegerForKey:@"TeamGoals"];
        self.opponentGoals = [aDecoder decodeIntegerForKey:@"OpponentGoals"];
        self.teamNotes =[aDecoder decodeObjectForKey:@"TeamNotes"];
        
        
    }
    return self;
}


//needed by GLVC to prepare data for saving in saveGames method
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
    
    [aCoder encodeInteger:self.goals forKey:@"Goals"];
    [aCoder encodeInteger:self.assists forKey:@"Assists"];
    [aCoder encodeInteger:self.plus forKey:@"Plus"];
    [aCoder encodeInteger:self.minus forKey:@"Minus"];
    [aCoder encodeInteger:self.penaltyMinutes forKey:@"PenaltyMinutes"];
    [aCoder encodeInteger:self.penaltiesDrawn forKey:@"PenaltiesDrawn"];
    [aCoder encodeInteger:self.shiftsPP forKey:@"PowerPlayShifts"];
    [aCoder encodeInteger:self.shiftsPK forKey:@"PenaltyKillShifts"];
    [aCoder encodeObject:self.position forKey:@"Position"];
    [aCoder encodeObject:self.notes forKey:@"Notes"];
    
    
    [aCoder encodeInteger:self.teamGoals forKey:@"TeamGoals"];
    [aCoder encodeInteger:self.opponentGoals forKey:@"OpponentGoals"];
    [aCoder encodeObject:self.teamNotes forKey:@"TeamNotes"];

    
}

//Game sorting in reverse date order

- (NSComparisonResult) compare: (Game *) otherGame
{
    return [otherGame.dateOfGame compare:self.dateOfGame ];
}


@end
