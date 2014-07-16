//
//  MenPaiScene.m
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "MenPaiScene.h"
#import "MenPai.h"

@implementation MenPaiScene
@synthesize isControlByPlayer = _isControlByPlayer;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setUserInteractionEnabled:YES];
    //2d projection not important
    [[CCDirector sharedDirector]setProjection: CCDirectorProjection2D];
    //
    CCSprite* bg = [CCSprite spriteWithImageNamed:@"bg_menpai.png"];
    [self addChild:bg];
    bg.position = CGPointMake([bg contentSize].width/2, [bg contentSize].height/2);
    
    return self;
}

+(MenPaiScene*) sceneWithMenPai:(CCNode *)parent
{
    MenPaiScene* ret = [[self alloc]init];
    [ret initElements];
    [ret setMenPai:parent];
    [ret schedule:@selector(updateIsControlByPlayer) interval:1];
    return ret;
}

-(CCSprite*)getsp
{
    return sp;
}

-(void)updateIsControlByPlayer
{
    _isControlByPlayer = ((MenPai*)menpai).controlByPlayer;
    sp.visible = _isControlByPlayer;
}

-(void)setMenPai:(CCNode*)parent
{
    menpai = parent;
}

-(void)initElements
{
    sp = [CCSprite spriteWithImageNamed:@"Hero.png"];
    [self addChild:sp z:0 name:@"sp"];
    sp.position = CGPointMake([sp contentSize].width/2, [sp contentSize].height/2);
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint pos = [touch locationInNode:self];
    if (CGRectContainsPoint([sp boundingBox], pos)) {
        count += 1;
    }else{
        [[[CCDirector sharedDirector]runningScene] removeChildByName:@"menpai" cleanup:NO];
    }
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"%@",menpai);
}

@end
