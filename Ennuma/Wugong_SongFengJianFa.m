//
//  Wugong_SongFengJianFa.m
//  Ennuma
//
//  Created by ennuma on 14-7-19.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Wugong_SongFengJianFa.h"


@implementation Wugong_SongFengJianFa
-(void)initPoisionAndBleedAndFengXue
{
    _fengXueIndex=0;
    _bleedIndex=5;
    _poision = 0;
}
-(void)initMultiHitAndCriticalHit
{
    _multiHitBuff = 30;
    _criticalHitBuff = 0;
}
-(void)initRangeAndRangeType
{
    _range=3;
    _rangeType=2;
}
-(void)initWugongDamageForEachLevelAndQigongValue
{
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:1];
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:2];
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:3];
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:4];
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:5];
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:6];
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:7];
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:8];
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:9];
    [_damage insertObject:[NSNumber numberWithInt:375]  atIndex:10];
    
    _neigongJiaLi=0;
    _neigongHuTi=0;
}
-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"松风剑法";
    _acumeCost = 7;
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

//TODO atk +10 agile +10 after learning
@end
