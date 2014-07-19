//
//  Wugong_LuoHanFuMoGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-19.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Wugong_LuoHanFuMoGong.h"


@implementation Wugong_LuoHanFuMoGong

-(void)initPoisionAndBleed
{
    
}
-(void)initRangeAndRangeType
{
    
}
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 875;
    _neigongJiaLi = 900;
}
-(void)initMultiHitAndCriticalHit
{
    
}
-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"罗汉伏魔功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}

/**
 一般特效：
 行动后回复损失生命值的10%
 主功体特效：
 行动后回复损失生命值的20%
 流血恢复速度每时序增加1
 主功体加成武功：
 『罗汉拳』功体加力时追加伤害50
 『须弥山神掌』功体加力时伤害提升20%
 **/

@end
