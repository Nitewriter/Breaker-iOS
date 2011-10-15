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
    NSMutableDictionary *_sounds;
}

@property (nonatomic, readonly) NSMutableDictionary *playlist;
@property (nonatomic, readonly) NSMutableDictionary *sounds;

@property (nonatomic, readonly) NSInteger numberOfPlaylistReferences;
@property (nonatomic, readonly) NSInteger numberOfSounds;
@property (nonatomic, readonly, getter = isPlaylistLoaded) BOOL playlistLoaded;
@property (nonatomic, readonly) NSArray *unloadedKeys;

- (id)initWithPlaylist:(NSDictionary *)playlist;
- (id)initWithPlaylist:(NSDictionary *)playlist loadImmediately:(BOOL)load;

- (void)loadPlaylist;
- (void)unloadPlaylist;

- (BOOL)systemSoundExistsForKey:(NSString *)key;
- (BOOL)createSystemSoundWithName:(NSString *)filename forKey:(NSString *)key;
- (BOOL)createSystemSoundForKey:(NSString *)key;
- (void)removeSystemSoundForKey:(NSString *)key;
- (void)playSystemSoundForKey:(NSString *)key;



@end
