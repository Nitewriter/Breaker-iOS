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

- (id)initWithPlaylist:(NSDictionary *)playlist;

- (void)loadPlaylist;
- (void)unloadPlaylist;

- (BOOL)createSystemSoundForKey:(NSString *)key;
- (void)removeSystemSoundForKey:(NSString *)key;
- (void)playSystemSoundForKey:(NSString *)key;

- (BOOL)systemSoundExistsForKey:(NSString *)key;


@end
