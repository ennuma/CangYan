//
//  Entity.h
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Wugong.h"
#import "Item.h"
#import "Invader.h";
@interface Entity : CCNode {
    //大头像 小头像 状态栏头像
    CCSprite* _bigIcon;
    CCSprite* _smallIcon;
    CCSprite* _statusIcon;
    //人名 性别 绰号
    NSString* _entityName;
    NSString* _entityMale;
    NSString* _wuLinName;
    
    //人际关系
    //String(entityName) -> int(relationship point)
    NSDictionary* _relationShip;
    
    //WugongArr(Wugong)
    NSMutableArray* _wugong;
    //Special buff can be expressed using hidden neigong buff
    NSMutableArray* _specialBuff;
    //mainneigong
    Wugong* mainNeiGong;
    //weapon and armor Arr (all weapons all armors)
    NSMutableArray* _weapons;
    NSMutableArray* _armors;
    
    //weapon and armor that are using
    Item* _usingWeapon;
    Item* _usingArmor;
    Item* _usingTool;
    
    //攻防轻
    int _atk;
    int _def;
    int _agile;
    
    //拳剑刀特
    int _quanfa;
    int _jianfa;
    int _daofa;
    int _qimen;
    
    //琴棋书画
    int _qin;
    int _qi;
    int _shu;
    int _hua;

    //用毒 抗毒 医术
    int _poision;
    int _antipoision;
    int _heal;
    
    //酒 茶 厨艺
    int _wine;
    int _tea;
    int _cook;
    
    //资质 武常
    int _talent;
    int _wugongchangshi;
    
    //道德 声望
    int _daode;
    int _shengwang;
    
    //health and other stuff
    int _health;
    int _acume;
    int _maxhealth;
    int _maxacume;
    
    //teammates
    NSMutableArray* _teammates;
}
@property CCSprite* bigIcon;
@property CCSprite* smallIcon;
@property CCSprite* statusIcon;
@property NSString* entityName;
@property NSString* entityMale;
@property NSString* wuLinName;
@property NSDictionary* relationship;
@property NSMutableArray* wugong;
@property NSMutableArray* specialBuff;
@property NSMutableArray* weapons;
@property NSMutableArray* armors;
@property Wugong* mainNeigong;
@property Item* usingWeapon;
@property Item* usingArmor;
@property Item* usingTool;
@property int atk;
@property int def;
@property int agile;
@property int quanfa;
@property int jianfa;
@property int daofa;
@property int qimen;
@property int poision;
@property int antipoision;
@property int heal;
@property int wine;
@property int tea;
@property int cook;
@property int talent;
@property int wugongchangshi;
@property int daode;
@property int shengwang;
@property int qin;
@property int qi;
@property int shu;
@property int hua;
@property int health;
@property int acume;
@property int maxhealth;
@property int maxacume;
@property NSMutableArray* teammates;
-(Invader*)transformToInvaderForm;
-(void)updateStatusFromInvaderForm:(Invader*)invader;
-(void)say:(NSString*)sentence;
@end
