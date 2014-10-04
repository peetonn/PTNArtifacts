//
//  PTNStorage.h
//  PTNStorage
//
//  Created by Peter Gusev on 7/24/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PTNAdditions/PTNAdditions.h>

#define PTN_DEFAULT_PARAMS_FILE @"PTNDefaults"

/**
 * Class for storing all necessary parameters and defaults of application between launches
 */
@interface PTNStorage : PTNSingleton
{
    NSUserDefaults *_defaultParams;
    NSString *_storageFile;
}
/////////////////////////////////////////////////////////////////////////
/// @name Properties
/////////////////////////////////////////////////////////////////////////
/**
 * Dictionary of default settings loaded from file
 */
@property (nonatomic, readonly) NSDictionary *defaults;

/////////////////////////////////////////////////////////////////////////
/// @name Instance methods
/////////////////////////////////////////////////////////////////////////
/**
 * Returns shared instance of PTNStorageController
 */
+(PTNStorage*)sharedInstance;
/**
 * Returns shared instance of PTNStorageController initialized with
 * specified defaults file
 */
+(PTNStorage*)sharedInstanceWithDefaultsFile:(NSString*)defaultFile;
/**
 * Dictionary of default settings loaded from file
 */
- (void)registerDefaults;
/**
 * Save current settings to file on disk
 */
- (void)saveParams;
/**
 * Restire default values from file
 */
- (void)resetDefaults;

/**
 * Saves setting
 * @param param Setting value
 * @param key Setting name
 */
- (void)saveParam:(id)param forKey:(NSString*)key;
/**
 * Saves int value
 * @param param Setting value
 * @param key Setting name
 */
- (void)saveInt:(int)param forKey:(NSString*)key;
/**
 * Saves float value
 * @param param Setting value
 * @param key Setting name
 */
- (void)saveFloat:(float)param forKey:(NSString*)key;
/**
 * Saves boolean
 * @param param Setting value
 * @param key Setting name
 */
- (void)saveBool:(bool)param forKey:(NSString*)key;
/**
 * Returns saved setting
 * @param key Name of setting in settings dictionary
 */
- (id)getParamWithName:(NSString*)key;

/**
 * Indicates whether application was ended normally or crahsed
 * It gets checked on storage intialization, if flag is set to NO, PTNStorageAppCrashedNotification gets generated. Otherwise, this flag is set to NO. Upon correct app termination this flag is set to YES.
 * @return YES means application ended normally, NO means application crashed
 */
-(BOOL)wasAppEndedNormally;
/**
 * Sets application end flag when ther was no crash
 */
-(void)setAppEndedNormally:(BOOL)terminationFlag;

@end
