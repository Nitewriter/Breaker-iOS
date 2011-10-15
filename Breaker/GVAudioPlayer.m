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


- (id)initWithPlaylist:(NSDictionary *)playlist;
{
    self = [super init];
    
    if (self)
    {
        // Init
        _playlist = [[NSMutableDictionary alloc] initWithCapacity:0];         
        _sounds = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        // Load bundled playlist if available
        if (playlist == nil)
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"playlist" ofType:@"plist"];
            playlist = [NSDictionary dictionaryWithContentsOfFile:path];
        }
        
        // Populate playlist with available items
        if (playlist != nil)
            [self.playlist addEntriesFromDictionary:playlist];
    }
    
    return self;
}


- (id)initWithPlaylist:(NSDictionary *)playlist loadImmediately:(BOOL)load
{
    self = [self initWithPlaylist:playlist];
    
    if (self)
    {
        // Init
        
        // Load immediately if playlist has items
        if (load && [[self.playlist allKeys] count] > 0)
            [self loadPlaylist];
    }
    
    return self;
}


#pragma mark - Class methods

- (NSInteger)numberOfPlaylistReferences
{
    return [[self.playlist allKeys] count];
}


- (NSInteger)numberOfSounds
{
    return [[self.sounds allKeys] count];
}


- (BOOL)isPlaylistLoaded
{
    return (self.numberOfPlaylistReferences == self.numberOfSounds);
}


- (NSArray *)unloadedKeys
{
    NSMutableArray *allKeys = [NSMutableArray arrayWithCapacity:0];
    [allKeys addObjectsFromArray:[self.playlist allKeys]];
    [allKeys removeObjectsInArray:[self.sounds allKeys]];
    
    return allKeys;
}


- (void)loadPlaylist
{
    if (self.playlistLoaded)
        return;
    
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


- (BOOL)createSystemSoundWithName:(NSString *)filename forKey:(NSString *)key
{
    // Return no if nil values received
    if (filename == nil || key == nil)
        return NO;
    
    // Check for existence of audio reference in the playlist
    if ([self.playlist objectForKey:key] != nil)
    {
        // Check filename for match
        if ([[self.playlist objectForKey:key] isEqualToString:filename])
            return [self createSystemSoundForKey:key];
        
        // Unload current audio resource
        [self removeSystemSoundForKey:key];
    }
    
    // Set/Replace the audio reference in the playlist
    [self.playlist setObject:filename forKey:key];
    return [self createSystemSoundForKey:key];
}


- (BOOL)createSystemSoundForKey:(NSString *)key
{
    // Return yes immediately if sound ID has been created
    if ([self.sounds objectForKey:key] != nil)
        return YES;
    
    NSString *filename = [self.playlist objectForKey:key];
    
    // Return no if key does not exist in the playlist
    if (filename == nil)
        return NO;
    
    NSString *resource = [filename stringByDeletingPathExtension];
    NSString *type = [[filename componentsSeparatedByString:@"."] lastObject];
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:type];
    
    // Return no if the audio resource could not be located
    if (path == nil)
        return NO;
    
    CFURLRef URL = (CFURLRef)[NSURL fileURLWithPath:path];
    SystemSoundID systemSoundID = NSNotFound;
    AudioServicesCreateSystemSoundID(URL, &systemSoundID);
    
    // Store system sound ID if created successfully
    if (systemSoundID != NSNotFound)
    {
        NSNumber *sound = [NSNumber numberWithUnsignedLong:systemSoundID];
        [self.sounds setObject:sound forKey:key];
        return YES;
    }
    
    return NO;
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
