//
//  Wugong_XiaoWuXiangGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【小无相功】能力解说：
 加力威力：950--1100
 护体威力：900--1000
 一般特效：
 附加一次50%几率的普通招式发动机会 //TODO
 攻击时应消耗体力减2（最低要消耗1体力）
 主功体特效：
 普通招式必定发动 //TODO
 攻击时应消耗体力减4（最低要消耗1体力）
 人物集气速度提升3点
 主功体加成武功：
 『龙爪手』功体加力时追加杀集气200点
 『火焰刀法』人物行动后集气恢复250点 
 **/
#import "Wugong_XiaoWuXiangGong.h"


@implementation Wugong_XiaoWuXiangGong
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1025;
    _neigongJiaLi = 950;
    time = 0;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"小无相功";
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
        if ([m_wugong isWugong:@"龙爪手"]) {
            spdhurt += 200;
        }
    }
    
    return spdhurt;
}
-(int)effectRestoreJiQi:(int)jiqi AfterAttackWithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"火焰刀法"]) {
            jiqi += 250;
        }
    }
    return jiqi;
}
-(float)effectStamina:(float)stamina WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        stamina = MAX(0, stamina-4);
    }else{
        stamina = MAX(0, stamina-2);
    }
    
    return stamina;
}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        inv.amountofjiqi += 3;
    }
}
@end
