//
//  GameFactsViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/2/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "GameFactsViewController.h"
#import "Game.h"

@interface GameFactsViewController ()



@end

@implementation GameFactsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // get existing game data if it is there and set proper page title
    if (self.gameToEdit != nil) {
        //Make changes to display to reflect data existing
        self.title = @"Edit Game";
        self.doneBarButton.enabled = YES;
        
        //Populate display with existing data
        self.opponentField.text = self.gameToEdit.opponent;
        self.datePicker.date = self.gameToEdit.dateOfGame;
        self.dateLabel.text = [self convertDateOf:self.gameToEdit.dateOfGame toFormat:@"MMM d, yyyy"];
        
    } else {
        //page title of Add and disabled Done button set as defaults
        //Create initial data and display
        self.opponentField.text = nil;
        NSDate *now = [NSDate date];
        self.datePicker.date = now;
        self.dateLabel.text = [self convertDateOf:now toFormat:@"MMM d, yyyy"];
        
    }
    
    //these lines not in tutorial for data picker but seem to be needed to have it hidden on view load
    self.datePicker.hidden = YES;
    self.datePickerIsShowing = NO;
    
    [self signUpForKeyboardNotifications]; //used to hide keyboard when date picker label cell chosen
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - row formatting manipulations

//Put selection/focus into opponent name row
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.opponentField becomeFirstResponder];//start with highlight in opponent name field
}
/*
// Disable opponent name row highlighting BUT with datepicker wouldnt allow selection of that row
- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
 */

#pragma mark - date picker activities

//manipulate the date picker
#define DATE_PICKER_SECTION_INDEX 1 //opponent name field is 0
#define DATE_PICKER_LABEL_INDEX 0 //label in first row
#define DATE_PICKER_ROW_INDEX 1 //date picker itself in second row
#define DATE_PICKER_ROW_HEIGHT 162.0f //height of date picket when visible


//set height of datpicker depending on whether active or not
// if visible also depends on datepicker = hidden
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = self.tableView.rowHeight;
    
    if (indexPath.section == DATE_PICKER_SECTION_INDEX && indexPath.row == DATE_PICKER_ROW_INDEX) {
        height = self.datePickerIsShowing ? DATE_PICKER_ROW_HEIGHT : 0.0f;

    }
    return height;
}

// if datepicker label cell selected, toggle visibility of datepicker itself
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == DATE_PICKER_SECTION_INDEX && indexPath.row == DATE_PICKER_LABEL_INDEX) {
        if (self.datePickerIsShowing) {
            [self hideDatePickerCell];
        } else {
            [self showDatePickerCell];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// shows datepicker with an animation
- (void) showDatePickerCell
{
    [self.activeTextField resignFirstResponder];//when datepicker cell to be shown, this serves to hide the keyboard
    
    self.datePickerIsShowing = YES;
    
    [self.tableView beginUpdates];//"everything gets updated and animates nicely"
    [self.tableView endUpdates];
    
    // unhide, then bring up alpha as an animation
    self.datePicker.hidden = NO;
    self.datePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.datePicker.alpha = 1.0f;
    }];
}

// reverse of above
- (void) hideDatePickerCell
{
    self.datePickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.datePicker.alpha = 0.0f;
    }
    completion:^(BOOL finished) {
        self.datePicker.hidden = YES;
    }];
}

//this was stubbed out by dragging with (id) vs (UIDatePicker *) and it didn't work
//had to change to specific type
- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    self.dateLabel.text = [self convertDateOf:sender.date toFormat:@"MMM d, yyyy"];
    //self.gameToEdit.dateOfGame = sender.date; //doing this here make test in add method below not work becuase game to edit not nil
}

// need to listen for when keyboard needed so can make visible
//called in viewDidLoad
- (void) signUpForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
}

//selector for signUpForKeyboardNotifcations
//hided the datepicker if a text field selected
- (void) keyboardWillShow
{
    if (self.datePickerIsShowing) {
        [self hideDatePickerCell];
    }
}

//tracks which text field has focus to know which field needs to resign first responder in showDatePickerCell
//not currently needed her since view only has one text field
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
}


#pragma mark - button actions

- (IBAction) cancel
{
    //Use delegate to execute cancel
    //method here is a delegate method listed above and defined in the GLVC
    [self.delegate gameFactsViewControllerDidCancel:self];
}

-(IBAction) done
{
    //Use delegate to capture entered data and pass to GLVC
    //methods here are delegate methods listed above and defined in the GLVC
    
    //see if the data was empty when view loaded
    if (self.gameToEdit == nil) {
    
        Game *game = [[Game alloc] init];
        game.opponent = self.opponentField.text;
        game.dateOfGame = [self convertToDate:self.dateLabel.text withFormat:@"MMM d, yyyy"];
        
    
        [self.delegate gameFactsViewController:self didFinishAddingGame:game];
        
    } else {
        self.gameToEdit.opponent = self.opponentField.text;//updates data model; will update display in delegate method
        self.gameToEdit.dateOfGame = [self convertToDate:self.dateLabel.text withFormat:@"MMM d, yyyy"];
        
        [self.delegate gameFactsViewController: self didFinishEditingGame:self.gameToEdit];
    }
        
    
}

//A UITextFieldDelegate method  Called when user changes text
//Controls enabling of Done button
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];//gets the updated text
    
    self.doneBarButton.enabled = ([newText length] >0);//enables Done button if text exists
    
    return YES;
}






#pragma mark - date conversion methods


- (NSString *) convertDateOf: (NSDate *) date toFormat: (NSString *) outputFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: outputFormat];
    
    return [dateFormatter stringFromDate: date];
}

- (NSDate *) convertToDate: (NSString *) dateString withFormat: (NSString *) formatString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatString];
    
    return [dateFormatter dateFromString:dateString];
}

@end
