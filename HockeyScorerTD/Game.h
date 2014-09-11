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

@end
