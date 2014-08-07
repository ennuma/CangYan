//
//  Invader.m
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Invader.h"

@implementation Invader
//@synthesize strength = _strength;
@synthesize reachableSet = reachable;
@synthesize agile =_agile;
//@synthesize wisdom = _wisdom;
@synthesize attack = _attack;
@synthesize armor = _armor;
@synthesize jiqispeed = _jiqispeed;
@synthesize amountofjiqi = _amountofjiqi;
@synthesize smallIcon = _smallIcon;
@synthesize bigIcon = _bigIcon;
@synthesize map = _map;
@synthesize allie = _allie;
@synthesize enemy = _enemy;
@synthesize health = _health;
@synthesize acume = _acume;
@synthesize maxhealth = _maxhealth;
@synthesize maxacume = _maxacume;
@synthesize position = _position;
@synthesize headIcon = _headIcon;
@synthesize state = _state;
@synthesize isDefending = _isDefending;
@synthesize isDead = _isDead;
@synthesize stamina = _stamina;
@synthesize talent = _talent;
@synthesize angryRate = _angryRate;
@synthesize wuxueKnowledge = _wuxueKnowledge;
@synthesize mainNeiGong = _mainNeiGong;
@synthesize wugongArr = wugong;
@synthesize poision = _poision;
@synthesize bleed = _bleed;
@synthesize fengXue = _fengXue;
@synthesize liuXue = _liuXue;
@synthesize attackHasPoisionIndex = _attackHasPoisionIndex;
@synthesize antiPoisionIndex = _antiPoisionIndex;
@synthesize willingToFight=_willingToFight;
@synthesize quanFa = _quanFa;
@synthesize jianFa = _jianFa;
@synthesize daoFa = _daoFa;
@synthesize qiMen = _qiMen;
@synthesize blind = _blind;
@synthesize kuiHuaYixing = _kuihuayixing;
@synthesize life = _life;
@synthesize taijian = _taijian;
@synthesize heal = _heal;
@synthesize isPlayer = _isPlayer;
@synthesize attackableSet = attackable;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    //need to be change later TODO
    wugong = [[NSMutableArray alloc]init];
    reachable = [[NSMutableSet alloc]init];
    reachableLookup =[[NSMutableDictionary alloc]init];
    actions = [[NSMutableArray alloc]init];
    attackable = [[NSMutableSet alloc]init];
    [self initWuGong];
    [self initIcon];
    return self;
}
-(void)initIcon
{
    _bigIcon = [CCSprite spriteWithImageNamed:@"Enemy1.png"];
    _smallIcon = [CCSprite spriteWithImageNamed:@"Enemy1.png"];
}
//TODO
-(void)initWuGong
{
    //Wugong_SongFengJianFa* jianfa = [Wugong_SongFengJianFa node];
    //[wugong addObject:jianfa];
    //Wugong_LuoHanFuMoGong* fumogong =[Wugong_LuoHanFuMoGong node];
    //[wugong addObject:fumogong];
    //Wugong_LiuMaiShenJian* liumai = [Wugong_LiuMaiShenJian node];
    //[wugong addObject:liumai];
}
-(void)learnWugong:(Wugong*)m_wugong
{
    [wugong addObject:m_wugong];
}
-(void)initForBattleWithParent:(CCNode *)parent
{
    _amountofjiqi = [self initAmountOfJiqi];
    _health = _maxhealth;
    _acume = _maxacume;
    _stamina = 100;
    _poision = 0;
    _bleed = 0;
    _willingToFight = 110;
    _angryRate = 0;
    _fengXue = 0;
    
    [self calculateNewJiqiSpeed];
    //variable init
    _isDead=false;
    _isDefending=false;
    _life = 0;
    //self.runningInActiveScene = YES;
    [parent addChild:_bigIcon z:0];
    
    //init state hud
    [self initStateWithParent:parent];
    
    //test
}

-(void)initStateWithParent:(CCNode*)parent
{
    _state = [CCSprite spriteWithImageNamed:@"stateHud.png"];
    [parent addChild:_state];
    _state.position = CGPointMake(parent.contentSize.width-_state.contentSize.width/2, parent.contentSize.height/2);
    
    //init headIcon
    _headIcon = [CCSprite spriteWithImageNamed:@"headIcon.png"];
    [_state addChild:_headIcon];
    _headIcon.position = CGPointMake(_state.contentSize.width/2, _state.contentSize.height-_headIcon.contentSize.height/2);
    
    CCLabelTTF* health = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"health: %i",_health] fontName:@"Verdana-Bold" fontSize:18.0f];
    [_state addChild:health z:0 name:@"health"];
    health.position = CGPointMake(_state.contentSize.width/2, _headIcon.position.y - 64);
    
    CCLabelTTF* acume = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"acume: %i",_acume] fontName:@"Verdana-Bold" fontSize:18.0f];
    [_state addChild:acume z:0 name:@"acume"];
    acume.position = CGPointMake(_state.contentSize.width/2, health.position.y - 64);
    
    CCLabelTTF* poision = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"poision: %i",_poision] fontName:@"Verdana-Bold" fontSize:18.0f];
    [_state addChild:poision z:0 name:@"poision"];
    poision.position = CGPointMake(_state.contentSize.width/2, acume.position.y - 128);
    
    CCLabelTTF* bleed = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"bleed: %i",_bleed] fontName:@"Verdana-Bold" fontSize:18.0f];
    [_state addChild:bleed z:0 name:@"bleed"];
    bleed.position = CGPointMake(_state.contentSize.width/2, poision.position.y - 64);
    
    CCLabelTTF* fengXue = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"fengXue: %i",_bleed] fontName:@"Verdana-Bold" fontSize:18.0f];
    [_state addChild:fengXue z:0 name:@"fengXue"];
    fengXue.position = CGPointMake(_state.contentSize.width/2, bleed.position.y - 64);
    
    _state.visible=NO;
    
}
-(void)initPosition:(CGPoint)pos
{
    CCLOG(@"%f,%f",_map.mapSize.width,_map.mapSize.height);
    if (pos.x>_map.mapSize.width-1) {
        pos.x=_map.mapSize.width-1;
    }
    
    if (pos.y>_map.mapSize.height-1) {
        pos.y=_map.mapSize.height-1;
    }
    
    CGPoint newpos = [[_map layerNamed:@"map"] positionAt:pos];

    //NSString *str = [NSString stringWithFormat:@"pos:%f,%f",newpos.x,newpos.y];
    //CCLOG(str);
    newpos = CGPointMake(newpos.x+_bigIcon.contentSize.width/2, newpos.y-_bigIcon.contentSize.height/2);
    
    _bigIcon.position = newpos;
    self.position = pos;
}
-(CGPoint)convertToMapCord:(CGPoint)pos
{
    CGPoint newpos = [[_map layerNamed:@"map"] positionAt:pos];
    
    newpos = CGPointMake(newpos.x+_bigIcon.contentSize.width/2, newpos.y-_bigIcon.contentSize.height/2);
    
    return newpos;
}
-(void)doAction
{
    //CCActionCallFunc* act1 = [CCActionCallFunc actionWithTarget:self selector:@selector(prepareForAction)];
    //CCActionCallFunc* act2 = [CCActionCallFunc actionWithTarget:self selector:@selector(doActionLogic)];
    //CCActionCallFunc* act3 = [CCActionCallFunc actionWithTarget:self selector:@selector(endOfAction)];
    
    //CCActionSequence* sq = [CCActionSequence actions:act1, act2, act3, nil];
    //CCLOG(@"before run action");
    [self prepareForAction];
    [self doActionLogic];
    //[self endOfAction];
    
    //[self endOfAction];
}
-(void)effectAfterAction
{
    for (Wugong* myWugong in wugong) {
        [myWugong effectAfterAction:self];
    }
}
-(void)endOfAction
{
    
    [self clearReachableRender];
    
    [self calculatePoisionAndBleed];
    
    [self effectAfterAction];
    //CCLOG(@"endofAct");
    [_smallIcon.parent schedule:@selector(startJiqi:) interval:0.02];
    //CCLOG(@"end of action");
    
    //set statehud visible to no
    _state.visible = NO;
    //[self addChild:_smallIcon];
}
-(void)updateState
{
    CCLabelTTF* healthbar = (CCLabelTTF*)[self.state getChildByName:@"health" recursively:NO];
    [healthbar setString: [NSString stringWithFormat:@"health: %i", self.health]];
    CCLabelTTF* acume = (CCLabelTTF*)[self.state getChildByName:@"acume" recursively:NO];
    [acume setString: [NSString stringWithFormat:@"acume: %i", self.acume]];
    CCLabelTTF* poision = (CCLabelTTF*)[self.state getChildByName:@"poision" recursively:NO];
    [poision setString: [NSString stringWithFormat:@"poision: %i", self.poision]];
    CCLabelTTF* bleed = (CCLabelTTF*)[self.state getChildByName:@"bleed" recursively:NO];
    [bleed setString: [NSString stringWithFormat:@"bleed: %i", self.bleed]];
    CCLabelTTF* fengxue = (CCLabelTTF*)[self.state getChildByName:@"fengXue" recursively:NO];
    [fengxue setString: [NSString stringWithFormat:@"fengXue: %i", self.fengXue]];
}
-(void)prepareForAction
{
    int movenum = [self getnewmove]- ((float)_poision)/50.0 - ((float)_bleed)/60.0 + ((float)_health)/70.0 -1.0;
    if (movenum<1) {
        movenum = 1;
    }
    for (Wugong* wg in wugong) {
        movenum = [wg effectMoveNumberBeforeAction:movenum WithInvader:self];
    }
    [self buildReachable:movenum];
    //CCLOG(@"%i",movenum);
    //CCLOG(@"%@",reachable);
    [self renderReachable];
    [attackable removeAllObjects];
    //set statehud visible to yes and update
    _state.visible = YES;
    [self updateState];
}
-(bool)enemyAlive
{
    bool flag = false;
    for (Invader* inv in _enemy) {
        if (!inv.isDead) {
            flag=true;
        }
    }
    
    return flag;
}
-(void)doActionLogic
{
    /**
    CCActionCallFunc* callback = [CCActionCallFunc actionWithTarget:self selector:@selector(endOfAction)];
    Invader* nearestEnemy = [self getNearestEnemy];
    CGPoint despoint = [self getDesPoint:nearestEnemy.position];
    CCAction* action = [self buildCCActionMovArrFrom:self.position To:despoint];
    CCActionSequence* actions = [CCActionSequence actions:action, callback, nil];
    [_bigIcon runAction:actions];
    self.position = despoint;
     **/
    //TODO may pause forever
    //check if there is any enemy alive
    [actions removeAllObjects];
    if (![self enemyAlive]||self.isDead) {
        [self endOfAction];
        return;
    }
    if (_isPlayer) {
        [self waitForMove];
    }else{
    CCActionCallFunc* callback = [CCActionCallFunc actionWithTarget:self selector:@selector(endOfAction)];

    //[self war_AutoFight];
    int flag = [self war_Think];
    //CCLOG(@"%i",flag);
    if (flag==0) {
        [self autoEscape];
        [self autoRest];
    }else if(flag ==1)
    {
        [self war_AutoFight];
    }else{
        //not do yet , heal or something
    }
    
    //run actions
    [actions addObject:callback];
    CCActionSequence* seq = [CCActionSequence actionWithArray:actions];
    [_bigIcon runAction:seq];
    }
    for (Wugong* wg in self.wugongArr) {
        [wg effectRestoreAfterActionWithInvader:self];
    }
}

