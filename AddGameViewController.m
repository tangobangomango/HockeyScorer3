//
//  AddGameViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/2/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "AddGameViewController.h"
#import "Game.h"

@interface AddGameViewController ()

@end

@implementation AddGameViewController

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
        self.title = @"Edit Game";
        self.opponentField.text = self.gameToEdit.opponent;
        self.doneBarButton.enabled = YES;//enable done button since data already exists
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Put selection into opponent name row
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.opponentField becomeFirstResponder];
}


// Disable opponent name row highlighting
- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - button actions

- (IBAction) cancel
{
    //Use delegate to execute cancel
    //method here is a delegate method listed above and defined in the HSVC
    [self.delegate addGameViewControllerDidCancel:self];
}

-(IBAction) done
{
    //Use delegate to capture entered data and pass to HSVC
    //methods here are delegate methods listed above and defined in the HSVC
    
    //see if the data was empty when view loaded
    if (self.gameToEdit == nil) {
    
        Game *game = [[Game alloc] init];
        game.opponent = self.opponentField.text;
        //game.dateOfGame = self.
    
        [self.delegate addGameViewController:self didFinishAddingGame:game];
        
    } else {
        self.gameToEdit.opponent = self.opponentField.text;//updates data model; will update display in delaegate method
        
        [self.delegate addGameViewController: self didFinishEditingGame:self.gameToEdit];
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
