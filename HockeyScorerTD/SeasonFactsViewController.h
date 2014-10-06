//
//  SeasonFactsViewController.h
//  HockeyScorerTD
//
//  Created by Anne West on 9/13/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

//Modeled on GameFactsViewController

#import <UIKit/UIKit.h>

@class SeasonFactsViewController;
@class Season;

@protocol SeasonFactsViewControllerDelegate <NSObject>

//takes just one argument since all needed to know is that the controller cancelled
- (void) seasonFactsViewControllerDidCancel: (SeasonFactsViewController *) controller;

//takes two arguments becuase here also needs to pass back the season that was added/edited
- (void) seasonFactsViewController: (SeasonFactsViewController *) controller didFinishAddingSeason: (Season *) season;
- (void) seasonFactsViewController: (SeasonFactsViewController *) controller didFinishEditingSeason: (Season *) season;

@end

//needs to be text field delegate so we can 'deal with" text field value
@interface SeasonFactsViewController : UITableViewController <UITextFieldDelegate>

//properties to hold season facts
@property (weak, nonatomic) IBOutlet UITextField *textField;
//@property (nonatomic, weak) UITextField *textField;
//@property (nonatomic, weak) UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

//outlet for the done bar button. (cancel button handled by Nav controller, I think.)
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneBarButton;

//property to pass season for editing
@property (nonatomic, strong) Season *seasonToEdit;

//delegate property so can assign where to go back to
@property (nonatomic, weak) id <SeasonFactsViewControllerDelegate> delegate;

- (IBAction) done;
- (IBAction) cancel;



@end
