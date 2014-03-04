//
//  SongListTableView.m
//  Swipe Player
//
//  Created by Clayton Rieck on 3/3/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import "SongListTableView.h"

@interface SongListTableView ()

@end

@implementation SongListTableView

@synthesize doneButton;
@synthesize songCollection;
@synthesize musicPlayer;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
//    globalMediaPlayer.musicPlayer = previousView.musicManager;
    
//    [musicPlayer setQueueWithQuery:[MPMediaQuery songsQuery]];
    //    [musicManager setShuffleMode:];
    
    // get collections of songs
    MPMediaQuery* everything = [[MPMediaQuery alloc]init];
    
    songCollection = [everything items];
//    NSLog(@"%i", [songCollection count]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [songCollection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [songCollection[indexPath.row] valueForProperty:MPMediaItemPropertyTitle];
    
    return cell;
}

-(IBAction)dismissModalView:(id)sender {
    MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
    
    [self dismissViewControllerAnimated:YES completion:^{
        // put completion code in here (e.g. set current song)
//        [previousView setCoverArtAndInfo:[globalMediaPlayer.musicManager nowPlayingItem]];
//        [globalMediaPlayer.musicManager play];
//        [[SwipeView alloc] setCoverArtAndInfo:globalMediaPlayer.currentSong];
//        SwipeView* previous = [[SwipeView alloc]init];
//        [previous setCoverArtAndInfo:globalMediaPlayer.currentSong];
//        [previousView setCoverArtAndInfo:[globalMediaPlayer.musicManager nowPlayingItem]];
//        previousView.musicManager = musicPlayer;
//        [SwipeView ]
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
    [globalMediaPlayer.musicManager stop];
    [globalMediaPlayer.musicManager setNowPlayingItem:songCollection[indexPath.row]];
    [globalMediaPlayer.musicManager play];
    globalMediaPlayer.currentSong = [globalMediaPlayer.musicManager nowPlayingItem];
    
//    [previousView setCoverArtAndInfo:[globalMediaPlayer.musicManager nowPlayingItem]];
    [self dismissModalView:self];
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
