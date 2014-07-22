//
//  Wugong.m
//  Ennuma
//
//  Created by ennuma on 14-7-14.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Wugong.h"


@implementation Wugong
@synthesize range = _range;
@synthesize damage = _damage;
@synthesize fengXueIndex = _fengXueIndex;
@synthesize bleedIndex = _bleedIndex;
@synthesize level = _level;
@synthesize rangeType = _rangeType;
@synthesize acumeCost = _acumeCost;
@synthesize wugongName = _wugongName;
@synthesize neigongJiaLi = _neigongJiaLi;
@synthesize neigongHuTi = _neigongHuTi;
@synthesize criticalHitBuff = _criticalHitBuff;
@synthesize multiHitBuff = _multiHitBuff;
@synthesize poision = _poision;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.damage = [NSMutableArray array];
    
    for (int i = 0;  i < 11;  i++) {
        [_damage addObject:[NSNumber numberWithInt:0]];
    }
    
    [self initPoisionAndBleedAndFengXue];
    [self initRangeAndRangeType];
    [self initWugongNameAndLevelAndAcumeCost];
    [self initWugongDamageForEachLevelAndQigongValue];
    
    return self;
}
-(void)initMultiHitAndCriticalHit
{
    _multiHitBuff = 0;
    _criticalHitBuff = 0;
}
-(void)initWugongDamageForEachLevelAndQigongValue
{

    //damage for each level
    /**
    [_damage insertObject:[NSNumber numberWithInt:1000]  atIndex:1];
    [_damage insertObject:[NSNumber numberWithInt:2]  atIndex:2];
    [_damage insertObject:[NSNumber numberWithInt:3]  atIndex:3];
    [_damage insertObject:[NSNumber numberWithInt:4]  atIndex:4];
    [_damage insertObject:[NSNumber numberWithInt:5]  atIndex:5];
    [_damage insertObject:[NSNumber numberWithInt:6]  atIndex:6];
    [_damage insertObject:[NSNumber numberWithInt:7]  atIndex:7];
    [_damage insertObject:[NSNumber numberWithInt:8]  atIndex:8];
    [_damage insertObject:[NSNumber numberWithInt:9]  atIndex:9];
    [_damage insertObject:[NSNumber numberWithInt:10]  atIndex:10];
    **/
    //qigong value for neigong
    _neigongHuTi=0;
    _neigongJiaLi=0;
}
-(void)initRangeAndRangeType
{
    _range = 0;
    _rangeType = 0;
}

-(void)initPoisionAndBleedAndFengXue
{
    _fengXueIndex = 0;
    _bleedIndex = 0;
    _poision = 0;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"普通武功";
    _level = 1;
    _acumeCost = 0;
}

-(bool)isNeiGong
{
    return false;
}
-(bool)isWaiGong
{
    return false;
}
-(bool)isJianFa
{
    return false;
}
-(bool)isDaoFa
{
    return false;
}
-(bool)isQuanFa
{
    return false;
}
-(bool)isQimen
{
    return false;
}

-(bool)isWugong:(NSString *)otherWugong
{
    return [self.wugongName isEqualToString:otherWugong];
}

-(NSString*)getWugongName
{
    return _wugongName;
}

//effect
-(void)effectAfterAction:(NSObject*)invader
{
    
}

-(void)effectInUpdateJiQi:(NSObject*)invader
{
    
}

-(int)effectNeiGongJiaLiHurt:(int)attackNg WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return attackNg;
}

-(int)effectNeiGongJiaLiSpdHurt:(int)spdhurt WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong{
    return spdhurt;
}
-(int)effectNeiGongJiaLiPoisionHurt:(int)angry WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
{
    return angry;
}
-(int)effectLifeHurtAfterCalculate:(int)hurt WithAtk:(NSObject*)atk WithWugong:(Wugong*) m_wugong
{
    return hurt;
}
-(int)effectLifeHurtAfterCalculate:(int)hurt WithDef:(NSObject*)def WithWugong:(Wugong*) m_wugong
{
    return hurt;
}
-(int)effectWugongDamage:(int)wugongDamage WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    return wugongDamage;
}
-(int)effectDefendDamageConvertToSpdHurt:(int)damageConvertToSpdHurt WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return damageConvertToSpdHurt;
}
-(int)effectReduceAcumeCost:(int)acumecost WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong{
    return acumecost;
}
-(int)effectRestoreJiQi:(int)jiqi AfterAttackWithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    return jiqi;
}
-(int)effectNeiGongJiaLiAngryHurt:(int)poisionnum WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return poisionnum;
}
-(int)effectAngryRateAfterBeingAttacked:(int)angryRate WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    return angryRate;
}
-(int)effectBaojiRate:(int)baojirate WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return baojirate;
}
-(float)effectWillingToFight:(float)willingToFight WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return willingToFight;
}
-(float)effectStamina:(float)stamina WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return stamina;
}
-(void)effectSpecialEffectAtkWithAtk:(NSObject*)atk WithDef:(NSObject*)def WithWugong:(Wugong*) m_wugong
{

}
-(void)effectSpecialEffectDefWithAtk:(NSObject*)atk WithDef:(NSObject*)def WithWugong:(Wugong*) m_wugong
{
    
}
-(int)effectBaojiEffect:(int)effect WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return effect;
}
-(int)effectDefendFengXue:(int)fengxue WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return fengxue;
}
-(int)effectNeiGongHuTiBleedHurt:(int)bleed WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return bleed;
}
-(int)effectRevive:(int)health WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong{
    return health;
}
-(int)effectInitAmountJiqi:(int)jiqi WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong
{
    return jiqi;
}
@end
