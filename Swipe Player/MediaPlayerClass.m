//
//  MediaPlayerClass.m
//  Swipe Player
//
//  Created by Clayton Rieck on 3/3/14.
//  Copyright (c) 2014 CLA. All rights reserved.
//

#import "MediaPlayerClass.h"

static MediaPlayerClass* globalMediaPlayer = nil;

@implementation MediaPlayerClass

@synthesize musicManager;
@synthesize mediaQuery;
@synthesize currentSong;
@synthesize musicCollection;
@synthesize nowPlaying;
//@synthesize cover;
//@synthesize songTitle;
//@synthesize songArtist;

+(MediaPlayerClass*)globalMediaPlayerInit {
    if (globalMediaPlayer == nil) {
        globalMediaPlayer = [[super allocWithZone:NULL] init];
    }
    return globalMediaPlayer;
}

@end
