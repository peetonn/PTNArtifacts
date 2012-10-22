//
//  PTNLogger.m
//  IVServer
//
//  Created by Peter Gusev on 5/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "PTNLogger.h"


static PTNLogger *sharedLogger;

@interface PTNLogger ()
-(void)log:(NSString*)str;
-(void)setupLogFile:(NSString*)file;
@end

@implementation PTNLogger

+(PTNLogger*)sharedLogger
{
    if (!sharedLogger)
        sharedLogger = [[PTNLogger alloc] init];
    return sharedLogger;
}

+(void)logToFile:(NSString*)aFile
{
    if (aFile && [aFile length] > 0)
        [[PTNLogger sharedLogger] setupLogFile:aFile];
}

+(void)logFrom:(NSString*)location withLevel:(NSString*)lvl withFormat:(NSString*)format,...
{
    va_list args;
    
    va_start(args, format);
    NSString *substr = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSString *str = [NSString stringWithFormat:@"[%@] %@: %@",lvl, location,substr];
    
    [[PTNLogger sharedLogger] log:str];
}

+(NSString*)getLogFile:(NSString*)file
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
    
    NSString *log = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:NULL];
    return log;
}

-(void)setupLogFile:(NSString *)file
{
    logToFile = YES;
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    logFile = [documentsDirectory stringByAppendingPathComponent:file];
    [@"" writeToFile:logFile atomically:NO encoding:NSUTF8StringEncoding error:NULL];
   // f = [NSFileHandle fileHandleForUpdatingAtPath:logFile];
    //[f seekToEndOfFile];
}

-(void)log:(NSString*)str
{
    NSLog(@"%@",str);

    if (logToFile)
    {
        @synchronized(logFile)
        {     
            NSString *fstr = [NSString stringWithFormat:@"%@ %@\n",[NSDate date],str];
            f = [NSFileHandle fileHandleForUpdatingAtPath:logFile];
            [f seekToEndOfFile];
            [f writeData:[fstr dataUsingEncoding:NSUTF8StringEncoding]];
//            [f synchronizeFile];
            [f closeFile];
        }
    }
}
         

@end
