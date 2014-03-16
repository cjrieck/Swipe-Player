//
//  SwipePlayerRootViewController.h
//  Swipe Player
//
//  Created by Clayton Rieck on 2/25/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SwipeView.h"
#import "SongListTableView.h"

@interface SwipePlayerRootViewController : UIViewController <SwipeViewDelegate>

@property(nonatomic, strong) IBOutlet SwipeView* viewControllerSubView;
@property(nonatomic, strong) MPMediaPickerController* mediaPicker;

@end
