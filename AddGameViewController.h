//
//  AddGameViewController.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/2/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <UIKit/UIKit.h>

//Define the delegate protocol to let this controller send data to the HockeyScorerViewContoler (the game list)
@class AddGameViewController;
@class Game;

@protocol AddGameViewControllerDelegate <NSObject>

- (void) addGameViewControllerDidCancel: (AddGameViewController *) controller;
- (void) addGameViewController: (AddGameViewController *) controller didFinishAddingGame: (Game *) game;
- (void) addGameViewController: (AddGameViewController *) controller didFinishEditingGame: (Game *) game;

@end

@interface AddGameViewController : UITableViewController <UITextFieldDelegate> //so controller can listen for changes to text field

- (IBAction) cancel;
- (IBAction) done;

@property (weak, nonatomic) IBOutlet UITextField *opponentField;//linked to text field
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;//so view controller can tell button to be disabled/enabled

@property (nonatomic, strong) Game *gameToEdit;//will be nil for a new game; will hold game data if game already exists. Will be used in viewDidLoad of the AGVC and loaded in the delegate methods in HSVC

@property (nonatomic, weak) id <AddGameViewControllerDelegate> delegate;//this lets this view controller refer to the delegate to be able to pass data

@end
