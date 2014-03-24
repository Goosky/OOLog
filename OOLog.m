//
//  OOLog.c
//  OOLog
//
//  Created by BruceZCQ on 14-3-13.
//  Copyright (c) 2014年 OpeningO,Inc (http://openingo.github.io/). All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include "OOLog.h"

enum LogPromptType {
    START = 1,
    END = 2
    };

FILE *oolog = NULL;

void ooLogGoing(enum LogPromptType type)
{
    if (type == START) {
        printf("\n============ START ==================\n");
    }else{
        printf("\n============ END ==================\n");
    }
}

extern void openOOLog(const char *path)
{
    if (path == NULL) {
        printf("[FAIL] log path empty!");
        return;
    }
    ooLogGoing(START);
    oolog = fopen(path, "ab+");
}

extern void closeOOLog()
{
    if (ooLog != NULL) {
        fclose(oolog);
        oolog = NULL;
        ooLogGoing(END);
    }
}

extern void ooLog(int level,const char *func,const int line ,char *format, ...)
{
    if(oolog == NULL){
		return;
    }
    
	if(level > WARNINGLEVEL || level < UNKOWNLEVEL){
		return;
    }
    va_list arg;
	int	len;
    int spacer;
    
	static char format_buffer[10240];
	static char buffer[10240];
    
	memset(format_buffer, 0, 10240);
	memset(buffer, 0, 10240);
    
    //format data
    spacer = sprintf(format_buffer, "[%s %s]--Func:%s--Line:%d => ",__DATE__,__TIME__,func,line),
    snprintf(format_buffer+spacer, 10240-spacer, ": %s",format);
	
    va_start(arg, format);
	vsnprintf(buffer, 10240, format_buffer, arg);
	va_end (arg);
    
	len = strlen(buffer);
    
	sprintf(buffer + len ,"\r\n");
    
	len = strlen(buffer);
    
	fwrite(buffer, 1, len, oolog);
	fflush(oolog);
}

