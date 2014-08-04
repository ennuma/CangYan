//
//  EventManager.m
//  Ennuma
//
//  Created by Zhaoyang on 14-8-4.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "EventManager.h"

@implementation EventManager
static EventManager* sharedManager;
+(EventManager*)sharedEventManager
{
    if (sharedManager) {
        return sharedManager;
    }
    
    sharedManager = [[self alloc]init];
    return sharedManager;
}
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    sceneDic = [[NSMutableDictionary alloc]init];
    keyformat = @"event for day: %i, time: %i";
    return self;
}
-(void)pushEvent:(CCScene*)eventScene ForDay:(int)day ForTime:(int)time
{
    NSString* key = [NSString stringWithFormat:keyformat,day,time];
    [sceneDic setObject:eventScene forKey:key];
}
-(CCScene*)popEventForDay:(int)day ForTime:(int)time
{
    NSString* key = [NSString stringWithFormat:keyformat,day,time];
    if (![sceneDic.allKeys containsObject:key]) {
        return nil;
    }
    CCScene* ret = [sceneDic objectForKey:key];
    NSAssert([ret isKindOfClass:[CCScene class]], @"popEvent method try to return a none CCScene Object.");
    [sceneDic removeObjectForKey:key];
    return ret;
}
-(bool)hasEventOnDay:(int)day OnTime:(int)time
{
    NSString* key = [NSString stringWithFormat:keyformat,day,time];
    bool ret = false;
    if ([sceneDic.allKeys containsObject:key]) {
        ret = true;
    }
    return ret;
}

@end
