//
//  SeasonFactsViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/13/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "SeasonFactsViewController.h"
#import "Season.h"

@interface SeasonFactsViewController ()

@end

@implementation SeasonFactsViewController

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
    // get existing season data if it is there and set proper page title
    if (self.seasonToEdit != nil) {
        //Make changes to display to reflect data existing
        self.title = @"Edit Season";
        self.doneBarButton.enabled = YES;
        
        //Populate display with existing data
        self.textField.text = self.seasonToEdit.seasonName;
        //self.descriptionTextView.text = self.seasonToEdit.seasonDescription;
        
    }
    
    /*else {
        //page title of Add and disabled Done button set as defaults
        //Create initial data and display
        self.textField.text = nil;
        //self.descriptionTextView = nil;
        
    }*/
}

//Put focus in season name textfield
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button actions

- (IBAction) cancel
{
    //Use delegate to execute cancel
    //method here is a delegate method listed above and defined in the GLVC
    [self.delegate seasonFactsViewControllerDidCancel:self];
}

-(IBAction) done
{
    //Use delegate to capture entered data and pass to GLVC
    //methods here are delegate methods listed above and defined in the GLVC
    
    //see if the data was empty when view loaded
    if (self.seasonToEdit == nil) {
        
        Season *season = [[Season alloc] init];
        season.seasonName = self.textField.text;
        NSLog(@"Season %@", season.seasonName);
        //season.seasonDescription = self.descriptionTextView.text;
        
        
        [self.delegate seasonFactsViewController:self didFinishAddingSeason:season];
        
    } else {
        self.seasonToEdit.seasonName = self.textField.text;//updates data model; will update display in delegate method
        //self.seasonToEdit.seasonDescription = self.descriptionTextView.text;
        
        [self.delegate seasonFactsViewController: self didFinishEditingSeason:self.seasonToEdit];
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



@end
