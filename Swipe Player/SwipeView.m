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
    }
    return self;
}


- (IBAction)upSwipeDetected:(id)sender {
    NSLog(@"SWIPE UP");
}

- (IBAction)downSwipeDetected:(id)sender {
    NSLog(@"SWIPE DOWN");
}

- (IBAction)leftSwipeDetected:(id)sender {
    NSLog(@"SWIPE LEFT");
}

- (IBAction)rightSwipeDetected:(id)sender {
    NSLog(@"SWIPE RIGHT");
}


@end
