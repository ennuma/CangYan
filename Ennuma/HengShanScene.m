//
//  HengShanScene.m
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "HengShanScene.h"
#import "HengShanPai.h"
#import "BattleField.h"
@implementation HengShanScene

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //CCSprite* sp = [self getChildByName:@"sp" recursively:NO];
    CGPoint pos = [touch locationInNode:self];
    if (CGRectContainsPoint([sp boundingBox], pos)) {
        HengShanPai* huashan = menpai;
        Invader* invader = [[Invader alloc]init];
        invader.strength=20;
        invader.jiqispeed = 40;
        
        
        //Battle
        BattleField* sc = [BattleField scene];
        //[sc addEntity:invader ForTeam:@"red"];
        
        Invader* invader2 = [[Invader alloc]init];
        invader2.strength=20;
        invader2.jiqispeed = 80;
        //[sc addEntity:invader2 ForTeam:@"blue"];
        
        [[CCDirector sharedDirector] pushScene: sc];
        
    }else{
        [[[CCDirector sharedDirector]runningScene] removeChildByName:@"menpai" cleanup:YES];
    }
}



-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"HUASHAN");
    CCLOG(@"%@",menpai);
}

static CCLabelTTF* text;

-(void)initElements
{
    //CCLOG(@"%@",[text class]);
    //NSAssert([menpai isKindOfClass:[CCNode class]], @"huashan scene not belong to huashanpai");
    sp = [CCSprite spriteWithImageNamed:@"Hero.png"];
    [self addChild:sp];
    sp.position = CGPointMake([sp contentSize].width/2, [sp contentSize].height/2);
    
    HengShanPai* huashan = menpai;
    NSString *pop = [NSString stringWithFormat:@"%i", huashan.population];
    text = [CCLabelTTF labelWithString:pop fontName:@"Chalkduster" fontSize:36.0f];
    [self addChild:text];
    text.position = CGPointMake([self contentSize].width/2, [self contentSize].height/2);
}

-(void)update:(CCTime)delta
{
    HengShanPai* huashan = menpai;
    NSString *pop = [NSString stringWithFormat:@"%i", huashan.population];
    text.string = pop;
}


@end
