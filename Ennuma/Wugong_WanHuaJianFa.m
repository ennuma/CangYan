//
//  Wugong_WanHuaJianFa.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Wugong_WanHuaJianFa.h"


@implementation Wugong_WanHuaJianFa
-(void)initPoisionAndBleedAndFengXue
{
    _fengXueIndex=1;
    _bleedIndex=6;
    _poision=0;
}
-(void)initMultiHitAndCriticalHit
{
    _multiHitBuff = 15;
    _criticalHitBuff = 15;
}
-(void)initRangeAndRangeType
{
    _range=3;
    _rangeType=2;
}
-(void)initWugongDamageForEachLevelAndQigongValue
{
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:1];
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:2];
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:3];
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:4];
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:5];
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:6];
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:7];
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:8];
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:9];
    [_damage insertObject:[NSNumber numberWithInt:600]  atIndex:10];
    
    _neigongJiaLi=0;
    _neigongHuTi=0;
}
-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"万花剑法";
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
//atk 10 def 10
@end
