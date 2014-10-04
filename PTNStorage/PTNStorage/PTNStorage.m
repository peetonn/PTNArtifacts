//
//  ivStorageController.m
//  ivClient
//
//  Created by peetonn on 13/07/2011.
//  Copyright 2011 peetonn inc. All rights reserved.
//

#import "PTNStorage.h"
#import "PTNAdditions/PTNAdditions.h"

#define PTN_STORAGE_PLISTKEY_FINISHED_NORMALLY @"Did finished normally"

static PTNStorage *sharedStorage = nil;

@interface PTNStorage ()

@end

@implementation PTNStorage

#pragma mark - properties
-(NSDictionary*)defaults
{
    NSString *fname = (_storageFile)?_storageFile:PTN_DEFAULT_PARAMS_FILE;
    NSString *pathForPlistFile = [[NSBundle bundleForClass:[self class]] pathForResource:fname ofType:@"plist"];
    NSDictionary *params = [NSDictionary dictionaryWithContentsOfFile:pathForPlistFile];
    return params;
}

#pragma mark - initialization and memory management
// prohibit explicit initialization
- (id)init
{
    return nil;
}

- (id)initWithStorageFile:(NSString *)fname
{
    if ((self = [super init]))
    {
        if (fname)
            _storageFile = [fname copy];
        
        _defaultParams = [NSUserDefaults standardUserDefaults];
        [self registerDefaults];    
    }
    return self;
}

#pragma mark - public methods
+(PTNSingleton *)createInstance
{
    return [[PTNStorage alloc] init];
}

+(PTNStorage *)sharedInstance
{
    return (PTNStorage*)[super sharedInstance];
}

+(PTNStorage *)sharedInstanceWithDefaultsFile:(NSString *)defaultFile
{
    [self sharedInstance]->_storageFile = [defaultFile copy];
    [[self sharedInstance] registerDefaults];
    
    return [self sharedInstance];
}

// register application default parameters - saved in PTN_DEFAULT_PARAMS_FILE file
-(void)registerDefaults
{    
    NSDictionary *params = self.defaults;
    
    for (NSString *key in [params allKeys]){
        id parameter = [params objectForKey:key];
        NSDictionary *paramDictionary = [NSDictionary dictionaryWithObject:parameter 
                                                                    forKey:key];
        [_defaultParams registerDefaults:paramDictionary];
    } // for
}

// save plist data dictionary to defaults file
-(void)saveParams
{
    [_defaultParams synchronize];
}

// clear parameters to defaults
-(void)resetDefaults
{
    NSDictionary *params = self.defaults;
    
    for (NSString *key in [params allKeys])
        [_defaultParams setObject:[params objectForKey:key] forKey:key];
    
    [self saveParams];
}

- (id)getParamWithName:(NSString*)key
{
    return [_defaultParams objectForKey:key];
}

-(void)saveParam:(id)param forKey:(NSString *)key
{
    [_defaultParams setObject:param forKey:key];
    [self saveParams];
}

- (void)saveInt:(int)param forKey:(NSString*)key
{
    [_defaultParams setInteger:param forKey:key];
    [self saveParams];
}

- (void)saveFloat:(float)param forKey:(NSString*)key
{
    [_defaultParams setFloat:param forKey:key];
    [self saveParams];
}

- (void)saveBool:(bool)param forKey:(NSString*)key
{
    [_defaultParams setBool:param forKey:key];
    [self saveParams];
}

-(BOOL)wasAppEndedNormally
{
    return [[self getParamWithName:PTN_STORAGE_PLISTKEY_FINISHED_NORMALLY] intValue];
}
-(void)setAppEndedNormally:(BOOL)terminationFlag
{
    [self saveBool:terminationFlag forKey:PTN_STORAGE_PLISTKEY_FINISHED_NORMALLY];
}

#pragma mark - private methods

@end
