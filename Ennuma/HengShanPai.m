//
//  HengShanPai.m
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "HengShanPai.h"
#import "HengShanScene.h"

@implementation HengShanPai


-(void)initMenPaiScene
{
    _menPaiScene = [HengShanScene sceneWithMenPai:self];
}
-(void)initMenPaiData
{
    _population = 100;
    growSpeed  = 10;
}
static float etime;
-(void)update:(CCTime)delta
{
    etime+=delta;
    if (etime>1) {
        etime = 0;
        _population+=growSpeed;
    }
    
}

-(void)invadeMenPai:(MenPai*)menpai WithInvader:()invader
{
    
}

@end
