//
//  GameListViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/1/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "GameListViewController.h"
#import "Game.h"
//So we can get the title of the game list
#import "Season.h"

@interface GameListViewController ()



@end

@implementation GameListViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Puts name of season in the nav bar
    //season not alocated in this VC but is passed via segue
    //Will need to see if this is how it should be done in the PAVC to load the title
    self.title = self.season.seasonName;
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.season.games count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a table cell to use
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameSummary"];
    
    //load game variable from games array
    Game *game = self.season.games[indexPath.row];
    
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





#pragma mark - delegate methods for AddGameVC

- (void) gameFactsViewControllerDidCancel:(GameFactsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) gameFactsViewController:(GameFactsViewController *)controller didFinishAddingGame:(Game *)game
{
    //NSInteger newRowIndex = [self.season.games count]; //get location to add new record (game)
    
    [self.season.games addObject: game]; //add to data model
    
    //add to screen
    /*NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    */
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];//get the right cell
    //[self configureDataForCell:cell withGame:game];//puts the game data into the labels in the cell
    
    //[self saveGames];//write the current data to the file
    [self.season.games sortUsingSelector:@selector(compare:)];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) gameFactsViewController:(GameFactsViewController *)controller didFinishEditingGame:(Game *)game
{
    //edit already made in data model in GFVC
    //need to update display
    
    /*NSInteger index = [self.season.games indexOfObject: game];//locate the item being edited in the games array
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];//get the right cell
    
    [self configureDataForCell:cell withGame:game];//puts the game data into the labels in the cell
    */
    //[self saveGames];//write the current data to the file
    [self.season.games sortUsingSelector:@selector(compare:)];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// This implements swipe to delete
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //First delete record from games array
    [self.season.games removeObjectAtIndex:indexPath.row];
    
    //[self saveGames];//write the current data to the file
    
    //Next delete row from the screen
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

#pragma  mark - delegate methods for PlayersActionsVC

- (void) playerActionsViewController: (PlayerActionsViewController *) controller didEditGameData: (Game *) game
{
    NSLog(@"Paased back shots %ld", (long) game.shotsOnGoal);
    //[self saveGames];
    
    
}

#pragma mark - for segues to game add/edit navigation controller and performance tab contoller

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //check for proper seque
    if ([segue.identifier isEqualToString:@"AddGame"]) {
        
        //identify the top level view controller holding the GameFactsVC (see storyboard)
        UINavigationController *navigationController = segue.destinationViewController;
        
        //go down one level to get the GFVC
        GameFactsViewController *controller = (GameFactsViewController *) navigationController.topViewController;
        
        //set the current controller (the GLVC) as the delegate for the GFVC
        controller.delegate = self;
        
    } else if ([segue.identifier isEqualToString:@"EditGame"]) {
        
        //as above to get to the right place
        UINavigationController *navigationController = segue.destinationViewController;
        GameFactsViewController *controller = (GameFactsViewController *) navigationController.topViewController;
        controller.delegate = self;
        
        //"sender" here is what was clicked, the detail disclosure icon
        //this identifies what game data to load to edit
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.gameToEdit = self.season.games[indexPath.row];
        
    } else if ([segue.identifier isEqualToString:@"GameDetails"]) {
        
        UITabBarController *tabBarController = segue.destinationViewController;
 
        PlayerActionsViewController *controllerPA = (PlayerActionsViewController *)[[tabBarController viewControllers] objectAtIndex:0];
        controllerPA.delegate = self;
        
        PlayerActionsViewController *controllerPR = (PlayerActionsViewController *)[[tabBarController viewControllers] objectAtIndex:1];
        //controllerPR.delegate = self;
        
        PlayerActionsViewController *controllerTR = (PlayerActionsViewController *)[[tabBarController viewControllers] objectAtIndex:2];
        
        
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        controllerPA.gameToEditPerformance = self.season.games[indexPath.row];
        controllerPR.gameToEditPerformance = self.season.games[indexPath.row];
        controllerTR.gameToEditPerformance = self.season.games[indexPath.row];
        
        
        
        //NSLog(@"Data passed %ld", (long)controller.gameToEditPerformance.shotsOnGoal);
        
    }
}

#pragma mark - temporary methods
/*
- (void) createDummyData
{
    
    
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

*/
 
@end
