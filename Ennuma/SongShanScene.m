//
//  SongShanScene.m
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "SongShanScene.h"
#import "SongShanPai.h"

@implementation SongShanScene

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"HUASHAN");
    CCLOG(@"%@",menpai);
}

static CCLabelTTF* text;

-(void)initElements
{

    sp = [CCSprite spriteWithImageNamed:@"Hero.png"];
    [self addChild:sp];
    sp.position = CGPointMake([sp contentSize].width/2, [sp contentSize].height/2);
    
    SongShanPai* huashan = menpai;
    NSString *pop = [NSString stringWithFormat:@"%i", huashan.population];
    text = [CCLabelTTF labelWithString:pop fontName:@"Chalkduster" fontSize:36.0f];
    [self addChild:text];
    text.position = CGPointMake([self contentSize].width/2, [self contentSize].height/2);
}

-(void)update:(CCTime)delta
{
    SongShanPai* huashan = menpai;
    NSString *pop = [NSString stringWithFormat:@"%i", huashan.population];
    text.string = pop;
}


@end
