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

@synthesize viewControllerSubView;
//@synthesize mediaPicker;

- (void)viewDidAppear:(BOOL)animated {
//    [[SwipeView alloc] initWithFrame:CGRectZero];
    NSLog(@"VIEW DID APPEAR SWIPLE PLAYER ROOT VIEW");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    viewControllerSubView.delegate = self; // set the delegate to the subview
    NSLog(@"VIEW DID LOAD SWIPLE PLAYER ROOT VIEW");
//    [SwipeView alloc]; // initializes the gestures once the modal view is dismissed
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performSongListSegue:(id)sender {
    
    NSLog(@"In PERFORM SONG LIST SEGUE");
    [self performSegueWithIdentifier:@"songList" sender:self];
}

@end
