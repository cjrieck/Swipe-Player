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
@synthesize songTitle;
@synthesize songArtist;
@synthesize panGesture;
@synthesize rightSwipe;
@synthesize leftSwipe;
@synthesize notificationCenter;

-(void)customInit {
    // set up the music manager
    musicManager = [MPMusicPlayerController iPodMusicPlayer];
//    [musicManager setShuffleMode:MPMusicShuffleModeDefault];
//    [musicManager setRepeatMode:MPMusicRepeatModeDefault];
    
    // creates music queue
    [musicManager setQueueWithQuery:[MPMediaQuery songsQuery]];
    //    [musicManager setShuffleMode:];
    
    // get collections of songs
    MPMediaQuery* everything = [[MPMediaQuery alloc]init];
    
    musicCollections = [everything items];
    
    currentSongIndex = 0;
    
    // gets the screen height
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    
    MPVolumeView* volumeView = [[MPVolumeView alloc] initWithFrame:CGRectZero];
    [self addSubview:volumeView];
    
    volumeLevel = 0.5;
    volumeSensitivity = 0.007;
    
    [musicManager setNowPlayingItem:musicCollections[0]];
    
    // create music notification center
    notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                        selector:@selector(handleNowPlayingItemChanged:)
                        name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                        object:musicManager];
    
    [notificationCenter addObserver:self
                        selector:@selector(handleVolumeChangedFromOutsideApp:)
                        name:MPMusicPlayerControllerVolumeDidChangeNotification
                        object:musicManager];
    
//    [musicManager beginGeneratingPlaybackNotifications];
    
    MPMediaItemArtwork* albumCover = [musicCollections[currentSongIndex] valueForProperty:MPMediaItemPropertyArtwork];
    NSString* title = [musicCollections[currentSongIndex] valueForProperty:MPMediaItemPropertyTitle];
    NSString* artist = [musicCollections[currentSongIndex] valueForProperty:MPMediaItemPropertyArtist];
    
    UIImage* art = [albumCover imageWithSize:cover.bounds.size];
    
    if (title) {
        songTitle.text = title;
        
        if (artist) {
            songArtist.text = artist;
            
            if (art) {
                cover.image = art;
            } else {
                // replace with filler art
                NSLog(@"No art");
            }
        } else {
            songArtist.text = @"";
        }
    } else {
        songTitle.text = @"None";
    }

    [[AVAudioSession sharedInstance] setDelegate: self];
	
	
	// Use this code instead to allow the app sound to continue to play when the screen is locked.
//	[[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
	
	NSError *myErr;
    
    if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&myErr]) {
        NSLog(@"Audio Session error %@, %@", myErr, [myErr userInfo]);
    }
	
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

//- (void)initMusicPlayer {
//    musicManager = [MPMusicPlayerController iPodMusicPlayer];
//    [musicManager setShuffleMode:MPMusicShuffleModeDefault];
//    [musicManager setRepeatMode:MPMusicRepeatModeDefault];
//    
//    // creates music queue
//    [musicManager setQueueWithQuery:[MPMediaQuery songsQuery]];
//    
//    // get collections of songs
//    MPMediaQuery* everything = [[MPMediaQuery alloc]init];
//    
//    musicCollections = [everything items];
//    
//}

- (IBAction)leftSwipeDetected:(id)sender {
    
//    currentSongIndex++;
//    
//    if (currentSongIndex == [musicCollections count]) {
//        currentSongIndex = [musicCollections count]-1;
//    }

    [musicManager skipToNextItem];
    [self setCoverArtAndInfo:currentSong];
    
//    [self stopAndPlayNext:currentSongIndex];
    
}

- (IBAction)rightSwipeDetected:(id)sender {
    
//    currentSongIndex--;
//    
//    if (currentSongIndex < 0) {
//        currentSongIndex = 0;
//    }
    
    [musicManager skipToPreviousItem];
    [self setCoverArtAndInfo:currentSong];
    
//    [self stopAndPlayNext:currentSongIndex];

}

- (IBAction)doubleTap:(id)sender {
    
    if ([musicManager playbackState] == MPMusicPlaybackStatePlaying) {
        [musicManager pause];
    }
    
    else {
        [musicManager play];
    }
    
}

- (IBAction)panUpDown:(UIPanGestureRecognizer*)panGestureSender {
    // prevent pan gesture until both right and left swipe gestures fail
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

- (void)handleNowPlayingItemChanged:(id)notification { // gets called when song changes
    currentSong = [musicManager nowPlayingItem];
    [self setCoverArtAndInfo:currentSong];
    
}

- (void)handleVolumeChangedFromOutsideApp:(id)notification {
    // animate volume slider once implemented
    // [_volumeSlider setValue:self.musicPlayer.volume animated:YES];
    NSLog(@"Volume changed");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)stopAndPlayNext:(long)songIndex {
    
    [musicManager stop];
    [musicManager setNowPlayingItem:musicCollections[songIndex]];
    [musicManager play];
    currentSong = musicCollections[songIndex];
}

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
                // replace with filler art
                NSLog(@"No art");
            }
        } else {
            songArtist.text = @"";
        }
    } else {
        songTitle.text = @"None";
    }
}


@end
