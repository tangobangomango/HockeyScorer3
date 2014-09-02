//
//  HockeyScorerViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/1/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "HockeyScorerViewController.h"
#import "Game.h"

@interface HockeyScorerViewController ()



@end

@implementation HockeyScorerViewController

{
    NSMutableArray *_games;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _games = [[NSMutableArray alloc] initWithCapacity:50];
    
    Game *game;
    
    game = [[Game alloc] init];
    game.opponent = @"Mission";
    game.dateOfGame = [self convertToDate:@"2014-10-10" withFormat:@"yyyy-MM-dd"];
    [_games addObject: game];
    
    game = [[Game alloc] init];
    game.opponent = @"TI";
    game.dateOfGame = [self convertToDate:@"2014-10-20" withFormat:@"yyyy-MM-dd"];
    [_games addObject: game];

    
    game = [[Game alloc] init];
    game.opponent = @"Little Caesars";
    game.dateOfGame = [self convertToDate:@"2014-10-23" withFormat:@"yyyy-MM-dd"];
    [_games addObject: game];
    
    game = [[Game alloc] init];
    game.opponent = @"Compuware";
    game.dateOfGame = [self convertToDate:@"2014-11-10" withFormat:@"yyyy-MM-dd"];
    [_games addObject: game];
    
    game = [[Game alloc] init];
    game.opponent = @"Boston Jr Eagles";
    game.dateOfGame = [self convertToDate:@"2014-12-06" withFormat:@"yyyy-MM-dd"];
    [_games addObject: game];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_games count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a table cell to use
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameSummary"];
    
    //load game variable from games array
    Game *game = _games[indexPath.row];
    
    [self configureDataForCell:cell withGame:game];//put data into correct labels in the cell
    
    
    return cell;
}

- (void) configureDataForCell: (UITableViewCell *) cell withGame: (Game *) game
{
    // Identify proper labels within the cell to be filled with data
    UILabel *opponent = (UILabel *) [cell viewWithTag:990];
    UILabel *date = (UILabel *) [cell viewWithTag:980];
    
    //Put text/data in the labels
    opponent.text = game.opponent;
    date.text = [self convertDateOf:game.dateOfGame toFormat:@"MMM d, YYYY"];
}

#pragma mark - date conversion methods

-(NSString *) convertDateFormatOf: (NSString *) inputDateString from: (NSString *) inputFormat to: (NSString *) outputFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: inputFormat];
    NSDate *inputDate = [dateFormatter dateFromString:inputDateString];
    [dateFormatter setDateFormat:outputFormat];
    NSString *outputDate = [dateFormatter stringFromDate:inputDate];
    
    return outputDate;
}

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



// This implements swipe to delete
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //First delete record from games array
    [_games removeObjectAtIndex:indexPath.row];
    
    //Next delete row from the screen
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

#pragma mark - delegate methods for AddGameVC

- (void) addGameViewControllerDidCancel:(AddGameViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) addGameViewController:(AddGameViewController *)controller didFinishAddingGame:(Game *)game
{
    NSInteger newRowIndex = [_games count]; //get location to add new record (game)
    
    [_games addObject: game]; //add to data model
    
    //add to screen
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) addGameViewController:(AddGameViewController *)controller didFinishEditingGame:(Game *)game
{
    //edit already made in data model in AGVC
    //need to update display
    
    NSInteger index = [_games indexOfObject: game];//locate the item being editied in the games array
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];//get the right cell
    
    [self configureDataForCell:cell withGame:game];//puts the game data into the labels in the cell
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //check for proper seque
    if ([segue.identifier isEqualToString:@"AddGame"]) {
        
        //identify the top level view controller holding the AddGameVC (see storyboard)
        UINavigationController *navigationController = segue.destinationViewController;
        
        //go down one level to get the AGVC
        AddGameViewController *controller = (AddGameViewController *) navigationController.topViewController;
        
        //set the current controller (the HSVC) as the delegate for the AGVC
        controller.delegate = self;
        
    } else if ([segue.identifier isEqualToString:@"EditGame"]) {
        
        //as above to get to the right place
        UINavigationController *navigationController = segue.destinationViewController;
        AddGameViewController *controller = (AddGameViewController *) navigationController.topViewController;
        controller.delegate = self;
        
        //"sender" here is what was clicked, the detail disclosure icon
        //this identifies what game data to load to edit
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.gameToEdit = _games[indexPath.row];
    }
}


 
@end
