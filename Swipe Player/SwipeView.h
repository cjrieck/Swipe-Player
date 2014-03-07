//
//  SwipeView.h
//  Swipe Player
//
//  Created by Clayton Rieck on 2/26/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MediaPlayerClass.h"

@protocol SwipeViewDelegate <NSObject>

- (void) performSongListSegue:(id)sender;

@end

@interface SwipeView : UIView<UIGestureRecognizerDelegate>
{
    CGFloat screenHeight;

    double volumeLevel;
    double volumeSensitivity;
}

@property(nonatomic, strong) id<SwipeViewDelegate>delegate;

// song information
@property(nonatomic, strong) IBOutlet UIImageView* cover;
@property(nonatomic, strong) IBOutlet UILabel* songTitle;
@property(nonatomic, strong) IBOutlet UILabel* songArtist;

// gestures
@property(nonatomic, retain) IBOutlet UITapGestureRecognizer* doubleTapGesture;
@property(nonatomic, retain) IBOutlet UIPanGestureRecognizer* panGesture;
@property(nonatomic, retain) IBOutlet UISwipeGestureRecognizer* leftSwipe;
@property(nonatomic, retain) IBOutlet UISwipeGestureRecognizer* rightSwipe;
@property(nonatomic, retain) IBOutlet UILongPressGestureRecognizer* longPress;

- (void)customInit;

- (IBAction)leftSwipeDetected:(id)sender;
- (IBAction)rightSwipeDetected:(id)sender;
- (IBAction)doubleTap:(id)sender;
- (IBAction)panUpDown:(UIPanGestureRecognizer*)panGesture;
- (IBAction)longPressDown:(UIGestureRecognizer*)longPressGesture;

- (void)handleNowPlayingItemChanged:(id)notification;
//- (void)handleVolumeChangedFromOutsideApp:(id)notification;

- (void)setCoverArtAndInfo:(MPMediaItem*)current;
@end
