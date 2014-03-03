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
    musicManager = [MPMusicPlayerController applicationMusicPlayer];
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
    
    // call on main thread
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [musicManager beginGeneratingPlaybackNotifications];
//    });
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
        dispatch_async(dispatch_get_main_queue(), ^{
            [self customInit];
//            [musicManager beginGeneratingPlaybackNotifications];
        });
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self customInit];
//            [musicManager beginGeneratingPlaybackNotifications];
        });
        //[self customInit];
    }
    return self;
}

- (IBAction)leftSwipeDetected:(id)sender {

    [musicManager skipToNextItem];
    currentSong = [musicManager nowPlayingItem];
    [self setCoverArtAndInfo:currentSong];
    
}

- (IBAction)rightSwipeDetected:(id)sender {
    
    [musicManager skipToPreviousItem];
    currentSong = [musicManager nowPlayingItem];
    [self setCoverArtAndInfo:currentSong];

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
    NSLog(@"Song Changed");
}

- (void)handleVolumeChangedFromOutsideApp:(id)notification {
    // animate volume slider once implemented
    // [_volumeSlider setValue:self.musicPlayer.volume animated:YES];
    NSLog(@"Volume Changed");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
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
