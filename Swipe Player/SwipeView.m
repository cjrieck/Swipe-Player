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
    
    [self stopAndPlayNext:currentSongIndex];
    
}

- (IBAction)rightSwipeDetected:(id)sender {
    
    currentSongIndex++;
    
    [self stopAndPlayNext:currentSongIndex];
    
    NSLog(@"SWIPE RIGHT");
}

- (IBAction)doubleTap:(id)sender {
    [self stopAndPlayNext:currentSongIndex];
    NSLog(@"DOUBLE TAP");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    start = [touch locationInView:self];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    end = [touch locationInView:self];
    
    double volumeLevel = 1.0-(end.y/screenHeight);
    
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:volumeLevel];
    
    
    NSLog(@"%f", volumeLevel);
    
}

- (void)stopAndPlayNext:(int)songIndex {
    [musicManager stop];
    [musicManager setNowPlayingItem:musicCollections[songIndex]];
    [musicManager play];
}

@end