/**能否吃药增加参数
 flag=2 生命，3内力；4体力  6 解毒**/ //TODO
-(int)war_ThinkDrug:(int)index
{
    return -1;
}
-(int)war_ThinkHeal
{
    return -1;
}
/**
 0 rest， 1 fight，2 item health， 3 item acume 4 item stamina， 5 heal 6 item poision
 **/
-(int)war_Think
{
    int r = -1;
    //rest
    if (_stamina<10) {
        r = [self war_ThinkDrug:4];
        if (r>=0) {
            return r;
        }else{
            return 0;
        }
    }
    //health
    if (_health<20 || _bleed>50) {
        r = [self war_ThinkDrug:2];
        if (r>=0) {
            return r;
        }
    }
    
    //heal
    float rate = 0;
    if (_health<_maxhealth/5) {
        rate = 90;
    }
    else if(_health < _maxhealth/4){
        rate = 70;
    }
    else if(_health < _maxhealth/3){
        rate = 50;
    }
    else if(_health < _maxhealth/2){
        rate = 25;
    }
    if (CCRANDOM_0_1()*100<rate) {
        r = [self war_ThinkDrug:2];
        if (r>=0) {
            return r;
        }else{
            r = [self war_ThinkHeal];
            if (r>=0) {
                return r;
            }
        }

    }
    
    
    //acume
    rate=0;
    if (_acume<_maxacume/5) {
        rate = 75;
    }
    else if(_acume < _maxacume/4){
        rate = 50;
    }
    if (CCRANDOM_0_1()*100<rate) {
        r = [self war_ThinkDrug:3];
        if (r>=0) {
            return r;
        }
    }


    
    rate=0;
    if (_poision>75) {
        rate = 60;
    }
    else if(_poision > 50){
        rate = 30;
    }
    if (CCRANDOM_0_1()*100<rate) {
        r = [self war_ThinkDrug:6];
        if (r>=0) {
            return r;
        }
    }

    
    
    /**local minNeili=War_GetMinNeiLi(pid);     --所有武功的最小内力
    
    if JY.Person[pid]["内力"]>=minNeili then
        r=1;
    else
        r=0;
    end
    
    return r;
    end**/
    return 1;
}
-(void)manul_Fight
{
    /**
    CCNode* menu = [CCNode node];
    CCLabelTTF* fight = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"fight"] fontName:@"Verdana-Bold" fontSize:18.0f];
    fight.position = CGPointMake(300, 400);
    CCLabelTTF* move = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"move"] fontName:@"Verdana-Bold" fontSize:18.0f];
    move.position = CGPointMake(300, 500);
    [menu addChild:move z:0 name:@"move"];
    [menu addChild:fight z:0 name:@"fight"];
    [_map.parent addChild:menu z:0 name:@"menu"];
     **/
}
-(void)waitForMove
{
    [_map.parent waitForMove];
}
-(void)waitForChooseWugong
{
    //[_map.parent showWugongMenu];
    [_map.parent waitForChooseWugong];
}
-(void)waitForAttack
{
    [_map.parent waitForAttack];
}
-(void)moveTo:(CGPoint)despoint
{
    CCActionFiniteTime* action = [self buildCCActionMovArrFrom:self.position To:despoint];
    self.position = despoint;
    CCActionCallFunc* callback = [CCActionCallFunc actionWithTarget:self selector:@selector(waitForChooseWugong)];
    CCActionSequence* seq = [CCActionSequence actions:action,callback, nil];
    [_bigIcon runAction:seq];
}
-(void)chooseWugong:(Wugong*)wugong
{
    [self renderAttackWithWugong:wugong Direction:0 Position: [NSValue valueWithCGPoint:self.position]];
    [self waitForAttack];
}
-(void)war_AutoFight
{
    //try attack fitst, if fails than choose to move
    Wugong* choosedWugong = [self autoChooseWugong];
    CCLOG(@"%@",choosedWugong.wugongName);
    NSValue* val =[self getMaxAttackPosWithWugong:choosedWugong];
    if (val) {
        CGPoint pos = [val CGPointValue];
        [self autoAttack:pos WithWugong:choosedWugong];
        //minus acume according to acumecost
        //_acume-=choosedWugong.acumeCost;
        CCLabelTTF* healthbar = (CCLabelTTF*)[self.state getChildByName:@"acume" recursively:NO];
        [healthbar setString: [NSString stringWithFormat:@"%i", _acume]];
        
    }else{
        [self autoMove];
        [self autoRest];
    }
}

