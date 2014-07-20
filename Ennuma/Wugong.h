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

-(void)initWugongNameAndLevelAndAcumeCost;
-(void)initPoisionAndBleed;
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
-(int)effectNeiGongJiaLi:(int)attackNg WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
-(int)effectLifeHurtAfterCalculate:(int)hurt WithInvader:(NSObject*)invader WithWugong:(Wugong*) m_wugong;
@end
