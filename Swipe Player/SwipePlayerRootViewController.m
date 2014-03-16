//
//  SwipePlayerRootViewController.m
//  Swipe Player
//
//  Created by Clayton Rieck on 2/25/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import "SwipePlayerRootViewController.h"

@interface SwipePlayerRootViewController ()

@end

@implementation SwipePlayerRootViewController

@synthesize viewControllerSubView;
@synthesize mediaPicker;
//@synthesize mediaPicker;

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"VIEW DID APPEAR SWIPLE PLAYER ROOT VIEW");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    viewControllerSubView.delegate = self; // set the delegate to the subview
    NSLog(@"VIEW DID LOAD SWIPLE PLAYER ROOT VIEW");
    
    mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = NO;
    mediaPicker.prompt = @"Choose Song";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performSongListSegue:(id)sender {
    
    NSLog(@"In PERFORM SONG LIST SEGUE");
//    SongListTableView* nextView = [[SongListTableView alloc] init];
//    [self performSegueWithIdentifier:@"songList" sender:sender];
    
    [self presentViewController:mediaPicker animated:YES completion:nil];
    
    
//    [self resignFirstResponder];
//    [self.navigationController pushViewController:nextView animated:YES];
//    [self.navigationController performSegueWithIdentifier:@"songList" sender:sender];
    
}

- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    
    MPMediaItem *selectedSong = [[mediaItemCollection items] objectAtIndex:0];
    
//    MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
//    if ([globalMediaPlayer.musicManager playbackState] == MPMusicPlaybackStatePlaying) {
//        [globalMediaPlayer.musicManager stop];
//    }
//    
//    [globalMediaPlayer.musicManager setNowPlayingItem:selectedSong];
//    [globalMediaPlayer.musicManager play];
//    globalMediaPlayer.nowPlaying = true;
//    //    [globalMediaPlayer.musicManager playbackState] = MPMusicPlaybackStatePlaying;
//    
//    globalMediaPlayer.currentSong = [globalMediaPlayer.musicManager nowPlayingItem];

    NSLog(@"%@", [selectedSong valueForProperty:MPMediaItemPropertyTitle]);
    
    [self dismissViewControllerAnimated:YES completion:^{
        MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
        if ([globalMediaPlayer.musicManager playbackState] == MPMusicPlaybackStatePlaying) {
            [globalMediaPlayer.musicManager stop];
        }
        
        [globalMediaPlayer.musicManager setNowPlayingItem:selectedSong];
        [globalMediaPlayer.musicManager play];
        globalMediaPlayer.nowPlaying = true;
        //    [globalMediaPlayer.musicManager playbackState] = MPMusicPlaybackStatePlaying;
        
        globalMediaPlayer.currentSong = [globalMediaPlayer.musicManager nowPlayingItem];
    }];
}
@end
