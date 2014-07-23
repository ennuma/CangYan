//
//  Entity.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Entity.h"


@implementation Entity
@synthesize bigIcon = _bigIcon;
@synthesize smallIcon = _smallIcon;
@synthesize entityName = _entityName;
@synthesize entityMale = _entityMale;
@synthesize wuLinName = _wuLinName;
@synthesize weapons = _weapons;
@synthesize armors = _armors;
@synthesize usingWeapon = _usingWeapon;
@synthesize usingArmor = _usingArmor;
@synthesize usingTool = _usingTool;
@synthesize quanfa = _quanfa;
@synthesize jianfa = _jianfa;
@synthesize daofa = _daofa;
@synthesize qimen = _qimen;
@synthesize atk = _atk;
@synthesize def = _def;
@synthesize agile = _agile;
@synthesize talent = _talent;
@synthesize shengwang = _shengwang;
@synthesize wine = _wine;
@synthesize tea = _tea;
@synthesize cook = _cook;
@synthesize mainNeigong = _mainNeigong;
@synthesize specialBuff = _specialBuff;
@synthesize qin = _qin;
@synthesize qi = _qi;
@synthesize shu = _shu;
@synthesize hua = _hua;
@synthesize poision = _poision;
@synthesize antipoision = _antipoision;
@synthesize heal = _heal;
@synthesize wugongchangshi = _wugongchangshi;
@synthesize relationship = _relationShip;
-(Invader*)transformToInvaderForm
{
    Invader* ret = [[Invader alloc]init];
    ret.attack = _atk;
    ret.armor = _def;
    ret.agile = _agile;
    ret.poision = _poision;
    ret.health = _health;
    ret.maxhealth = _maxhealth;
    ret.acume = _acume;
    ret.maxacume = _maxacume;
    ret.quanFa = _quanfa;
    ret.jianFa = _jianfa;
    ret.daoFa = _daofa;
    ret.qiMen = _qimen;
}
-(void)updateStatusFromInvaderForm:(Invader *)invader
{

}
@end
