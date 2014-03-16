//
//  SwipeView.m
//  Swipe Player
//
//  Created by Clayton Rieck on 2/26/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import "SwipeView.h"

@implementation SwipeView

//@synthesize musicManager;
//@synthesize mediaQuery;
//@synthesize currentSong;
//@synthesize musicCollections;
@synthesize cover;
@synthesize songTitle;
@synthesize songArtist;
@synthesize doubleTapGesture;
@synthesize panGesture;
@synthesize rightSwipe;
@synthesize leftSwipe;
@synthesize longPress;

@synthesize delegate;

-(void)customInit {
    
    // set up the music manager
    MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
    
    globalMediaPlayer.musicManager = [MPMusicPlayerController applicationMusicPlayer];
    [globalMediaPlayer.musicManager setShuffleMode:MPMusicShuffleModeOff];
    [globalMediaPlayer.musicManager setRepeatMode:MPMusicRepeatModeNone];
    
    // creates music queue
    [globalMediaPlayer.musicManager setQueueWithQuery:[MPMediaQuery songsQuery]];
    //    [musicManager setShuffleMode:];
    
    // get collections of songs
    MPMediaQuery* everything = [[MPMediaQuery alloc]init];
    
    globalMediaPlayer.musicCollection = [everything items];
    
//    currentSongIndex = 0;
    
    // gets the screen height
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    
//    MPVolumeView* volumeView = [[MPVolumeView alloc] initWithFrame:CGRectZero];
//    [self addSubview:volumeView];
    
    volumeLevel = 0.5;
    volumeSensitivity = 0.007;
    
    [globalMediaPlayer.musicManager setNowPlayingItem:globalMediaPlayer.musicCollection[0]];
    
    // create music notification center
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                        selector:@selector(handleNowPlayingItemChanged:)
                        name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                        object:globalMediaPlayer.musicManager];
    
    [notificationCenter addObserver:self
                        selector:@selector(handleVolumeChangedFromOutsideApp:)
                        name:MPMusicPlayerControllerVolumeDidChangeNotification
                        object:globalMediaPlayer.musicManager];
    
    [globalMediaPlayer.musicManager beginGeneratingPlaybackNotifications];
    
    [self setCoverArtAndInfo:globalMediaPlayer.musicManager.nowPlayingItem];
	
    globalMediaPlayer.nowPlaying = false;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self customInit];
        });
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self customInit];
        });
    }
    return self;
}

- (IBAction)leftSwipeDetected:(id)sender {
    MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
    [globalMediaPlayer.musicManager skipToNextItem];
    globalMediaPlayer.currentSong = [globalMediaPlayer.musicManager nowPlayingItem];
    [self setCoverArtAndInfo:globalMediaPlayer.currentSong];
    
}

- (IBAction)rightSwipeDetected:(id)sender {
    MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
    [globalMediaPlayer.musicManager skipToPreviousItem];
    globalMediaPlayer.currentSong = [globalMediaPlayer.musicManager nowPlayingItem];
    [self setCoverArtAndInfo:globalMediaPlayer.currentSong];

}

- (IBAction)doubleTap:(id)sender {
    NSLog(@"TAP GESTURE");
    
    MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
    
//    if ([globalMediaPlayer.musicManager playbackState] == MPMusicPlaybackStatePlaying) {
    if (globalMediaPlayer.nowPlaying) {
        NSLog(@"PLAYING AND ABOUT TO STOP");
        [globalMediaPlayer.musicManager pause];
        globalMediaPlayer.nowPlaying = false;
    }
    
    else {
        NSLog(@"STOPPED AND ABOUT TO PLAY");
        [globalMediaPlayer.musicManager play];
        globalMediaPlayer.nowPlaying = true;
    }
    
}

- (IBAction)panUpDown:(UIPanGestureRecognizer*)panGestureSender {
    // prevent pan gesture until both right and left swipe gestures fail
    [self.panGesture requireGestureRecognizerToFail:longPress];
    [self.panGesture requireGestureRecognizerToFail:leftSwipe];
    [self.panGesture requireGestureRecognizerToFail:rightSwipe];
    
    if (panGestureSender.state == UIGestureRecognizerStateChanged) {
        
        CGPoint velocity = [panGestureSender velocityInView: self];
        if (velocity.y > 0) { // panning down
            volumeLevel = volumeLevel - volumeSensitivity;
        }
        else {
            volumeLevel = volumeLevel + volumeSensitivity;
        }
    }
    
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:volumeLevel];
}

- (IBAction)longPressDown:(UIGestureRecognizer*)longPressGesture {
    // show view here of list of songs
    
    // prevents long gesture from being recognized on finger up
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"In LONG PRESS DOWN");
        [delegate performSongListSegue:self];
    }
    
}

- (void)handleNowPlayingItemChanged:(id)notification { // gets called when song changes
    MediaPlayerClass* globalMediaPlayer = [MediaPlayerClass globalMediaPlayerInit];
    [self setCoverArtAndInfo:globalMediaPlayer.currentSong];
    NSLog(@"Song Changed");
}

- (void)handleVolumeChangedFromOutsideApp:(id)notification {
    
    NSLog(@"Volume Changed");
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

- (void)setCoverArtAndInfo:(MPMediaItem*)current {
    
    MPMediaItemArtwork* albumCover = [current valueForProperty:MPMediaItemPropertyArtwork];
    NSString* title = [current valueForProperty:MPMediaItemPropertyTitle];
    NSString* artist = [current valueForProperty:MPMediaItemPropertyArtist];
    
    UIImage* art = [albumCover imageWithSize:cover.bounds.size];
    
    if (title) {
        songTitle.text = title;
        
        if (artist) {
            songArtist.text = artist;
            
            if (art) {
                cover.image = art;
            } else {
                cover.image = [UIImage imageNamed:@"albumFiller.png"];
            }
        } else {
            songArtist.text = @"";
        }
    } else {
        songTitle.text = @"None";
    }
}


@end