-(Wugong*)autoChooseWugong
{
    if ([wugong count]==0) {
        //CCLOG(@"return nil");
        return nil;
    }
    
    int index = CCRANDOM_0_1()*wugong.count;
    Wugong* ret = [wugong objectAtIndex:index];
    
    for (Wugong* wg in wugong) {
        if ([wg isWaiGong]) {
            ret = wg;
        }
    }
    return ret;
}
-(void)attackWithWugong:(Wugong*)wugong2 Direction:(int)direction
{
    CCActionCallFunc* callback = [CCActionCallFunc actionWithTarget:self selector:@selector(endOfAction)];
    NSMutableArray* invadersBeingAttacked = [self invadersBeingAttakedWithWugong:wugong2 Direction:direction Position:[NSValue valueWithCGPoint:self.position]];
    
    CCActionCallFunc *attackInvaders = [CCActionCallFuncAttackInvader actionWithTarget:self selector:@selector(attackInvaders:WithWuGong:) Invaders:invadersBeingAttacked Wugong:wugong2];
    
    //May change later
    CCActionDelay* delay = [CCActionDelay actionWithDuration:1];//play animation after this TODO
    
    CCActionSequence* seq = [CCActionSequence actions:attackInvaders,delay,callback, nil];
    [_bigIcon runAction:seq];
    invadersBeingAttacked = nil;

}
-(void)autoAttack:(CGPoint)position WithWugong:(Wugong*)wugong2
{
    CCActionCallFunc* callback = [CCActionCallFunc actionWithTarget:self selector:@selector(endOfAction)];
 
    CGPoint despoint = position;
    CCActionFiniteTime* action = [self buildCCActionMovArrFrom:self.position To:despoint];
    //TODO tricky part , when to adjust position? may be use callback
    self.position = despoint;
    //
    int direction = [self getAttackDir:despoint WithWugong:wugong2];
    
   // [self renderAttackWithWugong:wugong Direction:direction Position:despoint];
    
    CCActionCallFuncNNN* render = [CCActionCallFuncNNN actionWithTarget:self selector:@selector(renderAttackWithWugong:Direction:Position:) Id:wugong2 Id:direction Id:[NSValue valueWithCGPoint:despoint]];

    NSMutableArray* invadersBeingAttacked = [self invadersBeingAttakedWithWugong:wugong2 Direction:direction Position:[NSValue valueWithCGPoint:despoint]];
    
    CCActionCallFunc *attackInvaders = [CCActionCallFuncAttackInvader actionWithTarget:self selector:@selector(attackInvaders:WithWuGong:) Invaders:invadersBeingAttacked Wugong:wugong2];
    
    //May change later
    CCActionDelay* delay = [CCActionDelay actionWithDuration:1];//play animation after this TODO
    //delay need to put after attackinvaders because this delay is used for Shajiqi effect. smallIcon need this delay time to run animation
    //CCActionSequence* actions = [CCActionSequence actions:action,render,
    //                             attackInvaders, delay, callback, nil];
    [actions addObject:action];
    [actions addObject:render];
    [actions addObject:attackInvaders];
    [actions addObject:delay];
    //[_bigIcon runAction:actions];
    
    
    //release invaders
    invadersBeingAttacked = nil;
}
-(void)rest
{
    if (_isDead) {
        return;
    }
    float percentage = _stamina/100.0 -_bleed/50.0 - _poision/50.0 + 4 + CCRANDOM_0_1()*4;
    percentage = percentage/120.0;
    _stamina += 3+CCRANDOM_0_1()*4;
    _health = MIN(_maxhealth, _health+3+_maxhealth*percentage);
    _acume = MIN(_maxacume, _acume+3+_maxacume*percentage);
}
-(void)autoRest
{
    [self rest];
    CCActionDelay* delay = [CCActionDelay actionWithDuration:1];
    [actions addObject:delay];
}
-(void)attackInvaders:(NSMutableArray *)invaders WithWuGong:(Wugong *)m_wugong
{
    int ang=0;
    Wugong* awugong=nil;
    Invader* pid = self;
    for (Wugong* pidWugong in pid.wugongArr) {
        if ([pidWugong isNeiGong]) {
            if ([pid triggerSpecialEffectWithProbility:10]) {
                int damage = pidWugong.neigongJiaLi;
                if (damage > ang) {
                    ang = damage;
                    awugong = pidWugong;
                }
            }
        }
    }
    if (awugong) {
        NSString* words = [NSString stringWithFormat:@"%@%@",[awugong getWugongName],@"\n加力!" ];
        [pid say:words WithColor:[CCColor colorWithCcColor3b:ccWHITE]];
    }
    float rate = 1.0; //hurt = hurt*rate
    int baojiProb = 20*self.willingToFight/100;
    
    for (Wugong* wg in self.wugongArr) {
        baojiProb = [wg effectBaojiRate:baojiProb WithInvader:self WithWugong:m_wugong];
    }
    //CCLOG(@"%i",_blind);
    //爆击效果
    if ([self triggerBaojiEffectWithProbility:baojiProb]) {//ZZY
        rate *= (100+m_wugong.criticalHitBuff)/100;
        int baojiEffect = 1.5;
        for (Wugong* wg in self.wugongArr) {
            baojiEffect = [wg effectBaojiEffect:baojiEffect WithInvader:self WithWugong:m_wugong];
        }
        rate *= baojiEffect;
    }
    
    for (Wugong* wg in self.wugongArr) {
        [wg effectSpecialEffectScopeWithInvader:self WithWugong:m_wugong];
    }
    
    _isLianji = false;
    for (Invader* inv in invaders) {
        //neigong jia li
        [inv defendInvader:self WhoUseWuGong:m_wugong WithAwugong:awugong WithAng:ang WithRate:rate IsLianji:false];
    }
    //small icon update
    for (Invader* inv in _enemy) {
        if (inv.isDead) {
            continue;
        }
        [((CCScene*)_map.parent) notifyJiQiChangedForInvader:inv];
    }

    //TODO LIANJI
    /**
    if ([self triggerLiansuoEffectWithProbility:100]) {
        //insert effect
        [self show:[NSString stringWithFormat:@"%@ 连击！！", m_wugong.wugongName]WithColor:[CCColor colorWithCcColor3b:ccRED]];
    
        for (Invader* inv in invaders) {
            inv.isDefending = TRUE;
            //neigong jia li
            [inv defendInvader:self WhoUseWuGong:m_wugong WithAwugong:awugong WithAng:ang WithRate:rate IsLianji:true];
            while (inv.isDefending) {
                //do nothing, wait
            }
        }
    }**/
    
    
    //acume cost calculated here
    //since acume affect hurt damage, it need to be calculated after attack
    int totalAcumeCost =(m_wugong.level+1)/2*m_wugong.acumeCost;
    int jiqiRestore = 0;
    for (Wugong* wg in self.wugongArr) {
        totalAcumeCost = [wg effectReduceAcumeCost:totalAcumeCost WithInvader:self WithWugong:m_wugong];
        jiqiRestore = [wg effectRestoreJiQi:jiqiRestore AfterAttackWithInvader:self WithWugong:m_wugong];
    }
    _amountofjiqi+=jiqiRestore;
    _acume=MAX(0,_acume-totalAcumeCost);
    //CCLOG(@"jiqi: %f",_amountofjiqi);
    
    //CUSTOMIZE ANGRY RATE TODO
    _angryRate -= 40;
    
    float incWilling = 1.0;
    for (Wugong* wg in self.wugongArr) {
        incWilling = [wg effectWillingToFight:incWilling WithInvader:self WithWugong:m_wugong];
    }
    _willingToFight = MIN(_willingToFight+incWilling,130);
    //////////////////////
    //stamina dec
    float staminadec = 6;
    for (Wugong* wg in self.wugongArr) {
        staminadec = [wg effectStamina:staminadec WithInvader:self WithWugong:m_wugong];
    }
    _stamina = MAX(_stamina - staminadec, 0);
    //reset blind
    _blind = false;
}

