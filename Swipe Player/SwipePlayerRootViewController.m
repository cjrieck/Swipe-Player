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
	// Do any additional setup after loading the view, typically from a nib.
//    MPMediaPickerController* mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    viewControllerSubView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performSongListSegue:(id)sender {
    
    [self performSegueWithIdentifier:@"songList" sender:sender];
//    MPMediaPickerController* mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
//    [mediaPicker setDelegate:self];
//    mediaPicker.prompt = NSLocalizedString(@"Add songs", "Prompt in item picker");
//    [self presentViewController:mediaPicker animated:YES completion:^{}];
}

//- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
//    [self dismissViewControllerAnimated:YES completion:^{}];
//    SwipeView* previous = [[SwipeView alloc] init];
//    [previous.musicManager setQueueWithItemCollection:mediaItemCollection];
//    
//}
//
//-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
//    [self dismissViewControllerAnimated:YES completion:^{}];
//}
@end
