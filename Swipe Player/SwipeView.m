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

-(void)customInit {
    // initialize stuff here
    musicManager = [MPMusicPlayerController applicationMusicPlayer];
    [musicManager setQueueWithQuery:[MPMediaQuery songsQuery]];
    
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
}

- (IBAction)rightSwipeDetected:(id)sender {
    NSLog(@"SWIPE RIGHT");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    start = [touch locationInView:self];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    end = [touch locationInView:self];
    
//    NSLog(@"%f", screenHeight);
//    NSLog(@"---------------------------------------------------------------------------");
    
    double volumeLevel = 1.0-(end.y/screenHeight);
    
    
    
    NSLog(@"%f", volumeLevel);
    
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//}

@end