-(void)defendInvader:(Invader *)invader WhoUseWuGong:(Wugong *)m_wugong WithAwugong:(Wugong*)awugong WithAng:(int)ang WithRate:(float)rate IsLianji:(bool)lianji
{
    //do things success
    //CCLOG(@"im defending");TODO change ang before defend
    NSDictionary* hurtDic = [invader calculateWugongHurtLifeWithWugong:m_wugong WithInvader:self WithAttakNg:ang WithAWugong:awugong];
    
    int hurt = [[hurtDic objectForKey:@"hurt"]intValue];
    int spdhurt = [[hurtDic objectForKey:@"spdhurt"]intValue];
    int bleedhurt = [[hurtDic objectForKey:@"bleedhurt"]intValue];
    int fengxuehurt = [[hurtDic objectForKey:@"fengxuehurt"]intValue];
    int liuxuehurt = [[hurtDic objectForKey:@"liuxuehurt"]intValue];
    int poisionhurt = [[hurtDic objectForKey:@"poisionhurt"]intValue];
    int angryhurt = [[hurtDic objectForKey:@"angryhurt"]intValue];
    //CCLOG(@"%i\n%i",hurt,spdhurt);
    _kuihuayixing = false;
    for (Wugong* wg in self.wugongArr) {
        [wg effectSpecialEffectDefWithAtk:invader WithDef:self WithWugong:m_wugong];
    }
    
    //int spdhurt = [invader calculateWugongHurtJiQiWithHurt:hurt WithInvader:self];
    hurt*=_willingToFight/100;
    hurt = hurt *rate;
    //def wugong
    for (Wugong* wg in self.wugongArr) {
        hurt = [wg effectLifeHurtAfterCalculate:hurt WithDef:self WithWugong:m_wugong];
    }
    //atk wugong
    for (Wugong* wg in invader.wugongArr) {
        hurt = [wg effectLifeHurtAfterCalculate:hurt WithAtk:invader WithWugong:m_wugong];
    }
    //
    if (_kuihuayixing) {
        [self say:[NSString stringWithFormat:@"葵\n花\n移\n形!"] WithColor: [CCColor colorWithCcColor3b:ccRED]];
        hurt = hurt/3;
    }
    //if not blind ,hurt at least 1
    if (hurt<0) {
        hurt = 1;
    }
    if (invader.blind) {
        hurt = 0;
    }
    if (hurt!=0) {
        [self say:[NSString stringWithFormat:@"-%i",hurt] WithColor: [CCColor colorWithCcColor3b:ccRED]];
    }else{
        [self say:[NSString stringWithFormat:@"miss!"] WithColor: [CCColor colorWithCcColor3b:ccRED]];
    }

    self.health -= hurt;
    CCLabelTTF* healthbar = (CCLabelTTF*)[self.state getChildByName:@"health" recursively:NO];
    [healthbar setString: [NSString stringWithFormat:@"%i", self.health]];
    

    //shajiqi TODO set minimum and maximum
    if (spdhurt<0) {
        spdhurt = 0;
    }
    _amountofjiqi = MAX(_amountofjiqi-spdhurt, -500);
    
    if (bleedhurt<0) {
        bleedhurt = 0;
    }
    _bleed = MIN(_bleed+bleedhurt, 100);
    CCLabelTTF* bleed = (CCLabelTTF*)[self.state getChildByName:@"bleed" recursively:NO];
    [bleed setString: [NSString stringWithFormat:@"%i", _bleed]];
    
    if (fengxuehurt<0) {
        fengxuehurt = 0;
    }
    _fengXue = MIN(_fengXue+fengxuehurt, 50);
    
    if (liuxuehurt <0) {
        liuxuehurt = 0;
    }
    _liuXue = MIN(_liuXue + liuxuehurt, 100);
    
    if (poisionhurt < 0) {
        poisionhurt = 0;
    }
    _poision = MIN(_poision+poisionhurt, 100);
    if (self.health<=0) {
        for (Wugong* wg in self.wugongArr) {
            _health = [wg effectRevive:_health WithInvader:self WithWugong:m_wugong];
        }
        if (self.health<=0) {
            self.isDead=true;
            [_bigIcon removeFromParent];//delete bigicon
        }else{
            [invader show:[NSString stringWithFormat:@"复活！!"] WithColor: [CCColor colorWithCcColor3b:ccBLUE]];

        }
    }
    //CUSTOMIZE HERE ANGRY RATE//////////// TODO
    int incAngry = 20+hurt/5;
    
    for (Wugong* wg in self.wugongArr) {
        incAngry = [wg effectAngryRateAfterBeingAttacked:incAngry WithInvader:self WithWugong:m_wugong];
    }
    //CCLOG(@"angry: %i", incAngry);
    _angryRate+=incAngry;
    _angryRate -= angryhurt;
    ///////////////////////////////////////
    if (awugong) {
        for (Wugong* wg in invader.wugongArr) {
            [wg effectSpecialEffectAtkWithAtk:invader WithDef:self WithWugong:m_wugong];
        }
    }
    self.isDefending = false;
}

-(NSMutableArray*)invadersBeingAttakedWithWugong:(Wugong*)m_wugong Direction:(int)dir Position:(NSValue*)val
{
    CGPoint pos = [val CGPointValue];
    NSMutableArray* invaders = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < m_wugong.range ; i++) {
        CGPoint attackpos;
        if (dir ==1) {
            attackpos = CGPointMake(pos.x, pos.y+i+1);
        }
        if (dir==2) {
            attackpos = CGPointMake(pos.x, pos.y-i-1);
        }
        if (dir==3) {
            attackpos = CGPointMake(pos.x-i-1, pos.y);
        }
        if (dir==4) {
            attackpos = CGPointMake(pos.x+i+1, pos.y);
        }
        
        for (Invader* inv in _enemy) {
            if (inv.isDead) {
                continue;
            }
            if (CGPointEqualToPoint(inv.position, attackpos)) {
                [invaders addObject:inv];
            }
        }
    }
    return invaders;
}

-(void)renderAttackWithWugong:(Wugong*)m_wugong Direction:(int)dir Position:(NSValue*)val
{
    CGPoint pos = [val CGPointValue];
    CCNode* atklayer = [CCNode node];
    atklayer.position = _map.position;
    [_map addChild:atklayer z:1 name:@"attackLayer"];
    for (int i = 0 ; i < m_wugong.range ; i++) {
        if (dir==0) {
            CGPoint attackpos;
            CCSprite* colorlayer = [CCSprite spriteWithImageNamed:@"maphud.png"];
            attackpos = CGPointMake(pos.x, pos.y+i+1);
            colorlayer.opacity = 0.8;
            colorlayer.position = [self convertToMapCord:attackpos] ;
            //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
            [colorlayer setContentSize: [ _map tileSize]];
            [attackable addObject:colorlayer];
            [atklayer addChild:colorlayer z:10];
            
            CGPoint attackpos2;
            CCSprite* colorlayer2 = [CCSprite spriteWithImageNamed:@"maphud.png"];
            attackpos2 = CGPointMake(pos.x, pos.y-i-1);
            colorlayer2.opacity = 0.8;
            colorlayer2.position = [self convertToMapCord:attackpos2] ;
            //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
            [colorlayer2 setContentSize: [ _map tileSize]];
            [attackable addObject:colorlayer2];
            [atklayer addChild:colorlayer2 z:10];
            
            CGPoint attackpos3;
            CCSprite* colorlayer3 = [CCSprite spriteWithImageNamed:@"maphud.png"];
            attackpos3 = CGPointMake(pos.x-i-1, pos.y);
            colorlayer3.opacity = 0.8;
            colorlayer3.position = [self convertToMapCord:attackpos3] ;
            //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
            [colorlayer3 setContentSize: [ _map tileSize]];
            [attackable addObject:colorlayer3];
            [atklayer addChild:colorlayer3 z:10];


            CGPoint attackpos4;
            CCSprite* colorlayer4 = [CCSprite spriteWithImageNamed:@"maphud.png"];
            attackpos4 = CGPointMake(pos.x+i+1, pos.y);
            colorlayer4.opacity = 0.8;
            colorlayer4.position = [self convertToMapCord:attackpos4] ;
            //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
            [colorlayer4 setContentSize: [ _map tileSize]];
            [attackable addObject:colorlayer4];
            [atklayer addChild:colorlayer4 z:10];

        }
        if (dir ==1) {
            CGPoint attackpos;
            CCSprite* colorlayer = [CCSprite spriteWithImageNamed:@"maphud.png"];
            attackpos = CGPointMake(pos.x, pos.y+i+1);
            colorlayer.opacity = 0.8;
            colorlayer.position = [self convertToMapCord:attackpos] ;
            //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
            [colorlayer setContentSize: [ _map tileSize]];
            [attackable addObject:colorlayer];
            [atklayer addChild:colorlayer z:10];
        }
        if (dir==2) {
            CGPoint attackpos;
            CCSprite* colorlayer = [CCSprite spriteWithImageNamed:@"maphud.png"];
            attackpos = CGPointMake(pos.x, pos.y-i-1);
            colorlayer.opacity = 0.8;
            colorlayer.position = [self convertToMapCord:attackpos] ;
            //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
            [colorlayer setContentSize: [ _map tileSize]];
            [attackable addObject:colorlayer];
            [atklayer addChild:colorlayer z:10];
        }
        if (dir==3) {
            CGPoint attackpos;
            CCSprite* colorlayer = [CCSprite spriteWithImageNamed:@"maphud.png"];
            attackpos = CGPointMake(pos.x-i-1, pos.y);
            colorlayer.opacity = 0.8;
            colorlayer.position = [self convertToMapCord:attackpos] ;
            //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
            [colorlayer setContentSize: [ _map tileSize]];
            [attackable addObject:colorlayer];
            [atklayer addChild:colorlayer z:10];
        }
        if (dir==4) {
            CGPoint attackpos;
            CCSprite* colorlayer = [CCSprite spriteWithImageNamed:@"maphud.png"];
            attackpos = CGPointMake(pos.x+i+1, pos.y);
            colorlayer.opacity = 0.8;
            colorlayer.position = [self convertToMapCord:attackpos] ;
            //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
            [colorlayer setContentSize: [ _map tileSize]];
            [attackable addObject:colorlayer];
            [atklayer addChild:colorlayer z:10];
        }
        
    }
    
    //CCLOG(@"render");
}

