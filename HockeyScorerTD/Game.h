//
//  Game.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/2/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject <NSCoding>//conforms to this protocol so data can be prepared for read/write to file

//used primarily in GameFactsViewController
@property (nonatomic, strong) NSString *opponent;
@property (nonatomic, strong) NSDate *dateOfGame;

//used primarily in PlayerActionsViewController
@property (nonatomic) NSInteger shotsOnGoal;
@property (nonatomic) NSInteger shotsNotOnGoal;
@property (nonatomic) NSInteger passesCompleted;
@property (nonatomic) NSInteger passesNotCompleted;
@property (nonatomic) NSInteger takeaways;
@property (nonatomic) NSInteger giveaways;
@property (nonatomic) NSInteger faceoffsWon;
@property (nonatomic) NSInteger faceoffsLost;
@property (nonatomic) NSInteger shifts;
@property (nonatomic) NSInteger blockedShots;

//used primarily in PlayerResultsViewController
@property (nonatomic) NSInteger goals;
@property (nonatomic) NSInteger assists;
@property (nonatomic) NSInteger plus;
@property (nonatomic) NSInteger minus;
@property (nonatomic) NSInteger penaltyMinutes;
@property (nonatomic) NSInteger penaltiesDrawn;
@property (nonatomic) NSInteger shiftsPP;
@property (nonatomic) NSInteger shiftsPK;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *notes;

//used primarily in TeamResultsViewController
@property (nonatomic) NSInteger teamGoals;
@property (nonatomic) NSInteger opponentGoals;
@property (nonatomic, strong) NSString *teamNotes;

@end
