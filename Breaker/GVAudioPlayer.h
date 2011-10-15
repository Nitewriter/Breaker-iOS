//
//  GVAudioPlayer.h
//  Breaker
//
//  Created by Joel Garrett on 10/14/11.
//  Copyright (c) 2011 Joel Garrett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface GVAudioPlayer : NSObject
{
    NSMutableDictionary *_playlist;
}

@property (nonatomic, readonly) NSMutableDictionary *playlist;

- (void)createSoundIDForAllKeys;
- (void)createSoundIDForKey:(NSString *)key;
- (void)removeSoundIDForKey:(NSString *)key;
- (void)playSoundIDForKey:(NSString *)key;
- (SystemSoundID)soundIDForKey:(NSString *)key;


@end
