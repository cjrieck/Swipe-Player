//
//  SwipeView.h
//  Swipe Player
//
//  Created by Clayton Rieck on 2/26/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SwipeView : UIView<UIGestureRecognizerDelegate>
{
//    IBOutlet UIImageView* cover;
    
    CGPoint start;
    CGPoint end1;
    CGPoint end2;
    CGFloat screenHeight;
    NSArray* musicCollections;
    
    
    int currentSongIndex;
    double volumeLevel;
    double volumeSensitivity;
}

@property(nonatomic, strong) MPMusicPlayerController* musicManager;
@property(nonatomic, strong) MPMediaQuery* mediaQuery;
@property(nonatomic, copy) MPMediaItem* currentSong;

@property(nonatomic, retain) IBOutlet UIImageView* cover;
@property(nonatomic, retain) IBOutlet UILabel* songTitle;
@property(nonatomic, retain) IBOutlet UILabel* songArtist;

@property(nonatomic, strong) IBOutlet UIPanGestureRecognizer* panGesture;
@property(nonatomic, strong) IBOutlet UISwipeGestureRecognizer* leftSwipe;
@property(nonatomic, strong) IBOutlet UISwipeGestureRecognizer* rightSwipe;

- (void)customInit;
- (IBAction)leftSwipeDetected:(id)sender;
- (IBAction)rightSwipeDetected:(id)sender;
//- (IBAction)upDownPanDetected:(id)sender;
- (IBAction)doubleTap:(id)sender;

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;



//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)panUpDown:(UIPanGestureRecognizer*)panGesture;
- (void)stopAndPlayNext:(int)songIndex;
- (void)setCoverArtAndInfo:(int)songIndex;
@end
