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

-(void)customInit {
    // set up the music manager
    musicManager = [MPMusicPlayerController applicationMusicPlayer];
    
    // creates music queue
    [musicManager setQueueWithQuery:[MPMediaQuery songsQuery]];
    
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
    volumeSensitivity = 0.005;
    
    [self setCoverArtAndInfo:currentSongIndex];
    
//    self.rightSwipe.delegate = self;
    
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
        NSLog(@"DOUBLE TAP STOPPING");
        [musicManager pause];
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

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    UITouch* touch = [touches anyObject];
//    end1 = [touch locationInView:self];
//    
//    if (end2.y==0.0) {
//        end2 = end1;
//    }
//    
//    if ((end1.y-end2.y) > 0) { // moving down
//        volumeLevel = volumeLevel - volumeSensitivity; // decrease volume
//    }
//    
//    else {
//        volumeLevel = volumeLevel + volumeSensitivity;
//    }
//    
//    [[MPMusicPlayerController applicationMusicPlayer] setVolume:volumeLevel];
//    
//    NSLog(@"Volume level: %f", volumeLevel);
//    
//    end2 = end1;
//}

//- (IBAction)upDownPanDetected:(id)sender {
//    NSLog(@"Sender");
//}

- (IBAction)panUpDown:(UIPanGestureRecognizer*)panGestureSender {
    [self.panGesture requireGestureRecognizerToFail:leftSwipe];
    [self.panGesture requireGestureRecognizerToFail:rightSwipe];
    
//    NSLog(@"PANNING UP/DOWN");
    if (panGestureSender.state == UIGestureRecognizerStateChanged) {
    
//        NSLog(@"PANNING UP/DOWN");
        
        CGPoint velocity = [panGestureSender velocityInView: self];
        if (velocity.y > 0) {
            // panning down
            volumeLevel = volumeLevel - volumeSensitivity;
        }
        else {
            volumeLevel = volumeLevel + volumeSensitivity;
        }
    }
    
    
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:volumeLevel];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)stopAndPlayNext:(int)songIndex {
    
    [musicManager stop];
    [musicManager setNowPlayingItem:musicCollections[songIndex]];
    [musicManager play];
    currentSong = musicCollections[songIndex];
}

- (void)setCoverArtAndInfo:(int)songIndex {
    
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
                
            }
            
            else {
                // replace with filler art
                NSLog(@"No art");
            }
            
        }
        
        else {
            songArtist.text = @"";
        }
        
    }
    
    else {
        songTitle.text = @"None";
    }
    
    
}

@end
