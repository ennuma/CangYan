//
//  Wugong_TaiShanShiBaPan.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Wugong_TaiShanShiBaPan.h"


@implementation Wugong_TaiShanShiBaPan
-(void)initPoisionAndBleedAndFengXue
{
    _fengXueIndex=3;
    _bleedIndex=6;
    _poision=0;
}
-(void)initMultiHitAndCriticalHit
{
    _multiHitBuff = 10;
    _criticalHitBuff = 30;
}
-(void)initRangeAndRangeType
{
    _range=3;
    _rangeType=2;
}
-(void)initWugongDamageForEachLevelAndQigongValue
{
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:1];
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:2];
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:3];
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:4];
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:5];
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:6];
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:7];
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:8];
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:9];
    [_damage insertObject:[NSNumber numberWithInt:625]  atIndex:10];
    
    _neigongJiaLi=0;
    _neigongHuTi=0;
}
-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"泰山十八盘";
    _acumeCost = 35/5;
    _level = 1;
}
-(bool)isJianFa
{
    return true;
}

-(bool)isWaiGong
{
    return true;
}
//atk 10
@end
