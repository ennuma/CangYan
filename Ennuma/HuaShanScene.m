//
//  HuaShanScene.m
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "HuaShanScene.h"
#import "HuaShanPai.h"

@implementation HuaShanScene

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //CCSprite* sp = [self getChildByName:@"sp" recursively:NO];
    CGPoint pos = [touch locationInNode:self];
    if (CGRectContainsPoint([sp boundingBox], pos)) {
        HuaShanPai* huashan = menpai;
        Invader* invader = [[Invader alloc]init];
        invader.strength=20;
        [huashan scheduleInvader:invader InvadeMenPai:[huashan.neighbours objectAtIndex:0]];
    }else{
        [[[CCDirector sharedDirector]runningScene] removeChildByName:@"menpai" cleanup:YES];
    }
}


-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //CCLOG(@"HUASHAN");
    //CCLOG(@"%@",menpai);
}

static CCLabelTTF* text;

-(void)initElements
{
    //CCLOG(@"%@",[text class]);
    //NSAssert([menpai isKindOfClass:[CCNode class]], @"huashan scene not belong to huashanpai");
    sp = [CCSprite spriteWithImageNamed:@"Hero.png"];
    [self addChild:sp];
    sp.position = CGPointMake([sp contentSize].width/2, [sp contentSize].height/2);
    
    HuaShanPai* huashan = menpai;
    NSString *pop = [NSString stringWithFormat:@"%i", huashan.population];
    text = [CCLabelTTF labelWithString:pop fontName:@"Chalkduster" fontSize:36.0f];
    [self addChild:text];
    text.position = CGPointMake([self contentSize].width/2, [self contentSize].height/2);
}

-(void)update:(CCTime)delta
{
    HuaShanPai* huashan = menpai;
    NSString *pop = [NSString stringWithFormat:@"%i", huashan.population];
    text.string = pop;
}


@end
