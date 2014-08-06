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
    if ([sceneDic.allKeys containsObject:key]) {
        NSMutableArray* scenearr = [[sceneDic objectForKey:key]mutableCopy];
        [scenearr addObject:eventScene];
        [sceneDic setObject:scenearr forKey:key];
    }else{
        NSMutableArray* scenearr = [NSMutableArray arrayWithObject:eventScene];
        [sceneDic setObject:scenearr forKey:key];
    }
}
-(CCScene*)popEventForDay:(int)day ForTime:(int)time
{
    NSString* key = [NSString stringWithFormat:keyformat,day,time];
    if (![sceneDic.allKeys containsObject:key]) {
        return nil;
    }
    NSMutableArray* retarr = [[sceneDic objectForKey:key]mutableCopy];
    NSAssert([retarr isKindOfClass:[NSMutableArray class]], @"object in sceneDic is not nsmutable array.");
    CCScene* ret = [retarr objectAtIndex:0];
    NSAssert([ret isKindOfClass:[CCScene class]], @"popEvent method try to return a none CCScene Object.");
    [retarr removeObjectAtIndex:0];
    if ([retarr count]==0) {
        [sceneDic removeObjectForKey:key];
    }else{
        [sceneDic setObject:retarr forKey:key];
    }
    //CCLOG(@"delete event");
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
