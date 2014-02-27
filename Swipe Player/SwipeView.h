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
    CGPoint start;
    CGPoint end;
    
    CGFloat screenHeight;
}

@property(nonatomic, strong)MPMusicPlayerController* musicManager;

- (void)customInit;
//- (IBAction)upSwipeDetected:(id)sender;
//- (IBAction)downSwipeDetected:(id)sender;
- (IBAction)leftSwipeDetected:(id)sender;
- (IBAction)rightSwipeDetected:(id)sender;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
