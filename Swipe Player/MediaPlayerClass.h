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
    BOOL nowPlaying;
    
//    MPMusicPlaybackState* currentPlaybackState;
}

@property(nonatomic, strong) MPMusicPlayerController* musicManager;
@property(nonatomic, strong) MPMediaQuery* mediaQuery;
@property(nonatomic, copy) MPMediaItem* currentSong;
@property(nonatomic, strong) NSArray* musicCollection;

// using BOOL to bypass playbackState == MPMusicPlaybackStatePlaying conditional
// in SwipeView.m on doubleTap
@property(nonatomic) BOOL nowPlaying;

+(MediaPlayerClass*)globalMediaPlayerInit;

@end
