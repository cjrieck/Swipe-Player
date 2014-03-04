//
//  MediaPlayerClass.h
//  Swipe Player
//
//  Created by Clayton Rieck on 3/3/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MediaPlayerClass : NSObject
{
    MPMusicPlayerController* musicManager;
    MPMediaQuery* mediaQuery;
    MPMediaItem* currentSong;
    NSArray* musicCollection;
    
//    UIImageView* cover;
//    UILabel* songTitle;
//    UILabel* songArtist;
}

@property(nonatomic, strong) MPMusicPlayerController* musicManager;
@property(nonatomic, strong) MPMediaQuery* mediaQuery;
@property(nonatomic, copy) MPMediaItem* currentSong;
@property(nonatomic, strong) NSArray* musicCollection;

//@property(nonatomic, retain) UIImageView* cover;
//@property(nonatomic, retain) UILabel* songTitle;
//@property(nonatomic, retain) UILabel* songArtist;

+(MediaPlayerClass*)globalMediaPlayerInit;

@end
