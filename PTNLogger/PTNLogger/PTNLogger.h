//
//  PTNLogger.h
//  IVServer
//
//  Created by Peter Gusev on 5/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#ifndef __ptnlogger_h__
#define __ptnlogger_h__

#import <Foundation/Foundation.h>

#if !defined(PTN_LOGGING)
#undef PTN_LOG_TRACE
#undef PTN_LOG_INFO
#undef PTN_LOG_WARN
#undef PTN_LOG_ERROR
#undef PTN_LOG_DEBUG
#endif

#if defined (PTN_LOG_TRACE)
#define LOG_TRACE(fmt, ...) [PTNLogger logFrom: [NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] withLevel: @"TRACE" withFormat: fmt, ##__VA_ARGS__]
#else
#define LOG_TRACE(fmt, ...)
#endif

#if defined (PTN_LOG_INFO)
#define LOG_INFO(fmt, ...) [PTNLogger logFrom: @"" withLevel: @"INFO" withFormat: fmt, ##__VA_ARGS__]
#else
#define LOG_INFO(fmt, ...) 
#endif

#if defined(PTN_LOG_DEBUG)
#define LOG_DEBUG(fmt, ...) [PTNLogger logFrom: [NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] withLevel: @"DEBUG" withFormat: fmt, ##__VA_ARGS__]
#else
#define LOG_DEBUG(fmt, ...)
#endif

#ifdef PTN_LOG_WARN
#define LOG_WARN(fmt, ...) [PTNLogger logFrom: @"" withLevel: @"WARN " withFormat: fmt, ##__VA_ARGS__]
#else
#define LOG_WARN(fmt, ...) 
#endif

#ifdef PTN_LOG_ERROR
#define LOG_ERROR(fmt, ...) [PTNLogger logFrom: @"" withLevel: @"***ERROR***" withFormat: fmt, ##__VA_ARGS__]
#else
#define LOG_ERROR(fmt, ...)
#endif

/**
 * This class is used for logging events throughout the applications on the console and (optionaly) to the log file. 
 * Events are logged in the following format: 
 *      
 * `"["event_type"]"[code_location]":"event_info`
 *
 * *For example:*
 *  
 *       `[TRACE] -[IVVideoWindowController moviePlayerLoadStateChanged:]: New player state: playthrough`
 *
 * which means trace event in method `moviePlayerLoadStateChanged:` of class `IVVideoWindowController`.
 * 
 * One should note that _code_location_ is available only for TRACE and DEBUG events.
 *
 * Logging events are divided into 5 groups:
 *
 * * Errors - represent errors
 * * Warnings - represent undesirable situations
 * * Info - normal events 
 * * Debug - events used for debugging
 * * Trace - events used for tracing code during development
 *
 * Right after app initialization in `applicationDidFinishLaunching` method of app delegate, the logger should be initialized with calling `logToFile` method. After this, logging can be performed.
 *
 * For each type of event there is a macro, which simplifies calling logger:
 *
 * * `LOG_ERROR(...)`
 * * `LOG_WARN(...)`
 * * `LOG_INFO(...)`
 * * `LOG_DEBUG(...)`
 * * `LOG_TRACE(...)`
 *
 * One should use macroses defined above for logging instead of direct calling logFrom:withLevel:withFormat: method. By using these macroses user can easily enable/disable them by defining/undefining following macroses:
 *
 * * `PTN_LOG_ERROR` - allows error logging
 * * `PTN_LOG_WARN` - allows warnings logging
 * * `PTN_LOG_INFO` - allows informational events logging
 * * `PTN_LOG_DEBUG` - allows debug logging
 * * `PTN_LOG_TRACE` - allows trace logging 
 *  
 * Defining/undefining macro `PTN_LOGGING` enables or disables whole logging in a module or entire project (if defined on project level). Logging for certain .m file (module) can be disabled by simplty using `#undef` directive for necessary log events.
 */
@interface PTNLogger : NSObject
{
    BOOL logToFile;
    NSFileHandle *f;
@public
    NSString *logFile;
}

/**
 * @name Class methods
 */
/**
 * Shared instance of logger
 */
+(PTNLogger*)sharedLogger;
/**
 * Initializes logger to log into file
 * @param aFile File name which is saved in app's documents direcotry and can be accessible trough iTunes (if file sharing enabled for app). In case if this parameter is nil, logging performed only to the console.
 */
+(void)logToFile:(NSString*)aFile;
/**
 * Log formatted string with prefix and additional (code location) information
 * @param location Used for 
 */
+(void)logFrom:(NSString*)location withLevel:(NSString*)lvl withFormat:(NSString*)format,...;

@end

#endif