-(int)getAttackDir:(CGPoint)pos WithWugong:(Wugong*)m_wugong
{
    int range = m_wugong.range;
    int maxhit = -999;
    int dir = 0;
    if (m_wugong.rangeType==2) {
        //this is the case attack type is linear
        int currentmaxhit = 0;
        for (int i = 0 ; i<range; i++) {
            CGPoint hitpos = CGPointMake(pos.x, pos.y-1-i);
            for (Invader* inv in _enemy) {
                if (inv.isDead) {
                    continue;
                }
                if (CGPointEqualToPoint(inv.position, hitpos)) {
                    currentmaxhit ++;
                }
            }
        }
        if (currentmaxhit>maxhit) {
            maxhit = currentmaxhit;
            dir = 2;
        }
        currentmaxhit = 0;
        for (int i = 0 ; i<range; i++) {
            CGPoint hitpos = CGPointMake(pos.x, pos.y+1+i);
            for (Invader* inv in _enemy) {
                if (inv.isDead) {
                    continue;
                }
                if (CGPointEqualToPoint(inv.position, hitpos)) {
                    currentmaxhit ++;
                }
            }
        }
        if (currentmaxhit>maxhit) {
            maxhit = currentmaxhit;
            dir = 1;
        }
        currentmaxhit = 0;
        for (int i = 0 ; i<range; i++) {
            CGPoint hitpos = CGPointMake(pos.x-1-i, pos.y);
            for (Invader* inv in _enemy) {
                if (inv.isDead) {
                    continue;
                }
                if (CGPointEqualToPoint(inv.position, hitpos)) {
                    currentmaxhit ++;
                }
            }
        }
        if (currentmaxhit>maxhit) {
            maxhit = currentmaxhit;
            dir = 3;
        }
        currentmaxhit = 0;
        for (int i = 0 ; i<range; i++) {
            CGPoint hitpos = CGPointMake(pos.x+1+i, pos.y);
            for (Invader* inv in _enemy) {
                if (inv.isDead) {
                    continue;
                }
                if (CGPointEqualToPoint(inv.position, hitpos)) {
                    currentmaxhit ++;
                }
            }
        }
        if (currentmaxhit>maxhit) {
            maxhit = currentmaxhit;
            dir = 4;
        }
        
    }
    return dir;

}
-(NSValue*)getMaxAttackPosWithWugong:(Wugong*)m_wugong
{
    CGPoint maxpos;
    int maxhit=-999;
    
    for (NSValue* val in reachable) {
        int hit = [self getMaxAttackForSinglePos: [val CGPointValue] WithWugong:m_wugong];
        if (hit>maxhit) {
            maxpos = [val CGPointValue];
            maxhit = hit;
        }
    }
    if (maxhit<=0) {
        return nil;
    }
    return [NSValue valueWithCGPoint: maxpos];
}

-(int)getMaxAttackForSinglePos:(CGPoint)pos WithWugong:(Wugong*) m_wugong
{
    int range = m_wugong.range;
    int maxhit = -999;
    if (m_wugong.rangeType==2) {
        //this is the case attack type is linear
        int currentmaxhit = 0;
        for (int i = 0 ; i<range; i++) {
            CGPoint hitpos = CGPointMake(pos.x, pos.y-1-i);
            for (Invader* inv in _enemy) {
                if (inv.isDead) {
                    continue;
                }
                if (CGPointEqualToPoint(inv.position, hitpos)) {
                    currentmaxhit ++;
                }
            }
        }
        if (currentmaxhit>maxhit) {
            maxhit = currentmaxhit;
        }
        currentmaxhit = 0;
        for (int i = 0 ; i<range; i++) {
            CGPoint hitpos = CGPointMake(pos.x, pos.y+1+i);
            for (Invader* inv in _enemy) {
                if (inv.isDead) {
                    continue;
                }
                if (CGPointEqualToPoint(inv.position, hitpos)) {
                    currentmaxhit ++;
                }
            }
        }
        if (currentmaxhit>maxhit) {
            maxhit = currentmaxhit;
        }
        currentmaxhit = 0;
        for (int i = 0 ; i<range; i++) {
            CGPoint hitpos = CGPointMake(pos.x-1-i, pos.y);
            for (Invader* inv in _enemy) {
                if (inv.isDead) {
                    continue;
                }
                if (CGPointEqualToPoint(inv.position, hitpos)) {
                    currentmaxhit ++;
                }
            }
        }
        if (currentmaxhit>maxhit) {
            maxhit = currentmaxhit;
        }
        currentmaxhit = 0;
        for (int i = 0 ; i<range; i++) {
            CGPoint hitpos = CGPointMake(pos.x+1+i, pos.y);
            for (Invader* inv in _enemy) {
                if (inv.isDead) {
                    continue;
                }
                if (CGPointEqualToPoint(inv.position, hitpos)) {
                    currentmaxhit ++;
                }
            }
        }
        if (currentmaxhit>maxhit) {
            maxhit = currentmaxhit;
        }
        
    }
    return maxhit;
}

-(void)autoMove
{
    CCActionCallFunc* callback = [CCActionCallFunc actionWithTarget:self selector:@selector(endOfAction)];
    Invader* nearestEnemy = [self getNearestEnemy];
    CGPoint despoint = [self getDesPoint:nearestEnemy.position];
    CCActionFiniteTime* action = [self buildCCActionMovArrFrom:self.position To:despoint];
    [actions addObject:action];
    //CCActionSequence* actions = [CCActionSequence actions:action, callback, nil];
    //[_bigIcon runAction:actions];
    self.position = despoint;
    [self rest];

}
-(void)autoEscape
{
    CCActionCallFunc* callback = [CCActionCallFunc actionWithTarget:self selector:@selector(endOfAction)];
    CGPoint despoint = [self getSafePoint];
    CCActionFiniteTime* action = [self buildCCActionMovArrFrom:self.position To:despoint];
    [actions addObject:action];
    //CCActionSequence* actions = [CCActionSequence actions:action, callback, nil];
    //[_bigIcon runAction:actions];
    self.position = despoint;
}
-(CGPoint)getSafePoint
{
    int steps = -999;
    CGPoint ret = self.position;
    for (NSValue* v in reachable) {
        CGPoint p = [v CGPointValue];
        int minstep = 999;
        for (Invader* em in _enemy) {
            int temp = abs(em.position.x-p.x)+abs(em.position.y-p.y);
            if (temp<minstep) {
                minstep = temp;
            }
        }
        if (minstep>steps) {
            steps = minstep;
            ret = [v CGPointValue];
        }
    }
    
    return ret;
}
-(CGPoint)getDesPoint:(CGPoint) enemyPos
{
    CGPoint ret;
    int nearestDis = 999;
    for (NSValue* v in reachable) {
        //CCLOG(@"%@",v);
        CGPoint p = [v CGPointValue];
        int dis = abs(p.x - enemyPos.x)+abs(p.y-enemyPos.y);
        if (dis < nearestDis) {
            ret = p;
            nearestDis = dis;
        }

    }
    
    return ret;
}
-(CCActionFiniteTime*)buildCCActionMovArrFrom:(CGPoint)startPos To:(CGPoint) endPos
{
    NSMutableArray* motionArr = [[NSMutableArray alloc]init];
    NSValue* startVal = [NSValue valueWithCGPoint:startPos];
    NSValue* endVal = [NSValue valueWithCGPoint:endPos];
    NSValue* previous = endVal;
    NSValue* next;
    while (true) {
        next = [reachableLookup objectForKey:previous];
        CGPoint pos = [previous CGPointValue];
        CGPoint convertedPos = [self convertToMapCord:pos];
        CCActionMoveTo* moveTo = [CCActionMoveTo actionWithDuration:0.3 position:convertedPos];
        [motionArr insertObject:moveTo atIndex:0];
        
        if ([previous isEqualToValue:startVal]) {
            break;
        }
        
        previous = next;
    }
    
    CCActionSequence* actions = [CCActionSequence actionWithArray:motionArr];
    

    return actions;
}

