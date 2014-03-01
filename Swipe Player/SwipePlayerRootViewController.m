//
//  SwipePlayerRootViewController.m
//  Swipe Player
//
//  Created by Clayton Rieck on 2/25/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import "SwipePlayerRootViewController.h"

@interface SwipePlayerRootViewController ()

@end

@implementation SwipePlayerRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:&setCategoryErr];
    [[AVAudioSession sharedInstance] setActive:YES error:&activationErr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
