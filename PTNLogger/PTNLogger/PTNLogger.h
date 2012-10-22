//
//  PTNLogger.h
//  IVServer
//
//  Created by Peter Gusev on 5/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//#ifndef PTN_LOGGING
//#	define PTN_LOGGING		0
//#endif
//
//#ifndef PTN_LOG_TRACE
//#	define PTN_LOG_TRACE    0
//#endif
//#ifndef PTN_LOG_INFO
//#	define PTN_LOG_INFO     1
//#endif
//#ifndef PTN_LOG_WARN
//#	define PTN_LOG_WARN     1
//#endif
//#ifndef PTN_LOG_ERROR
//#	define PTN_LOG_ERROR    1
//#endif
//#ifndef PTN_LOG_DEBUG
//#	define PTN_LOG_DEBUG    1
//#endif

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

@interface PTNLogger : NSObject
{
    BOOL logToFile;
    NSFileHandle *f;
@public
    NSString *logFile;
}

+(PTNLogger*)sharedLogger;
+(void)logToFile:(NSString*)aFile;
+(void)logFrom:(NSString*)location withLevel:(NSString*)lvl withFormat:(NSString*)format,...;
+(NSString*)getLogFile:(NSString*)file;

@end
