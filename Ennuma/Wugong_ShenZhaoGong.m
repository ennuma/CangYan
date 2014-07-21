//
//  Wugong_ShenZhaoGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-21.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【神照功】能力解说：
 加力威力：800--900
 护体威力：950--1100
 一般特效：
 败退时几率复活（第一次几率为100%，之后几率为5%）//TODO
 生命内力体力增加最大值的一半
 当前集气增加500 消除全异常状态
 主功体特效：
 败退时几率复活（第一次几率为100%，之后几率为10%）//TODO
 生命内力体力变为最大值
 当前集气变为MAX 消除全异常状态
 主功体加成武功：
 『鬼头刀法』必定连击 25%几率三连击
 『雪山剑法』功体加力时追加杀集气200点

 **/
#import "Wugong_ShenZhaoGong.h"


@implementation Wugong_ShenZhaoGong
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 850;
    _neigongJiaLi = 1025;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"神照功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}
-(int)effectNeiGongJiaLiSpdHurt:(int)spdhurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"雪山剑法"]) {
            spdhurt += 200;
        }
    }
    
    return spdhurt;
}
-(int)effectLifeHurtAfterCalculate:(int)hurt WithAtk:(NSObject *)atk WithWugong:(Wugong *)m_wugong
{
    NSAssert([atk isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)atk;

    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"鬼头刀法"]) {
            if (CCRANDOM_0_1()*100<25) {
                hurt *= 1.7; //fake effect here
            }
        }
    }
    return hurt;
}


@end