-(Invader*)getNearestEnemy
{
    Invader* ret;
    int nearestDis = 999;
    for (Invader* inv in _enemy) {
        if (inv.isDead) {
            continue;
        }
        int dis = abs(inv.position.x - self.position.x)+abs(inv.position.y-self.position.y);
        if (dis < nearestDis) {
            ret = inv;
            nearestDis = dis;
        }
    }
    
    return ret;
}
-(void)endOfBattle
{
   
}


-(void)clearReachableRender
{
    CCNode* reachableRender =[_map getChildByName:@"reachable" recursively:NO];
    if (reachableRender) {
        [reachableRender removeAllChildren];
        [_map removeChildByName:@"reachable"];
    }

    
    //attack layer TODO
    CCNode* attackRenderer =[_map getChildByName:@"attackLayer" recursively:NO];
    if (attackRenderer) {
        [attackRenderer removeAllChildren];
        [_map removeChildByName:@"attackLayer"];
    }

}

-(void)renderReachable
{
    CCNode* reachablelayer = [CCNode node];
    reachablelayer.position = _map.position;
    [_map addChild:reachablelayer z:1 name:@"reachable"];
    for (NSValue* val in reachable) {
        CCSprite* colorlayer = [CCSprite spriteWithImageNamed:@"maphud.png"];
        colorlayer.opacity = 0.2;
        colorlayer.position = [self convertToMapCord:[val CGPointValue]] ;
        //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
        [colorlayer setContentSize: [ _map tileSize]];

        [reachablelayer addChild:colorlayer z:10];
    }
}

-(void)buildReachable:(int)movenum
{
    [reachable removeAllObjects];
    NSMutableArray* frontier = [[NSMutableArray alloc]init];
    NSMutableDictionary* movenumLookup = [[NSMutableDictionary alloc]init];
    
    NSValue* posval =[NSValue valueWithCGPoint:self.position ];
    [frontier addObject: posval];
    [reachable addObject:posval];
    [reachableLookup setObject:posval forKey:posval];
    [movenumLookup setObject: [NSNumber numberWithInt:movenum]  forKey:posval];
    while (true) {
        
        if ([frontier count]==0) {
            return;
        }
        
        NSValue *val = [frontier objectAtIndex:0];
        
        NSNumber *number = [movenumLookup objectForKey:val];
        int m_move = [number intValue];
        
        if (m_move==0) {
            return;
        }
        
        CGPoint position = [val CGPointValue];
        [frontier removeObjectAtIndex:0];
        
        int x = position.x;
        int y = position.y;
        
        CGPoint p1 = CGPointMake(x-1, y);
        CGPoint p2 = CGPointMake(x, y+1);
        CGPoint p3 = CGPointMake(x+1, y);
        CGPoint p4 = CGPointMake(x, y-1);
        
        NSValue* v1 = [NSValue valueWithCGPoint:p1];
        NSValue* v2 = [NSValue valueWithCGPoint:p2];
        NSValue* v3 = [NSValue valueWithCGPoint:p3];
        NSValue* v4 = [NSValue valueWithCGPoint:p4];
        
        NSArray* arr = [[NSArray alloc]initWithObjects:v1,v2,v3,v4,nil];
        
        for (NSValue* val2 in arr) {
            CGPoint p = [val2 CGPointValue];
            if (p.x<0||p.x>_map.mapSize.width-1) {
                continue;
            }
            if (p.y<0||p.y>_map.mapSize.height-1) {
                continue;
            }
            
            /**
             check if any invader in that position
             **/
            bool flag = false;
            for (Invader* teammate in _allie) {
                if (teammate.isDead) {
                    continue;
                }
                if ([val2 isEqualToValue:[NSValue valueWithCGPoint:teammate.position]]) {
                    flag = true;
                }
            }
            for (Invader* opponent in _enemy) {
                if (opponent.isDead) {
                    continue;
                }
                if ([val2 isEqualToValue:[NSValue valueWithCGPoint:opponent.position]]) {
                    flag = true;
                }
            }
            if (flag) {
                continue;
            }
            

            if (![reachable containsObject:val2]) {
                [frontier addObject: val2];
                [reachable addObject:val2];
                [movenumLookup setObject: [NSNumber numberWithInt:m_move-1]  forKey:val2];
                [reachableLookup setObject:val forKey:val2];
            }

        }
        /**
        if (![reachable containsObject:[NSValue valueWithCGPoint:p1 ]]) {
            [frontier addObject: [NSValue valueWithCGPoint:p1 ]];
            [reachable addObject:[NSValue valueWithCGPoint:p1 ]];
            [movenumLookup setObject: [NSNumber numberWithInt:m_move-1]  forKey:[NSValue valueWithCGPoint:p1 ]];
        }
        
        if (![reachable containsObject:[NSValue valueWithCGPoint:p2 ]]) {
            [frontier addObject: [NSValue valueWithCGPoint:p2 ]];
            [reachable addObject:[NSValue valueWithCGPoint:p2 ]];
            [movenumLookup setObject: [NSNumber numberWithInt:m_move-1]  forKey:[NSValue valueWithCGPoint:p2 ]];
        }
        
        if (![reachable containsObject:[NSValue valueWithCGPoint:p3 ]]) {
            [frontier addObject: [NSValue valueWithCGPoint:p3 ]];
            [reachable addObject:[NSValue valueWithCGPoint:p3 ]];
            [movenumLookup setObject: [NSNumber numberWithInt:m_move-1]  forKey:[NSValue valueWithCGPoint:p3 ]];
        }
        
        if (![reachable containsObject:[NSValue valueWithCGPoint:p4 ]]) {
            [frontier addObject: [NSValue valueWithCGPoint:p4 ]];
            [reachable addObject:[NSValue valueWithCGPoint:p4 ]];
            [movenumLookup setObject: [NSNumber numberWithInt:m_move-1]  forKey:[NSValue valueWithCGPoint:p4 ]];
        }**/
    }
    
}

-(void)say:(NSString*)sentence WithColor:(CCColor*)color{
    CCLabelTTF* words = [CCLabelTTF labelWithString:sentence fontName:@"Verdana-Bold" fontSize:12];
    [words setColorRGBA:color];
    words.position = [self convertToMapCord:self.position];
    words.position = CGPointMake(words.position.x-words.contentSize.width/2, words.position.y);
    words.anchorPoint = CGPointMake(0, 0.5);
    [_map.parent addChild:words z:100];
    CCActionMoveBy* moveUp = [CCActionMoveBy actionWithDuration:1 position:CGPointMake(0,2*words.contentSize.height)];
    CCActionCallFunc* delete = [CCActionCallFunc actionWithTarget:words selector:@selector(removeFromParent)];
    CCActionSequence* actions = [CCActionSequence actions:moveUp, delete, nil];
    [words runAction:actions];
}
-(void)show:(NSString*)sentence WithColor:(CCColor*)color{
    CCLabelTTF* words = [CCLabelTTF labelWithString:sentence fontName:@"Verdana-Bold" fontSize:20];
    [words setColorRGBA:color];
    words.position = [self convertToMapCord:CGPointMake(10, 10)];
    words.position = CGPointMake(words.position.x-words.contentSize.width/2, words.position.y);
    words.anchorPoint = CGPointMake(0, 0.5);
    //CCScene* effectScene = [CCScene node];
    [_map.parent addChild:words z:100 name:@"show"];
    //_bigIcon.paused  = YES;
    [_map.parent pauseAction];
    
    CCActionMoveBy* moveUp = [CCActionMoveBy actionWithDuration:1 position:CGPointMake(0,0)];
    CCActionSequence* actions = [CCActionSequence actions:moveUp, nil];
    [words runAction:actions];
    

}
-(void)endShow
{
    [_bigIcon setPaused:NO];
    //CCLOG(@"waiting %i", _isShowing);
}

