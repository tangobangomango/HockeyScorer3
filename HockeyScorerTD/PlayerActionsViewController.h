//
//  PlayerActionsViewController.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/8/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//Define the delegate protocol to let this controller send data to the GameListViewController (the game list)
@class PlayerActionsViewController;
@class Game;

@protocol PlayerActionsViewControllerDelegate <NSObject>

//- (void) playerActionsViewControllerDidCancel: (PlayerActionsViewController *) controller;
- (void) playerActionsViewController: (PlayerActionsViewController *) controller didEditGameData: (Game *) game;

@end

@interface PlayerActionsViewController : UIViewController
{
    AVAudioPlayer *buttonBeep;
}

@property (nonatomic, strong) Game *gameToEditPerformance;// Will be used in viewDidLoad of the PAVC and loaded in the delegate methods in GLVC

@property (nonatomic, weak) id <PlayerActionsViewControllerDelegate> delegate;//this lets this view controller refer to the delegate to be able to pass data

@end
