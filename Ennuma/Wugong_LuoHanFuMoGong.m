//
//  Wugong_LuoHanFuMoGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-19.
//  Copyright 2014年 ennuma. All rights reserved.
//
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
#import "Wugong_LuoHanFuMoGong.h"


@implementation Wugong_LuoHanFuMoGong


-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 875;
    _neigongJiaLi = 900;
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

-(void)effectAfterAction:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    int incHealth = (inv.maxhealth-inv.health)*0.1;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        incHealth *= 2;
    }

    inv.health+=incHealth;
}

-(void)effectInUpdateJiQi:(NSObject*)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        inv.liuXue-=1;
        if(inv.liuXue<0){
            inv.liuXue = 0;
        }
    }
}

-(int)effectNeiGongJiaLiHurt:(int)hurt WithInvader:(NSObject*)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"须弥山神掌"]) {
            hurt *= 1.2;
        }
        
        if ([m_wugong isWugong:@"罗汉拳"]) {
            hurt += 50;
            //CCLOG(@"here");
        }
        
    }
    return hurt;
}

//-(int)effectLifeHurtAfterCalculate:(int)hurt WithInvader:(NSObject*)invader WithWugong:(Wugong *)m_wugong{
//    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
//    Invader* inv = (Invader*)invader;
//    if ([inv.mainNeiGong isWugong:self.wugongName]) {
//    }
//    return hurt;
//}
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
