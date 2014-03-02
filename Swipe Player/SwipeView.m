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
//@synthesize timeUISlider;
//@synthesize progressTimer;

-(void)customInit {
    // set up the music manager
    musicManager = [MPMusicPlayerController applicationMusicPlayer];
    
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
    
    [musicManager setNowPlayingItem:musicCollections[currentSongIndex]];
//    [self setCoverArtAndInfo:currentSongIndex];
    
    
    
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
    
//    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
//    NSError* setCategoryError = nil;
//    
//    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
//    if (setCategoryError) {
//        NSLog(@"FAIL 1");
//    }
//    
//    NSError* activationError = nil;
//    [audioSession setActive:YES error:&activationError];
//    if (activationError) {
//        NSLog(@"FAIL 2");
//    }


//    NSError *setCategoryErr = nil;
//    NSError *activationErr  = nil;
//    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:&setCategoryErr];
//    [[AVAudioSession sharedInstance] setActive:YES error:&activationErr];
//    
//    if (setCategoryErr) {
//        NSLog(@"%@", [setCategoryErr userInfo]);
//    }
//    
//    if (activationErr) {
//        NSLog(@"%@", [activationErr userInfo]);
//    }

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

- (IBAction)leftSwipeDetected:(id)sender {
    
    currentSongIndex++;
    
    if (currentSongIndex == [musicCollections count]) {
        currentSongIndex = [musicCollections count]-1;
    }
    
    [self setCoverArtAndInfo:currentSongIndex];
    [self stopAndPlayNext:currentSongIndex];
    
}

- (IBAction)rightSwipeDetected:(id)sender {
    
    currentSongIndex--;
    
    if (currentSongIndex < 0) {
        currentSongIndex = 0;
    }
    
    [self setCoverArtAndInfo:currentSongIndex];
    [self stopAndPlayNext:currentSongIndex];

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

//- (void)handleNowPlayingItemChanged:(id)notification {
//    
//    NSNumber* duration = [currentSong valueForProperty:MPMediaItemPropertyPlaybackDuration];
//    float totalTime = [duration floatValue];
//    
//    timeUISlider.maximumValue = totalTime;
//    
//    [musicManager setCurrentPlaybackTime: [timeUISlider value]];
//}
//
//- (void)updateSlider {
//    [timeUISlider setValue:musicManager.currentPlaybackTime animated:YES];
//}
//
//- (void)resetTimer:(NSTimer *)timer {
//    [progressTimer invalidate];
//    progressTimer = nil;
//    progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self
//                                                   selector:@selector(updateSlider)
//                                                   userInfo:nil repeats:YES];
//    
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)stopAndPlayNext:(long)songIndex {
    
    [musicManager stop];
    [musicManager setNowPlayingItem:musicCollections[songIndex]];
    [musicManager play];
    currentSong = musicCollections[songIndex];
}

- (void)setCoverArtAndInfo:(long)songIndex {
    
    MPMediaItemArtwork* albumCover = [musicCollections[songIndex] valueForProperty:MPMediaItemPropertyArtwork];
    NSString* title = [musicCollections[songIndex] valueForProperty:MPMediaItemPropertyTitle];
    NSString* artist = [musicCollections[songIndex] valueForProperty:MPMediaItemPropertyArtist];
    
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

//-(void)updateQueueWithCollection:(MPMediaQuery*)collection {
//    musicManager.currentPlaybackTime = currentSong.
//}
@end
