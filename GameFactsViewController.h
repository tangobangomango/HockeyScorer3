//
//  GameFactsViewController.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/2/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import <UIKit/UIKit.h>

//Define the delegate protocol to let this controller send data to the GameListViewController (the game list)
@class GameFactsViewController;
@class Game;

@protocol GameFactsViewControllerDelegate <NSObject>

- (void) gameFactsViewControllerDidCancel: (GameFactsViewController *) controller;
- (void) gameFactsViewController: (GameFactsViewController *) controller didFinishAddingGame: (Game *) game;
- (void) gameFactsViewController: (GameFactsViewController *) controller didFinishEditingGame: (Game *) game;

@end

@interface GameFactsViewController : UITableViewController <UITextFieldDelegate> //so controller can listen for changes to text field

- (IBAction) cancel;
- (IBAction) done;

@property (weak, nonatomic) IBOutlet UITextField *opponentField;//linked to text field
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;//so view controller can tell button to be disabled/enabled

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)datePickerChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITableViewCell *datePickerCell;
@property (nonatomic, assign) BOOL datePickerIsShowing;
@property (nonatomic, strong) UITextField *activeTextField;

@property (nonatomic, strong) Game *gameToEdit;//will be nil for a new game; will hold game data if game already exists. Will be used in viewDidLoad of the GFVC and loaded in the delegate methods in GLVC

@property (nonatomic, weak) id <GameFactsViewControllerDelegate> delegate;//this lets this view controller refer to the delegate to be able to pass data

@end
