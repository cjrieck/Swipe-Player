//
//  SwipeView.m
//  Swipe Player
//
//  Created by Clayton Rieck on 2/26/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import "SwipeView.h"

@implementation SwipeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        screenHeight = [[UIScreen mainScreen] bounds].size.height;
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
    
//    double volumeLevel = end.y/screenHeight;
    
    NSLog(@"%f", screenHeight);
    
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//}

@end
