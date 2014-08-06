//
//  Jisi.m
//  Ennuma
//
//  Created by Zhaoyang on 14-8-5.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "Jisi.h"
#import "EventManager.h"
#import "IntroScene.h"
#import "EventJisi.h"
#import "hdEvent.h"
@implementation Jisi
static Jisi* sharedJisi;
+(Jisi*)sharedJiSi
{
    if (sharedJisi) {
        return sharedJisi;
    }
    
    sharedJisi = [Jisi node];
    return sharedJisi;
}
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    CCButton* confirm = [CCButton buttonWithTitle:@"确定"];
    confirm.position = ccp(self.contentSize.width/2-confirm.contentSize.width/2,self.contentSize.height/2-30);
    [self addChild:confirm];
    [confirm setTarget:self selector:@selector(pressButton:)];

    
    return self;
}

-(void)pressButton:(id)button
{
    //insertEvent
    int day = [IntroScene sharedScene].m_day;
    int time = [IntroScene sharedScene].m_time;
    
    hdEvent* event = [EventJisi node];
    [[EventManager sharedEventManager]pushEvent:event ForDay:day ForTime:(time+1)];
    //[[EventManager sharedEventManager]pushEvent:event ForDay:day ForTime:(time+1)];
    CCLOG(@"exit jisi");
    [[CCDirector sharedDirector]popScene];
}

@end
