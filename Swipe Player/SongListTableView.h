//
//  SongListTableView.h
//  Swipe Player
//
//  Created by Clayton Rieck on 3/3/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongListTableView : UITableViewController

@property(nonatomic, strong) IBOutlet UIBarButtonItem* doneButton;

-(IBAction)dismissModalView:(id)sender;

@end