#pragma mathfunction
-(float)getnewmove
{
    if (_agile>=150){
        return 7+(_agile-150)/80;
    }
    else if (_agile>=70){
        return 5+(_agile-70)/40;
    }
    else if (_agile>=30){
        return 3+(_agile-30)/20;
    }
    else{
        return	_agile/10;
    }
}
-(void)calculateNewJiqiSpeed
{
    float basepoint = 5;
    float acumebuff = [self acumeJiQiBuff:_acume :_maxacume];
    float agilebuff = [self agileJiQiBuff:_agile];
    float poisionbleedbuff = [self JiQiBuffpoision:_poision AndBleed:_bleed];
    float staminabuff = [self JiQiBuffStamina:_stamina];

    int newspeed = (int)((acumebuff + agilebuff + poisionbleedbuff + staminabuff + basepoint)*_willingToFight/100);
    //CCLOG(@"%f",_jiqispeed);
    if (_angryRate>=100) { //战意》100 集气翻倍
        newspeed *=2;
    }
    _jiqispeed = newspeed;
}
-(float)acumeJiQiBuff:(int)acume :(int) maxacume{
    float x=(acume*2+maxacume)/3.0;
    //x=2*x;//double
    if(x>5600){
        return 8 + MIN((x-5000)/1200,3);
    }
    else if(x>3600){
        return 6 + (x-3600)/1000;
    }
    else if(x>2000){
        return 4 + (x-2000)/800;
    }
    else if(x>800){
        return 2+(x-800)/600;
    }
    else{
        return x/400;
    }
}
-(int)initAmountOfJiqi
{
    int amount =  _agile*1.5;
    //武功可能提升初试集气
    if (_taijian) {
        amount -= 200;
    }
    for (Wugong* wg in wugong) {
        amount = [wg effectInitAmountJiqi:amount WithInvader:self WithWugong:wg];
    }

    return MIN(amount,1000);
}
-(float)JiQiBuffpoision:(float)poision AndBleed:(float)bleed{
    return -poision/25.0-bleed/10.0;
}
-(float)JiQiBuffStamina:(float)stamina
{
    return stamina/30.0;
}
-(float)agileJiQiBuff:(float)agile
{
    //agile = 2*agile; //double
    if (agile>=160){
        return 6+(agile-160)/60.0;
    }
    else if (agile>=80){
        return 4+(agile-80)/40.0;
    }
    else if (agile>=30){
        return 2+(agile-30)/25.0;
    }
    else{
        return	agile/15.0;
    }
}
-(void)calculatePoisionAndBleed
{
    if (_poision>0) {
        _health-=_poision/3;
    }
    if (_bleed>0) {
        _health-=_bleed/20;
    }
    if (_health<=0) {
        _health=1;
    }
}
-(BOOL)triggerLiansuoEffectWithProbility:(int)p
{
    Invader* person = self;
	float probility = p;
    //general equation
    probility = p+ person.agile/8;
    //acume effect
    //CCLOG(@"pro: %f",probility);
    probility=probility+MIN((person.acume/500),20);
    probility *= person.willingToFight/100;
    if (CCRANDOM_0_1()*100<=probility) {
        return true;
    }else{
        float luck = person.talent;
        probility = probility + person.acume/400;
        if (CCRANDOM_0_1()*100<=luck) {
            if (CCRANDOM_0_1()*100<=probility) {
                return true;
            }
        }
    }
    return false;
}
-(BOOL)triggerBaojiEffectWithProbility:(int)p
{
    Invader* person = self;
	float probility = p;
    //general equation
    probility = p+ person.attack/8+person.stamina/20;
    //acume effect
    //CCLOG(@"pro: %f",probility);
    probility=probility+MIN((person.acume/500),20);
    
    if (CCRANDOM_0_1()*100<=probility) {
        return true;
    }else{
        return false;
    }

}
//attack may trigger special effect sometime for certaion wugong
-(BOOL)triggerSpecialEffectWithProbility:(int) p// Invader:(Invader*) person
{
    Invader* person = self;
	float probility = p;
    //general equation
    probility = p+ person.maxhealth*4/(person.health+20)+person.stamina/20;
    //acume effect
    //CCLOG(@"pro: %f",probility);
    probility=probility+MIN((person.acume/500),20);
    //CCLOG(@"p: %f", probility);
	int times=1;

    if ((CCRANDOM_0_1()*120-10)>person.talent){
        times=2;
    }
    for (int i = 0;  i < times; i++) {
        float bd = CCRANDOM_0_1()*120+10;
        if (bd<probility) {
            return true;
        }
    }
    //CCLOG(@"pro: %f",probility);
    //CCLOG(@"p: %i",p);
    if (CCRANDOM_0_1()*100<=probility) {
        return true;
    }else{
        float luck = 100 - person.talent;
        probility = probility + person.acume/400;
        if (CCRANDOM_0_1()*100<=luck) {
            if (CCRANDOM_0_1()*100<=probility) {
                return true;
            }
        }
    }
	return false;

}

