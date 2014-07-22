//
//  Wugong_TaiYueSanQingFeng.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Wugong_TaiYueSanQingFeng.h"


@implementation Wugong_TaiYueSanQingFeng
-(void)initPoisionAndBleedAndFengXue
{
    _fengXueIndex=2;
    _bleedIndex=6;
    _poision=0;
}
-(void)initMultiHitAndCriticalHit
{
    _multiHitBuff = 40;
    _criticalHitBuff = 0;
}
-(void)initRangeAndRangeType
{
    _range=3;
    _rangeType=2;
}
-(void)initWugongDamageForEachLevelAndQigongValue
{
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:1];
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:2];
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:3];
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:4];
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:5];
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:6];
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:7];
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:8];
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:9];
    [_damage insertObject:[NSNumber numberWithInt:500]  atIndex:10];
    
    _neigongJiaLi=0;
    _neigongHuTi=0;
}
-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"太岳三青峰";
    _acumeCost = 70/5;
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
