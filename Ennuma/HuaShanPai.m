//
//  HuaShanPai.m
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "HuaShanPai.h"
#import "HuaShanScene.h"

@implementation HuaShanPai

-(void)initMenPaiScene
{
    _menPaiScene = [HuaShanScene sceneWithMenPai:self];
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




@end
