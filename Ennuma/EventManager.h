//
//  EventManager.h
//  Ennuma
//
//  Created by Zhaoyang on 14-8-4.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "hdEvent.h"
@interface EventManager : CCNode
{
    NSMutableDictionary* sceneDic;
    NSString* keyformat;
}
+(EventManager*)sharedEventManager;
-(bool)hasEventOnDay:(int)day OnTime:(int)time;
-(void)pushEvent:(hdEvent*)eventScene ForDay:(int)day ForTime:(int)time;
-(hdEvent*)popEventForDay:(int)day ForTime:(int)time;
@end
