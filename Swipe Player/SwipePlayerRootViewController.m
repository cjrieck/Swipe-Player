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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    viewControllerSubView.delegate = self; // set the delegate to the subview
//    [SwipeView alloc]; // initializes the gestures once the modal view is dismissed
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performSongListSegue:(id)sender {
    
    [self performSegueWithIdentifier:@"songList" sender:sender];

}

@end
