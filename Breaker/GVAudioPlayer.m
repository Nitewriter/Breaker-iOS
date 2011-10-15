//
//  GVAudioPlayer.m
//  Breaker
//
//  Created by Joel Garrett on 10/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GVAudioPlayer.h"

@implementation GVAudioPlayer

@synthesize playlist = _playlist;

- (void)dealloc
{
    // Dispose of system sounds
    NSArray *keys = [self.playlist allKeys];
    
    for (NSString *key in keys)
        [self removeSoundIDForKey:key];
    
    [_playlist release];
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
    }
    
    return self;
}


#pragma mark - Class methods

- (void)createSoundIDForAllKeys
{
    NSArray *keys = [self.playlist allKeys];
    
    for (NSString *key in keys)
        [self createSoundIDForKey:key];
}


- (void)createSoundIDForKey:(NSString *)key
{
    NSString *object = [self.playlist objectForKey:key];
    
    if ([object isKindOfClass:[NSString class]])
    {
        NSString *filename = [object stringByDeletingPathExtension];
        NSString *type = [[object componentsSeparatedByString:@"."] lastObject];
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:type];
        
        CFURLRef URL = (CFURLRef)[NSURL fileURLWithPath:path];
        SystemSoundID soundID = NSNotFound;
        AudioServicesCreateSystemSoundID(URL, &soundID);
        
        if (soundID != NSNotFound)
            [self.playlist setObject:[NSNumber numberWithUnsignedLong:soundID] forKey:key];
    }
}


- (void)removeSoundIDForKey:(NSString *)key
{
    NSNumber *sound = [self.playlist objectForKey:key];
    
    if ([sound isKindOfClass:[NSNumber class]])
    {
        SystemSoundID soundID = (SystemSoundID)[sound unsignedLongValue];
        AudioServicesDisposeSystemSoundID(soundID);
    }
}


- (void)playSoundIDForKey:(NSString *)key
{
    NSNumber *sound = [self.playlist objectForKey:key];
    
    if ([sound isKindOfClass:[NSNumber class]])
    {
        SystemSoundID soundID = (SystemSoundID)[sound unsignedLongValue];
        AudioServicesPlaySystemSound(soundID);
    }
}


- (SystemSoundID)soundIDForKey:(NSString *)key
{
    NSNumber *soundIDNumber = [self.playlist objectForKey:key];
    
    if (soundIDNumber != nil && [soundIDNumber isKindOfClass:[NSNumber class]])
        return (SystemSoundID)[soundIDNumber unsignedLongValue];
    
    return NSNotFound;
}

@end
