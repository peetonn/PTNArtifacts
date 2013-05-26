PTNArtifacts
============
PTNArtifacts is a static library for iOS applications which consolidates useful app-independent classes and categories. 
PTNArtifacts is build out of 4 stand-alone libraries:

  - PTNLogger
  - PTNAdditions
  - PTNStorage
  - PTNControls

Library is constantly evolving during my professional experience.
  
PTNLogger
---------
It is a simple thread-safe logging library, wich supports easy logging at 5 different levels (trace, debug, info, warning, error) and provides logging onto a console as well as into log file, which can be accessed through iTunes (via "Shared Documents" functionality). Logging can be flexibly enabled/disabled for specific pieces of code using preprocessor macros. Here is an example of logging on informational level:

    LOG_INFO(@"The app is launched at %@",[NSDate date]);

PTNAdditions
------------
Contains useful categories for different classes such as NSObject, NSString, NSTimer, etc.

PTNStorage
----------
PTNStorage is a singleton class for customizable and easy access to NSUserDefaults. App settings are stored in .plist file which can be modified while developing application. Here is an example of simple settings file which contains two settings - "Launching date-time" for tracking last launch time and "First launch" which is set to "false" on first launch of an app.

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>Launching date-time</key>
	    <date>1970-01-01T00:00:17Z</date>
	    <key>First launch</key>
	    <true/>
    </dict>
    </plist>
    
Upon initialization, this settings file is loaded by PTNStorage class and its settings registered in NSUserDefaults of application. On later launches, these settings are retrieved from NSUserDefaults (or from file, is specified). 

Though PTNStorage can be used as is, it is recommended to subclass it for more convenient usage. Subclasses are recommended to implement properties for each setting in a settings file. Here is an example subclass for settings file presented above:

    @interface SPStorage : PTNStorage

    +(SPStorage*)sharedStorageController;
    @property (nonatomic) NSDate *launchDateTime;
    @property (nonatomic) BOOL isFirstLaunch;

    @end
    
    @implementation SPStorage

    +(SPStorage*)sharedStorageController
    {
        if (![PTNStorage isSharedStorageControllerInitialized])
            [PTNStorage setSharedStorageController:[[SPStorage alloc] initWithStorageFile:@"Defaults"]];
    
        return (SPStorage*)[PTNStorage sharedStorageController];
    }

    -(BOOL)isFirstLaunch
    {
        return [[self getParamWithName:@"First launch"] boolValue];
    }
    -(void)setIsFirstLaunch:(BOOL)isFirstLaunch
    {
        [self saveBool:isFirstLaunch forKey:@"First launch"];
    }
    -(NSDate*)launchDateTime
    {
        return [self getParamWithName:@"Launching date-time"];
    }
    -(void)setLaunchDateTime:(NSDate *)launchDateTime
    {
        [self saveParam:launchDateTime forKey:@"Launching date-time"];
    }

    @end
    
In case of subclassing PTNStorage one should note that overriding of `sharedStorageController` is **necessary**.

**NOTE: This library is dependent on PTNAdditions library**

PTNControls
-----------
PTNControls contains few useful UI controls such as:

- alert view with input field
- expandable label
- simple cover view

License
=======
This library is distributed under BSD license. Enjoy using it and contribute!