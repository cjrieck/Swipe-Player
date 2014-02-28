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
    CGPoint end;
    CGFloat screenHeight;
    NSArray* musicCollections;
    
    
    int currentSongIndex;
    double volumeLevel;
}

@property(nonatomic, strong) MPMusicPlayerController* musicManager;
@property(nonatomic, strong) MPMediaQuery* mediaQuery;
@property(nonatomic, copy) MPMediaItem* currentSong;
@property(nonatomic, retain) IBOutlet UIImageView* cover;

- (void)customInit;
//- (IBAction)upSwipeDetected:(id)sender;
//- (IBAction)downSwipeDetected:(id)sender;
- (IBAction)leftSwipeDetected:(id)sender;
- (IBAction)rightSwipeDetected:(id)sender;
- (IBAction)doubleTap:(id)sender;

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)stopAndPlayNext:(int)songIndex;
- (void)setCoverArt:(int)songIndex;
@end