-(NSMutableDictionary*)calculateWugongHurtLifeWithWugong:(Wugong*)wu WithInvader:(Invader*) beingAttacked WithAttakNg:(int) ang WithAWugong:(Wugong*) awugong
{
    //武功伤害生命
    //enemyid 敌人战斗id，
    //wugong  我方使用武功
    //返回：伤害点数
    NSMutableDictionary* hurtDic = [[NSMutableDictionary alloc]init];
    
    Invader* pid=self;
    Invader* eid=beingAttacked;
    int level = wu.level;
    //--计算武学常识
    int mywuxue=_wuxueKnowledge;
    int emenywuxue=0;
    for (Invader* al in _allie) {
        if (!al.isDead) {
            if (al.wuxueKnowledge>mywuxue) {
                mywuxue = al.wuxueKnowledge;
            }
        }
    }
    
    for (Invader* en in _enemy) {
        if (!en.isDead) {
            if (en.wuxueKnowledge>emenywuxue) {
                mywuxue = en.wuxueKnowledge;
            }
        }
    }
    // enhance enemy ability
	/**
    if (emenywuxue<50) {
        emenywuxue = 50;
    }
    **/
        
    //    --计算实际使用武功等级
    while (true) {
        if (((level+1)/2)*wu.acumeCost > pid.acume){
            level-=1;
        }else{
            break;
        }
    }
    
    if (level<=0){     //--防止出现左右互博时第一次攻击完毕，第二次攻击没有内力的情况。
	    level=1;
    }
    
    //neigong hu ti
    int dng=0;
    Wugong* dwugong=nil;
    for (Wugong* eidWugong in eid.wugongArr) {
        if ([eidWugong isNeiGong]) {
            if ([eid triggerSpecialEffectWithProbility:10]) {
                int damage = eidWugong.neigongHuTi;
                if (damage > dng) {
                    dng = damage;
                    dwugong = eidWugong;
                    //TODO 内功护体
                }
            }
        }
    }
    

    
    if (dwugong) {
        NSString* words = [NSString stringWithFormat:@"%@%@",[dwugong getWugongName],@"\n护体!" ];
        [eid say:words WithColor:[CCColor colorWithCcColor3b:ccWHITE]];
    }
    
    
    float wugongDamage =((float)[[wu.damage objectAtIndex:10]integerValue]);
    for (Wugong* wg in pid.wugongArr) {
       // if ([wg isNeiGong]) {
            wugongDamage = [wg effectWugongDamage:wugongDamage WithInvader:self WithWugong:wu];
       // }
    }

    float hurt = 0;
    if (level > 10) {
        hurt = wugongDamage /3.0;
        level = 10;
    }else{
        hurt = wugongDamage/4.0;
    }
    
    //CCLOG(@"!!!!!HERE:%f",hurt);
    
    if (false) {
        //Attack item goes here TODO
    }
	
    int atk = pid.attack;
    int def = eid.armor;
	
    //pair attackadd goes here example: yangguo xiaolongnv
	//xxxx
    
    //pair defadd goes here example : yangguo xiaolongnv
    //xxxxx
    
	atk = atk * ((pid.acume*2+pid.maxacume)/3)/50;
    hurt = hurt + atk/4;

	hurt=hurt+(mywuxue-emenywuxue)/2;
    //CCLOG(@"2:%f",hurt);
	
	def=def*((eid.acume*2+eid.maxacume)/3)/40+emenywuxue;
    
	//meigong jia li TODO
    atk=atk+mywuxue+pid.mainNeiGong.neigongJiaLi/10;
    
    if ((atk+def)!=0) {
        hurt=hurt*atk/(atk+def);
    }
    /** wuqi and fangjv
	local function myrnd(x)
	if x<=1 then return 0 end
        return math.random(x*0.5,x)
        end
        
        if JY.Person[pid]["武器"]>=0 then
            hurt=hurt+myrnd(JY.Thing[JY.Person[pid]["武器"]]["加攻击力"]);
    end
    if JY.Person[pid]["防具"]>=0 then
        hurt=hurt+myrnd(JY.Thing[JY.Person[pid]["防具"]]["加攻击力"]);
    end
    if JY.Person[eid]["武器"]>=0 then
        hurt=hurt-myrnd(JY.Thing[JY.Person[eid]["武器"]]["加防御力"]);
    end
    if JY.Person[eid]["防具"]>=0 then
        hurt=hurt-myrnd(JY.Thing[JY.Person[eid]["防具"]]["加防御力"]);
    end
	**/
    //CCLOG(@"0:%f",hurt);
	hurt=hurt-def/8;
	//CCLOG(@"1:%f",hurt);
    hurt=hurt-dng/30+pid.stamina/5-eid.stamina/5+eid.bleed/3-pid.bleed/3+eid.poision/2-pid.poision/2;

    
    // --考虑距离因素
    float offset = ccpDistance(pid.position, eid.position);
    if (offset<10) {
        hurt = hurt * (100-(offset-1)*3)/100;
    }else{
        hurt = hurt*2/3;
    }
   	
    //考虑敌人拳剑刀te
    float defendadded = 0;
    if ([wu isQuanFa]) {
        defendadded = eid.quanFa;
    }else if([wu isJianFa])
    {
        defendadded = eid.jianFa;
    }else if([wu isDaoFa])
    {
        defendadded = eid.daoFa;
    }else if([wu isQimen])
    {
        defendadded = eid.qiMen;
    }
    hurt = hurt*MAX(MIN((1.2 - defendadded/240.0),1.2),0.2);
    
    //bleed effects
	hurt=hurt*(1-pid.bleed*0.002);
    hurt=hurt*(1+eid.bleed*0.0015);
    
    //CCLOG(@"2:%f",hurt);
    /**poision
                        --敌人中毒点数
                                        local poisonnum=math.modf(level*JY.Wugong[wugong]["敌人中毒点数"]+5*JY.Person[pid]["攻击带毒"]);
    
    if 10*JY.Person[eid]["抗毒能力"]< poisonnum and dng==0 and pid~=48 then
        poisonnum=math.modf(poisonnum/10-JY.Person[eid]["抗毒能力"]-JY.Person[eid]["内力"]/150)
        if poisonnum<0 then poisonnum=0 end
            AddPersonAttrib(eid,"中毒程度",myrnd(poisonnum));
    end
    
	WAR.NGHT=0
	WAR.FLHS4=0
	
	if PersonKF(eid,108) then JY.Person[eid]["中毒程度"]=0 end
        --if PersonKF(eid,100) then JY.Person[eid]["受伤程度"]=0 end
            
            if WAR.Person[emenyid][CC.TXWZ2]==nil then WAR.Person[emenyid][CC.TXWZ2]='  ' end
                if DWPD()==false then
                    WAR.Person[emenyid][CC.TXDH]=-1
                    WAR.Person[emenyid][CC.TXWZ1]=nil
                    WAR.Person[emenyid][CC.TXWZ2]=nil
                    WAR.Person[emenyid][CC.TXWZ3]=nil
                    end
                    
                    --WAR.Person[emenyid][CC.TXDH]=math.fmod(107,10)+85
    **/
    if (awugong) {
        //内功加力时触发所有武功特效
        for (Wugong* wg in pid.wugongArr) {
            //if ([wg isNeiGong]) {
                hurt = [wg effectNeiGongJiaLiHurt:hurt WithInvader:self WithWugong:wu];
           // }
        }
    }
 
    [hurtDic setValue:[NSNumber numberWithInt:hurt] forKey:@"hurt"];
    
    ang = ang-dng;
    if (ang<=0) {
        dng = dng - ang;
        ang = 0;
    }else{
        dng = 0;
    }
    
    //Calculate spdhurt
    int spdhurt = 0;
    if (dng == 0) {//no neigong protect
        spdhurt += ang/8;

        int damageConvertToSpdHurt = hurt*0.7;
        
        for (Wugong* wg in eid.wugongArr) {
            //if ([wg isNeiGong]) {
                damageConvertToSpdHurt = [wg effectDefendDamageConvertToSpdHurt:damageConvertToSpdHurt WithInvader:self WithWugong:wu];
            //}
        }
        spdhurt += damageConvertToSpdHurt;
    }
    //CCLOG(@"spdhurt: %i",spdhurt);
    
    if (awugong) {
            //内功加力时触发所有武功特效
        for (Wugong* wg in pid.wugongArr) {
           // if ([wg isNeiGong]) {
                spdhurt = [wg effectNeiGongJiaLiSpdHurt:spdhurt WithInvader:self WithWugong:wu];
           // }
        }
    }
    
    [hurtDic setValue:[NSNumber numberWithInt:spdhurt] forKey:@"spdhurt"];
    //内伤
    int bleedhurt = hurt/8;
    if (dwugong) {
        //内功加力时触发所有武功特效
        for (Wugong* wg in eid.wugongArr) {
           // if ([wg isNeiGong]) {
                bleedhurt = [wg effectNeiGongHuTiBleedHurt:bleedhurt WithInvader:self WithWugong:wu];
           // }
        }
    }
    [hurtDic setValue:[NSNumber numberWithInt:bleedhurt] forKey:@"bleedhurt"];
    //封穴
    int fengxuehurt = MAX(hurt/120.0,0.5)*wu.fengXueIndex;
    if (awugong) {
        //内功加力时触发所有武功特效
        for (Wugong* wg in pid.wugongArr) {
           // if ([wg isNeiGong]) {
                fengxuehurt = [wg effectNeiGongJiaLiFengXueHurt:fengxuehurt WithInvader:self WithWugong:wu];
           // }
        }
    }
    for (Wugong* wg in eid.wugongArr) {
       // if ([wg isNeiGong]) {
            fengxuehurt = [wg effectDefendFengXue:fengxuehurt WithInvader:self WithWugong:wu];
       // }
    }
    [hurtDic setValue:[NSNumber numberWithInt:fengxuehurt] forKey:@"fengxuehurt"];
    //流血
    int liuxuehurt = MAX(hurt/120.0,0.5)*wu.bleedIndex;
    [hurtDic setValue:[NSNumber numberWithInt:liuxuehurt] forKey:@"liuxuehurt"];
    
    int poisionnum = _attackHasPoisionIndex*5 + wu.poision*level;
    if (10*eid.antiPoisionIndex<poisionnum && dng==0) {
        poisionnum = poisionnum/10 - eid.antiPoisionIndex - eid.acume/150;
        if (poisionnum<0) {
            poisionnum = 0;
        }
        poisionnum = poisionnum/2 + CCRANDOM_0_1()*poisionnum/2;
    }
    
    if (awugong) {
        //内功加力时触发所有武功特效
        for (Wugong* wg in pid.wugongArr) {
           // if ([wg isNeiGong]) {
                poisionnum = [wg effectNeiGongJiaLiPoisionHurt:poisionnum WithInvader:self WithWugong:wu];
           // }
        }
    }
    for (Wugong* wg in eid.wugongArr) {
       // if ([wg isNeiGong]) {
            poisionnum = [wg effectDefendPoision:poisionnum WithInvader:self WithWugong:wu];
       // }
    }

    [hurtDic setValue:[NSNumber numberWithInt:poisionnum] forKey:@"poisionhurt"];

    
    int angryhurt = 0;
    if (awugong) {
        //内功加力时触发所有武功特效
        for (Wugong* wg in pid.wugongArr) {
           // if ([wg isNeiGong]) {
                angryhurt = [wg effectNeiGongJiaLiAngryHurt:poisionnum WithInvader:self WithWugong:wu];
           // }
        }
    }
    [hurtDic setValue:[NSNumber numberWithInt:angryhurt] forKey:@"angryhurt"];
    //calculate poision and other stuff TODO
    return hurtDic;
}
-(void)updateJiQi
{
    [self calculateNewJiqiSpeed];
    int jiqi = _jiqispeed;
    if (_fengXue>0) {
        _fengXue-=1;
        jiqi = 0;
    }
    if (_liuXue>0) {
        _liuXue-=1;
        int hurt = CCRANDOM_0_1()*4*_bleed/100+1;
        _health -= hurt;
    }
    _amountofjiqi += jiqi;
    for (Wugong* wg in wugong) {
       // if ([wg isNeiGong]) {
            [wg effectInUpdateJiQi:self];
       // }
    }
}

@end
