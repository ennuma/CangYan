//
//  Wugong_KuiHuaShenGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-21.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【葵花神功】能力解说：
 加力威力：1200--1500
 护体威力：1100--1300
 一般特效：
 人物集气速度提升3点
 被攻击时15%几率出葵花移形
 [葵花移形：所受伤害变为1/3 不减集气]
 葵花移形之效果对各种特效追加伤害及杀气方式均有作用
 主功体特效：
 人物集气速度提升8点
 被攻击时35%概率出葵花移形
 攻击时消耗体力减5
 人物战意提升速度增加20%
 主功体加成武功：
 『辟邪剑法』加力成功时60%几率出葵花刺目
 [葵花刺目：被刺目者下次行动必miss]
 **/
#import "Wugong_KuiHuaShenGong.h"


@implementation Wugong_KuiHuaShenGong

-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1350;
    _neigongJiaLi = 1200;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"葵花神功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        //8 jiqi
        inv.amountofjiqi += 8;

    }else{
        
        inv.amountofjiqi +=3;
  
    }
}
-(float)effectWillingToFight:(float)willingToFight WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        willingToFight*=1.2;
    }
    
    return willingToFight;
}
-(float)effectStamina:(float)stamina WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        stamina -=5;
    }
    
    return stamina;
}
-(void)effectSpecialEffectAtkWithAtk:(NSObject *)atk WithDef:(NSObject *)def WithWugong:(Wugong *)m_wugong
{
    //CCLOG(@"here1");
    NSAssert([atk isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* invatk = (Invader*)atk;
    
    NSAssert([def isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* invdef = (Invader*)def;
    
    if ([invatk.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"辟邪剑法"]) {
            if (CCRANDOM_0_1()*100<=60){
                invdef.blind = true;
            }
        }
    }
    
}
-(void)effectSpecialEffectDefWithAtk:(NSObject *)atk WithDef:(NSObject *)def WithWugong:(Wugong *)m_wugong
{

    NSAssert([def isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* invdef = (Invader*)def;
    
    if ([invdef.mainNeiGong isWugong:self.wugongName]) {
        if (CCRANDOM_0_1()*100<=35){
            invdef.kuiHuaYixing = true;
        }
    }else{
        if (CCRANDOM_0_1()*100<=15){
            invdef.kuiHuaYixing = true;
        }
    }
}
@end
