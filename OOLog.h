//
//  OOLog.h
//  OOLog
//
//  Created by BruceZCQ on 14-3-13.
//  Copyright (c) 2014年 OpeningO,Inc (http://openingo.github.io/). All rights reserved.
//

#ifndef OOLog_OOLog_h
#define OOLog_OOLog_h

enum OOLogLevel {
    UNKOWNLEVEL = -1,
    ERRORLEVEL = 1,
    ABORTLEVEL,
    WARNINGLEVEL
};

extern void openOOLog(const char *path);
extern void closeOOLog();
extern void ooLog(int level,const char *func,const int line ,char *format, ...);
#endif
