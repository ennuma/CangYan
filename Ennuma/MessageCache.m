//
//  MessageCache.m
//  Ennuma
//
//  Created by ennuma on 14-6-27.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "MessageCache.h"


@implementation MessageCache
@synthesize messages = _messages;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _messages = [[NSMutableArray alloc]init];
    currentIndex = 0;
    
    return self;
}

-(void)dealloc
{
    _messages = nil;
}

+(MessageCache*) messageCacheWithMessages:(int)numberOfMessages
{
    MessageCache* m_cache = [[self alloc]init];
    for (int i = 0; i< numberOfMessages; i++) {
        CCSprite* message = [CCSprite spriteWithImageNamed:@"MachineGunTurret.png"];
        message.visible = NO;
        [m_cache.messages addObject:message];
        [m_cache addChild:message];
    }
    
    return m_cache;
}

-(CCSprite*)nextMessage
{
    CCSprite* currentMessage = [_messages objectAtIndex:currentIndex];
    currentIndex+=1;
    if (currentIndex == [_messages count]) {
        currentIndex = 0;
    }
    return currentMessage;
}

@end
