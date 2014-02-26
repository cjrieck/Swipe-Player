//
//  SwipeView.h
//  Swipe Player
//
//  Created by Clayton Rieck on 2/26/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeView : UIView<UIGestureRecognizerDelegate>

- (IBAction)upSwipeDetected:(id)sender;
- (IBAction)downSwipeDetected:(id)sender;
- (IBAction)leftSwipeDetected:(id)sender;
- (IBAction)rightSwipeDetected:(id)sender;

@end
