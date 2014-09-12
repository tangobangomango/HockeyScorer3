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

#pragma mark - file operations

//Generic method to get location of apps documents directory
- (NSString *) documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

//set name of data file and construct full path
- (NSString *) dataFilePath
{
    //NSLog(@"%@", [[self documentsDirectory] stringByAppendingPathComponent:@"HockeyScorer.plist"]);
    return [[self documentsDirectory] stringByAppendingPathComponent:@"HockeyScorer.plist"];
}

//Must remember to adopt NSCoding in Game class and implement all keys for decoding and encodong

- (void) loadGames
{
    NSString *path = [self dataFilePath];//for convenience below
    
    //if there is already a data file, unarchive/decode and load games array
    //else create an empty arry to hold games
    if ([[NSFileManager defaultManager] fileExistsAtPath: path]) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile: path];//data structure created and loaded with file data
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData: data];//archiver created and connected to data
        
        _games = [unarchiver decodeObjectForKey:@"Games"];
        
        [unarchiver finishDecoding];//data now in games array
        
    } else {
        
        _games = [[NSMutableArray alloc] initWithCapacity:50];
    }
}

- (void) saveGames
{
    NSMutableData *data = [[NSMutableData alloc] init];//data structure to hold the data to be saved after encoding
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:_games forKey:@"Games"];//I believe key here needs to match class name that will be saved. It tells archiver how to encode object properly
    
    [archiver finishEncoding];//finish encoding, with data now in data structure
    
    [data writeToFile:[self dataFilePath] atomically:YES];//write data structure to file determined above
    
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];//this is WithCoder because VC has been saved by encoding in the storyboard
    if (self) {
        [self loadGames];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    

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





#pragma mark - delegate methods for AddGameVC

- (void) gameFactsViewControllerDidCancel:(GameFactsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) gameFactsViewController:(GameFactsViewController *)controller didFinishAddingGame:(Game *)game
{
    NSInteger newRowIndex = [_games count]; //get location to add new record (game)
    
    [_games addObject: game]; //add to data model
    
    //add to screen
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];//get the right cell
    //[self configureDataForCell:cell withGame:game];//puts the game data into the labels in the cell
    
    [self saveGames];//write the current data to the file
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) gameFactsViewController:(GameFactsViewController *)controller didFinishEditingGame:(Game *)game
{
    //edit already made in data model in GFVC
    //need to update display
    
    NSInteger index = [_games indexOfObject: game];//locate the item being edited in the games array
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];//get the right cell
    
    [self configureDataForCell:cell withGame:game];//puts the game data into the labels in the cell
    
    [self saveGames];//write the current data to the file
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// This implements swipe to delete
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //First delete record from games array
    [_games removeObjectAtIndex:indexPath.row];
    
    [self saveGames];//write the current data to the file
    
    //Next delete row from the screen
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

#pragma  mark - delegate methods for PlayersActionsVC

- (void) playerActionsViewController: (PlayerActionsViewController *) controller didEditGameData: (Game *) game
{
    NSLog(@"Paased back shots %ld", (long) game.shotsOnGoal);
    [self saveGames];
    
    
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
        
        //set the current controller (the HSVC) as the delegate for the GFVC
        controller.delegate = self;
        
    } else if ([segue.identifier isEqualToString:@"EditGame"]) {
        
        //as above to get to the right place
        UINavigationController *navigationController = segue.destinationViewController;
        GameFactsViewController *controller = (GameFactsViewController *) navigationController.topViewController;
        controller.delegate = self;
        
        //"sender" here is what was clicked, the detail disclosure icon
        //this identifies what game data to load to edit
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.gameToEdit = _games[indexPath.row];
        
    } else if ([segue.identifier isEqualToString:@"GameDetails"]) {
        
        UITabBarController *tabBarController = segue.destinationViewController;
        PlayerActionsViewController *controller = (PlayerActionsViewController *)[[tabBarController viewControllers] objectAtIndex:0];
        controller.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        controller.gameToEditPerformance = _games[indexPath.row];
        NSLog(@"Data passed %ld", (long)controller.gameToEditPerformance.shotsOnGoal);
        
    }
}

#pragma mark - temporary methods

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


 
@end
