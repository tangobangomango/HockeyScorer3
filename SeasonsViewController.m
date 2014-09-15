//
//  SeasonsViewController.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/13/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "SeasonsViewController.h"
#import "Season.h"
// needed so can pass the season name along. See prepareForSegue
#import "GameListViewController.h"


@interface SeasonsViewController ()
{
    NSMutableArray *_seasons;//array of Seasons
}

@end

@implementation SeasonsViewController


//Not used since using storyboard
/*- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

//so will be able to load saved data from the file
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _seasons = [[NSMutableArray alloc] initWithCapacity:10];
    
    
    Season *season;
    
    season = [[Season alloc] init];
    season.seasonName = @"2014-15 CYA U14";
    [_seasons addObject:season];
    
    season = [[Season alloc] init];
    season.seasonName = @"2014 WCS";
    [_seasons addObject:season];
    
    season = [[Season alloc] init];
    season.seasonName = @"2014 Spring CYA U14";
    [_seasons addObject:season];
    
    season = [[Season alloc] init];
    season.seasonName = @"2014-15 CYA U12";
    [_seasons addObject:season];
        
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_seasons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set up identifer to be used for "tagging" and reusing cells
    static NSString *cellIdentifier = @"Cell";
    
    //if there is a cell with the identifier, get it
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //if not, allocate a new cell and assign the identifier
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //load the data into the cells and add a detail disclosure button (this button was added via storyboard in the games list
    Season *season =_seasons[indexPath.row];
    cell.textLabel.text = season.seasonName;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

//with the appraoch used here, no prototype cells so need to make seque here in code
//seque is to games list controller as seque between these views has identifier ShowGames
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //so we can pass the season name to the Games list/GLVC
    Season *season = _seasons[indexPath.row];
    
    
    //sender is the season
    [self performSegueWithIdentifier:@"ShowGames" sender:season];
}

//Not using a segue for accessory button, so need to do the transition manually
-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //locate the VC to be transitioned to (which is done via the containing navigation controller)
    //Each VC has a self.storyboard property to refer to storyboard VC was loaded from
    //Gives an identifier to the VC and instantiates it.
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"SeasonNavigationController"];
    
    //Locates the SFVC and passes appropriate season to it
    SeasonFactsViewController *controller = (SeasonFactsViewController *) navigationController.topViewController;
    controller.delegate = self;
    Season *season = _seasons[indexPath.row];
    controller.seasonToEdit = season;
    
    //Notice here that controller is the navigation controller not the GFVC that is presented
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - SFVC delegate methods

- (void) seasonFactsViewControllerDidCancel:(SeasonFactsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) seasonFactsViewController:(SeasonFactsViewController *)controller didFinishAddingSeason:(Season *)season
{
    NSInteger newRowIndex = [_seasons count]; //get location to add new record (season)
    
    [_seasons addObject: season]; //add to data model
    
    //add to screen
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) seasonFactsViewController:(SeasonFactsViewController *)controller didFinishEditingSeason:(Season *)season
{
    //edit already made in data model in SFVC
    //need to update display
    
    NSInteger index = [_seasons indexOfObject: season];//locate the item being edited in the games array
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];//get the right cell
    
    cell.textLabel.text = season.seasonName;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
}

// This implements swipe to delete
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //First delete record from seasons array
    [_seasons removeObjectAtIndex:indexPath.row];
    
    
    
    //Next delete row from the screen
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

#pragma mark - Segue


//Need to make the actual prep for the seque
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowGames"]) {
        //Identify where the segue is going and pass the season "value" to that controller
        GameListViewController *controller = segue.destinationViewController;
        controller.season = sender;
    } else if ([segue.identifier isEqualToString:@"AddSeason"]) {
        
        //Identify the current controller in two steps
        
        //Identify the navigation controller that hold the SFVC
        UINavigationController *navigationController = segue.destinationViewController;
        
        //Step down
        SeasonFactsViewController *controller = (SeasonFactsViewController *)navigationController.topViewController;
        
        //set the controller delegate to this SVC
        
        controller.delegate = self;
        
        //this not done in GFVC; must have to do with doing segues or table cells differently
        controller.seasonToEdit = nil;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
