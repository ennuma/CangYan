//
//  Invader.h
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Extension.h"
//#import "BattleField.h"
@interface Invader : NSObject  {
    int _strength;
    int _agile;
    int _wisdom;
    int _attack;
    int _armor;
    
    float _jiqispeed;
    float _amountofjiqi;
    
    CCSprite* aliveIcon;
    CCSprite* deadIcon;
    
    CCSprite* _smallIcon;
    CCSprite* _bigIcon;
    CCSprite* _headIcon;
    CCSprite* _state;
    CCTiledMap* _map;
    
    NSMutableArray* _allie;
    NSMutableArray* _enemy;
    
    CGPoint _position;
    //Wugong Array
    NSMutableArray* wugong;
    
    int _poision;
    int _bleed;
    
    int _health;
    int _acume;
    int _maxhealth;
    int _maxacume;
    int _stamina;
    int _fengXue;
    int _liuXue;
    //variables used for caculate movements
    NSMutableSet* reachable;
    NSMutableDictionary* reachableLookup;
    
    BOOL _isDefending;
    BOOL _isDead;
    
    int _angryRate;
    int _talent;
    int _wuxueKnowledge;
    
    Wugong* _mainNeiGong;
    
    int _attackHasPoisionIndex;
    int _antiPoisionIndex;
    
    int _willingToFight;
    
    int _quanFa;
    int _jianFa;
    int _daoFa;
    int _qiMen;
}

@property int strength;
@property int agile;
@property int wisdom;
@property int attack;
@property int armor;
@property float jiqispeed;
@property float amountofjiqi;
@property CCSprite* smallIcon;
@property CCSprite* bigIcon;
@property CCTiledMap* map;
@property NSMutableArray* allie;
@property NSMutableArray* enemy;
@property CGPoint position;

@property int health;
@property int acume;
@property int maxhealth;
@property int maxacume;
@property CCSprite* state;
@property CCSprite* headIcon;
@property BOOL isDefending;
@property BOOL isDead;
@property int stamina;
@property int poision;
@property int bleed;
@property int fengXue;//封穴
@property int liuXue;

@property int attackHasPoisionIndex;
@property int antiPoisionIndex;

@property int angryRate;
@property int talent;
@property int wuxueKnowledge;
@property Wugong* mainNeiGong;
@property NSMutableArray* wugongArr;
@property int willingToFight;
@property int quanFa;
@property int jianFa;
@property int daoFa;
@property int qiMen;

-(void)initForBattleWithParent:(CCNode*)parent;
-(void)initWuGong;
-(void)initIcon;
-(void)doAction;
-(void)endOfBattle;
-(void)prepareForAction;
-(void)doActionLogic;
-(void)endOfAction;
-(void)initPosition:(CGPoint)pos;
-(void)attackInvaders:(NSMutableArray*)invaders WithWuGong:(Wugong*) wugong;
-(void)defendInvader:(Invader *)invader WhoUseWuGong:(Wugong *)m_wugong WithAwugong:(Wugong*)awugong WithAng:(int)ang WithRate:(float)rate;
-(void)updateJiQi;
-(void)learnWugong:(Wugong*)m_wugong;
@end
