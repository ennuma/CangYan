//
//  Wugong_QianKunDaNuoYi.m
//  Ennuma
//
//  Created by ennuma on 14-7-21.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【乾坤大挪移】能力解说：
 加力威力：1050-1150
 护体威力：1200-1400
 一般特效：
 受到攻击时50%几率将所受伤害之30%反弹给一名敌人 不至死
 自身所受伤害减15%
 主功体特效：
 受到攻击时80%几率将所受伤害之30%反弹给一名敌人
 自身所受伤害减30%
 功体护体时内伤增加值将为原值的三分之一
 [逆转乾坤：集气值小于-300时再受到杀气攻击//TODO
 则消耗自身内力化解杀气 如内力不足则无效]
 主功体加成武功：
 『阴阳倒乱刃』人物行动后恢复集气300点
 『奇门三才刀』功体加力时追加伤害60点
 **/
#import "Wugong_QianKunDaNuoYi.h"


@implementation Wugong_QianKunDaNuoYi
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1100;
    _neigongJiaLi = 1300;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"乾坤大挪移";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}
-(int)effectNeiGongHuTiBleedHurt:(int)bleed WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        bleed = bleed / 3;
    }
    return bleed;
}
-(int)effectLifeHurtAfterCalculate:(int)hurt WithDef:(NSObject *)def WithWugong:(Wugong *)m_wugong
{
    NSAssert([def isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)def;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if (CCRANDOM_0_1()*100<=80) {
            int dechurt = hurt*0.3;
            hurt = hurt - dechurt;
            if ([inv.enemy count]>0){
                int count = 0;
                for (Invader* en in inv.enemy) {
                    if (!en.isDead) {
                        count ++;
                    }
                }
                Invader* enemy = [inv.enemy objectAtIndex:CCRANDOM_0_1()*count];
                enemy.health -= dechurt;
                if(enemy.health<=0){
                    enemy.health=1;
                }
                [enemy say:[NSString stringWithFormat:@"乾坤大挪移：-%i",dechurt] WithColor: [CCColor colorWithCcColor3b:ccRED]];
            }
        }
        hurt = hurt*0.85;
    }else{
        if (CCRANDOM_0_1()*100<=50) {
            int dechurt = hurt*0.3;
            hurt = hurt - dechurt;
            if ([inv.enemy count]>0){
                int count = 0;
                for (Invader* en in inv.enemy) {
                    if (!en.isDead) {
                        count ++;
                    }
                }
                Invader* enemy = [inv.enemy objectAtIndex:CCRANDOM_0_1()*count];
                enemy.health -= dechurt;
                if(enemy.health<=0){
                    enemy.health=1;
                }
                [enemy say:[NSString stringWithFormat:@"乾坤大挪移：-%i",dechurt] WithColor: [CCColor colorWithCcColor3b:ccRED]];
            }
        }

        hurt = hurt*0.7;
    }
    return hurt;
}
-(int)effectNeiGongJiaLiHurt:(int)hurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"奇门三才刀"]) {
            hurt += 60;
        }
    }
    return hurt;
}
-(int)effectRestoreJiQi:(int)jiqi AfterAttackWithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"阴阳倒乱刃"]) {
            jiqi += 300;
        }
    }
    return jiqi;
}
@end
