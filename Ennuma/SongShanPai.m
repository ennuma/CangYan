//
//  SongShanPai.m
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "SongShanPai.h"
#import "SongShanScene.h"

@implementation SongShanPai

-(void)initMenPaiScene
{
    _menPaiScene = [SongShanScene sceneWithMenPai:self];
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
        [self invade];
    }
    
}

-(void)invade
{
    for (MenPai* enemy in _neighbours) {
        //enemy.population-=5;
    }
}

@end
