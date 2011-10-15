//
//  GVAudioPlayer.m
//  Breaker
//
//  Created by Joel Garrett on 10/14/11.
//  Copyright (c) 2011 Joel Garrett. All rights reserved.
//

#import "GVAudioPlayer.h"

@implementation GVAudioPlayer

@synthesize playlist = _playlist;
@synthesize sounds = _sounds;

- (void)dealloc
{
    // Dispose of system sounds
    [self unloadPlaylist];
    
    [_playlist release];
    [_sounds release];
    [super dealloc];
}


- (id)init
{
    self = [super init];
    
    if (self)
    {
        // Init
        NSString *path = [[NSBundle mainBundle] pathForResource:@"playlist" ofType:@"plist"];
        NSDictionary *playlist = [NSDictionary dictionaryWithContentsOfFile:path];
        
        _playlist = [[NSMutableDictionary alloc] initWithDictionary:playlist];
        _sounds = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    return self;
}


#pragma mark - Class methods

- (void)loadPlaylist
{
    NSArray *keys = [self.playlist allKeys];
    
    for (NSString *key in keys)
        [self createSystemSoundForKey:key];
}


- (void)unloadPlaylist
{
    NSArray *keys = [self.sounds allKeys];
    
    for (NSString *key in keys)
        [self removeSystemSoundForKey:key];
}


- (SystemSoundID)systemSoundIDForKey:(NSString *)key
{
    NSNumber *sound = [self.sounds objectForKey:key];
    
    if (sound != nil && [sound isKindOfClass:[NSNumber class]])
        return (SystemSoundID)[sound unsignedLongValue];
    
    return NSNotFound;
}


- (void)createSystemSoundForKey:(NSString *)key
{
    // Return if sound ID has been created
    if ([self.sounds objectForKey:key] != nil)
        return;
    
    NSString *filename = [self.playlist objectForKey:key];
    NSString *resource = [filename stringByDeletingPathExtension];
    NSString *type = [[filename componentsSeparatedByString:@"."] lastObject];
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:type];
    
    CFURLRef URL = (CFURLRef)[NSURL fileURLWithPath:path];
    SystemSoundID systemSoundID = NSNotFound;
    AudioServicesCreateSystemSoundID(URL, &systemSoundID);
    
    if (systemSoundID != NSNotFound)
    {
        NSNumber *sound = [NSNumber numberWithUnsignedLong:systemSoundID];
        [self.sounds setObject:sound forKey:key];
    }
}


- (void)removeSystemSoundForKey:(NSString *)key
{
    if ([self systemSoundExistsForKey:key])
    {
        SystemSoundID soundID = [self systemSoundIDForKey:key];
        AudioServicesDisposeSystemSoundID(soundID);
        [self.sounds removeObjectForKey:key];
    }
}


- (void)playSystemSoundForKey:(NSString *)key
{
    if ([self systemSoundExistsForKey:key])
    {
        SystemSoundID soundID = [self systemSoundIDForKey:key];
        AudioServicesPlaySystemSound(soundID);
    }
}


- (BOOL)systemSoundExistsForKey:(NSString *)key
{
    return ([self systemSoundIDForKey:key] != NSNotFound);
}


@end
