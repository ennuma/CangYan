//
//  Wugong.h
//  Ennuma
//
//  Created by ennuma on 14-7-14.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Wugong : CCNode {
    int _range;
    NSMutableArray* _damage; //wugong damage, not applicable to qigong
    int _fengXueIndex;
    int _bleedIndex;
    int _level;
    //the type of range, 1 is point, 2 is line, 3 is blocks around, 4 is chinese char 'mi', 0 is invalid
    int _rangeType;
    
    int _acumeCost;
    NSString* _wugongName;
    
    int _neigongJiaLi;
    int _neigongHuTi;
    
    int _multiHitBuff;
    int _criticalHitBuff;
    int _poision;
}

@property int range;
@property NSMutableArray* damage;
@property int fengXueIndex;
@property int bleedIndex;
@property int rangeType;
@property int level;
@property int acumeCost;
@property NSString* wugongName;
@property int neigongJiaLi;
@property int neigongHuTi;
@property int multiHitBuff;
@property int criticalHitBuff;
@property int poision;

-(void)initWugongNameAndLevelAndAcumeCost;
-(void)initPoisionAndBleedAndFengXue;
-(void)initRangeAndRangeType;
-(void)initWugongDamageForEachLevelAndQigongValue;
-(void)initMultiHitAndCriticalHit;
-(bool)isNeiGong;
-(bool)isWaiGong;
-(bool)isJianFa;
-(bool)isDaoFa;
-(bool)isQuanFa;
-(bool)isQimen;
-(NSString*)getWugongName;
-(bool)isWugong:(NSString*)otherWugong;

//effects
-(void)effectAfterAction:(NSObject*)invader;
-(void)effectInUpdateJiQi:(NSObject*)invader;
-(int)effectNeiGongJiaLiHurt:(int)hurt WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectWugongDamage:(int)wugongDamage WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;

-(int)effectLifeHurtAfterCalculate:(int)hurt WithAtk:(NSObject*)atk WithWugong:(Wugong*) m_wugong;
-(int)effectLifeHurtAfterCalculate:(int)hurt WithDef:(NSObject*)def WithWugong:(Wugong*) m_wugong;

-(int)effectDefendDamageConvertToSpdHurt:(int)damageToSpdHurt WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectDefendFengXue:(int)fengxue WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectReduceAcumeCost:(int)acumecost WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectRestoreJiQi:(int)jiqi AfterAttackWithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectNeiGongJiaLiSpdHurt:(int)spdhurt WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectNeiGongJiaLiPoisionHurt:(int)poisionnum WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectNeiGongJiaLiAngryHurt:(int)angry WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectNeiGongJiaLiFengXueHurt:(int)fengxue WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectAngryRateAfterBeingAttacked:(int)angryRate WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectBaojiRate:(int)baojirate WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(float)effectWillingToFight:(float)willingToFight WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(float)effectStamina:(float)stamina WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(void)effectSpecialEffectAtkWithAtk:(NSObject*)atk WithDef:(NSObject*)def WithWugong:(Wugong*) m_wugong;
-(void)effectSpecialEffectDefWithAtk:(NSObject*)atk WithDef:(NSObject*)def WithWugong:(Wugong*) m_wugong;
-(int)effectBaojiEffect:(int)effect WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;

-(int)effectNeiGongHuTiBleedHurt:(int)bleed WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectRevive:(int)health WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectInitAmountJiqi:(int)jiqi WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(void)effectSpecialEffectScopeWithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectDefendPoision:(int)poision WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(void)effectRestoreAfterActionWithInvader:(NSObject*)invader;
@end
