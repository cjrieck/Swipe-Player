//
//  SongListTableView.h
//  Swipe Player
//
//  Created by Clayton Rieck on 3/3/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SwipeView.h"
#import "SwipePlayerRootViewController.h"

@interface SongListTableView : UITableViewController
{
    NSArray* songCollection;
    SwipeView* previousView;
}
@property(nonatomic, strong) IBOutlet UIBarButtonItem* doneButton;

@property(nonatomic, strong) MPMusicPlayerController* musicPlayer;
@property(nonatomic, strong) NSArray* songCollection;

//@property(nonatomic, strong) IBOutlet UIImageView* coverArt;

-(IBAction)dismissModalView:(id)sender;

@end
