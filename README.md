PTNArtifacts
============

Collection of re-usable artifacts for iOS development

What is PTNArtifacts?
PTNArtifacts is a static library for iOS applications which consolidates useful app-independent classes and categories. 
PTNArtifacts is build out of 4 stand-alone libraries:
  - PTNLogger
  - PTNAdditions
  - PTNStorage
  - PTNControls
  
PTNLogger
=========
It is a simple thread-safe logging library, wich support easy logging at 5 different levels (trace, debug, info, warning, error) and provides logging onto a console as well as into log file, which can be accessed through iTunes (via "Shared Documents" functionality). Logging can be flexibly enabled/disabled for specific modules using preprocessor macros. Here is an example of logging on informational level:

PTN_LOG_INFO(@"The app is launched at %@",[NSDate date]);

PTNAdditions
============

PTNStorage
==========

PTNControls
==========
