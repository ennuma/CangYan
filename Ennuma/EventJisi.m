//
//  EventJisi.m
//  Ennuma
//
//  Created by Zhaoyang on 14-8-5.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "EventJisi.h"

@implementation EventJisi
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    //[self initLayout];
    return self;
}
-(void)onEnter
{
    CCLOG(@"enter jisi event");
    [self initLayout];
    [super onEnter];
}
-(void)initLayout
{
    CCButton* confirm = [CCButton buttonWithTitle:@"确定"];
    confirm.position = ccp(self.contentSize.width/2-confirm.contentSize.width/2,self.contentSize.height/2-30);
    [self addChild:confirm];
    [confirm setTarget:self selector:@selector(pressButton:)];
}
-(void)pressButton:(id)button
{
    //insertEvent
    CCLOG(@"exit jisi event");
    [[CCDirector sharedDirector]popScene];
}
-(NSString*)getIntroduction
{
    return [NSString stringWithFormat:@"祭祀event！"];
}

@end
