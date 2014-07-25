//
//  Entity.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Entity.h"
#import "CangYan.h"

@implementation Entity
@synthesize bigIcon = _bigIcon;
@synthesize smallIcon = _smallIcon;
@synthesize statusIcon = _statusIcon;
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
@synthesize teammates = _teammates;
@synthesize wugong = _wugong;
@synthesize isPlayer = _isPlayer;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _wugong = [[NSMutableArray alloc]init];
    _specialBuff = [[NSMutableArray alloc]init];
    _weapons = [[NSMutableArray alloc]init];
    _armors = [[NSMutableArray alloc]init];
    _teammates = [[NSMutableArray alloc]init];
    _relationShip = [[NSMutableDictionary alloc]init];
    [self initEntity];
    return self;
}
-(void)initEntity
{

}
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
    ret.antiPoisionIndex = _antipoision;
    ret.attackHasPoisionIndex = _poision;//may be to much
    ret.wuxueKnowledge = _wugongchangshi;
    ret.talent = _talent;
    ret.isPlayer = _isPlayer;
    NSMutableArray* retwugong = [[NSMutableArray alloc] init];
    //CCLOG(@"%i",[_wugong count]);
    for (Wugong* wg in _wugong) {
        [retwugong addObject:wg];
    }
    for (Wugong* wg in _specialBuff) { //add buff
        [retwugong addObject:wg];
    }
    ret.wugongArr = retwugong;
    if ([_entityMale isEqualToString:@"不男不女"]) {
        ret.taijian=true;
    }
    
    
    //头像
    //ret.bigIcon = [CCSprite spriteWithTexture:[_bigIcon texture]];
    //ret.smallIcon = [CCSprite spriteWithTexture:[_smallIcon texture]];
    //ret.headIcon = [CCSprite spriteWithTexture:[_statusIcon texture]];

    return ret;
}
-(void)updateStatusFromInvaderForm:(Invader *)ret
{
    _atk = ret.attack;
    _def = ret.armor;
    _agile = ret.agile;
    _poision = ret.poision;
    _health = ret.health = _health;
    _maxhealth = ret.maxhealth;
    _acume = ret.acume = _acume;
    _maxacume = ret.maxacume;
    _quanfa = ret.quanFa;
    _jianfa = ret.jianFa;
    _daofa = ret.daoFa;
    _qimen = ret.qiMen;
    _antipoision = ret.antiPoisionIndex;
    _poision = ret.attackHasPoisionIndex;//may be too much
    _wugongchangshi = ret.wuxueKnowledge;
    _talent = ret.talent;
}
-(void)say:(NSString*)sentence
{
    CangYan* cangYan = [CangYan sharedScene];
    [cangYan removeChildByName:@"say"];
    CCNode* bottom = [cangYan getChildByName:@"bottombar" recursively:NO];
    [bottom removeAllChildren];
    
    CCLabelTTF* labelDay = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@ 说: %@",_entityName,sentence] fontName:@"Verdana-Bold" fontSize:15];
    [cangYan addChild:labelDay z:0 name:@"say"];
    labelDay.position = CGPointMake(bottom.contentSize.width/2*bottom.scaleX,bottom.contentSize.height/2*bottom.scaleY);
}

-(void)learnWugong:(Wugong *)wugong
{
    if ([_wugong count]<10) {
        [_wugong addObject:wugong];
    }
}
-(void)learnSpecial:(Wugong *)wugong
{
    [_specialBuff addObject:wugong];
}
@end
