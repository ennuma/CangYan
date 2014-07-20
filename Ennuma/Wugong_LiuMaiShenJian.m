//
//  Wugong_LiuMaiShenJian.m
//  Ennuma
//
//  Created by ennuma on 14-7-19.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Wugong_LiuMaiShenJian.h"


@implementation Wugong_LiuMaiShenJian

-(void)initPoisionAndBleedAndFengXue
{
    _fengXueIndex=10;
    _bleedIndex=10;
    _poision=0;
}
-(void)initMultiHitAndCriticalHit
{
    _multiHitBuff = 0;
    _criticalHitBuff = 0;
}
-(void)initRangeAndRangeType
{
    _range=3;
    _rangeType=2;
}
-(void)initWugongDamageForEachLevelAndQigongValue
{
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:1];
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:2];
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:3];
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:4];
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:5];
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:6];
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:7];
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:8];
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:9];
    [_damage insertObject:[NSNumber numberWithInt:1875]  atIndex:10];
    
    _neigongJiaLi=0;
    _neigongHuTi=0;
}
-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"六脉神剑";
    _acumeCost = 1267/5;
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

//TODO atk +20
@end

