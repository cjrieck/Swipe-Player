//
//  SwipeView.m
//  Swipe Player
//
//  Created by Clayton Rieck on 2/26/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import "SwipeView.h"

@implementation SwipeView

@synthesize musicManager;
@synthesize mediaQuery;
@synthesize currentSong;
@synthesize cover;

-(void)customInit {
    // set up the music manager
    musicManager = [MPMusicPlayerController applicationMusicPlayer];
    
    // creates music queue
    [musicManager setQueueWithQuery:[MPMediaQuery songsQuery]];
    
    // get collections of songs
    MPMediaQuery* everything = [[MPMediaQuery alloc]init];
    
    musicCollections = [everything items];

    //    for (MPMediaItem* song in musicCollections) {
//        NSString* titles = [song valueForProperty: MPMediaItemPropertyTitle];
//        NSLog (@"%@", titles);
//    }
    
    // get the collections in an array
//    musicCollections = [mediaQuery collections];
    
//    NSLog(@"%tu", musicCollections.count);
    
    // gets current song playing
//    currentSong = [[MPMusicPlayerController iPodMusicPlayer] nowPlayingItem];
//    [[MPMusicPlayerController iPodMusicPlayer] play];
    currentSongIndex = 0;
    
    // gets the screen height
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    
    volumeLevel = 0.0;
    
    [self setCoverArt:currentSongIndex];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])){
        [self customInit];
    }
    return self;
}

- (IBAction)leftSwipeDetected:(id)sender {
    NSLog(@"SWIPE LEFT");
    
    currentSongIndex++;
    
    [self setCoverArt:currentSongIndex];
    [self stopAndPlayNext:currentSongIndex];
    
}

- (IBAction)rightSwipeDetected:(id)sender {
    
    currentSongIndex--;
    
    [self setCoverArt:currentSongIndex];
    [self stopAndPlayNext:currentSongIndex];

}

- (IBAction)doubleTap:(id)sender {
    
    if ([musicManager playbackState] == MPMusicPlaybackStatePlaying) {
        NSLog(@"DOUBLE TAP STOPPING");
        [musicManager stop];
    }
    
    else {
        NSLog(@"DOUBLE TAP PLAYING");
        [musicManager play];
    }
    
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch* touch = [touches anyObject];
//    start = [touch locationInView:self];
//    
//}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    end = [touch locationInView:self];
    
    double currentVolumeLevel = volumeLevel;
    
    volumeLevel = 1.0-(end.y/screenHeight);
    
    if ((volumeLevel - currentVolumeLevel) > 0.009 || (volumeLevel - currentVolumeLevel) < 0.009) {
        [[MPMusicPlayerController applicationMusicPlayer] setVolume:volumeLevel];
    }
}

- (void)stopAndPlayNext:(int)songIndex {
    
    if (songIndex < 0) {
        songIndex = 0;
    }
    else if (songIndex > [musicCollections count]) {
        songIndex = [musicCollections count] - 1;
    }
    
    [musicManager stop];
    [musicManager setNowPlayingItem:musicCollections[songIndex]];
    [musicManager play];
    currentSong = musicCollections[songIndex];
}

- (void)setCoverArt:(int)songIndex {
    MPMediaItemArtwork* albumCover = [musicCollections[songIndex] valueForProperty:MPMediaItemPropertyArtwork];
    UIImage* art = [albumCover imageWithSize:cover.bounds.size];
    
    if (art) {
        cover.image = art;
    }
    
    else {
        // replace with filler art
        NSLog(@"No art");
    }
}

@end
