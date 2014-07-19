//
//  Invader.m
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Invader.h"

@implementation Invader
@synthesize strength = _strength;
@synthesize agile =_agile;
@synthesize wisdom = _wisdom;
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
    [self initWuGong];
    [self initIcon];
    return self;
}
-(void)initIcon
{
    _bigIcon = [CCSprite spriteWithImageNamed:@"Enemy1.png"];
    _smallIcon = [CCSprite spriteWithImageNamed:@"Enemy1.png"];
}
-(void)initWuGong
{
    Wugong* basic = [Wugong node];
    [wugong addObject:basic];
}
-(void)initForBattleWithParent:(CCNode *)parent
{
    _amountofjiqi = [self initAmountOfJiqi];
    _health = _maxhealth;
    _acume = _maxacume;
    _stamina = 100;
    _poision = 0;
    _bleed = 0;
    _angryRate = 80;
    
    [self calculateNewJiqiSpeed];
    //variable init
    _isDead=false;
    _isDefending=false;
    //self.runningInActiveScene = YES;
    [parent addChild:_bigIcon];
    
    //init state hud
    [self initStateWithParent:parent];
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

-(void)endOfAction
{
    
    [self clearReachableRender];
    
    [self calculatePoisionAndBleed];
    //CCLOG(@"endofAct");
    [_smallIcon.parent schedule:@selector(startJiqi:) interval:0.02];
    //CCLOG(@"end of action");
    
    //set statehud visible to no
    _state.visible = NO;
    //[self addChild:_smallIcon];
}
-(void)prepareForAction
{
    int movenum = [self getnewmove]- ((float)_poision)/50.0 - ((float)_bleed)/60.0 + ((float)_health)/70.0 -1.0;
    if (movenum<1) {
        movenum = 1;
    }
    [self buildReachable:movenum];
    //CCLOG(@"%i",movenum);
    //CCLOG(@"%@",reachable);
    [self renderReachable];
    
    //set statehud visible to yes
    _state.visible = YES;
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
    if (![self enemyAlive]||self.isDead) {
        [self endOfAction];
        return;
    }
    
    //try attack fitst, if fails than choose to move
    Wugong* choosedWugong = [self autoChooseWugong];
    NSValue* val =[self getMaxAttackPosWithWugong:choosedWugong];
    if (val) {
        CGPoint pos = [val CGPointValue];
        [self autoAttack:pos WithWugong:choosedWugong];
    }else{
        [self autoMove];
    }
}

-(Wugong*)autoChooseWugong
{
    int index = CCRANDOM_0_1()*wugong.count;
    Wugong* ret = [wugong objectAtIndex:index];
    return ret;
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
    CCActionSequence* actions = [CCActionSequence actions:action,render,
                                 attackInvaders, delay, callback, nil];
    [_bigIcon runAction:actions];
    
    
    //release invaders
    invadersBeingAttacked = nil;
}

-(void)attackInvaders:(NSMutableArray *)invaders WithWuGong:(Wugong *)m_wugong
{
    for (Invader* inv in invaders) {
        inv.isDefending = TRUE;
        [inv defendInvader:self WhoUseWuGong:m_wugong];
        while (inv.isDefending) {
            //do nothing, wait
        }
    }
}

-(void)defendInvader:(Invader *)invader WhoUseWuGong:(Wugong *)m_wugong
{
    //do things success
    //CCLOG(@"im defending");
    NSDictionary* hurtDic = [invader calculateWugongHurtLifeWithWugong:m_wugong WithInvader:self];
    
    int hurt = [[hurtDic objectForKey:@"hurt"]intValue];
    int spdhurt = [[hurtDic objectForKey:@"spdhurt"]intValue];
    
    //CCLOG(@"%i\n%i",hurt,spdhurt);
    
    //int spdhurt = [invader calculateWugongHurtJiQiWithHurt:hurt WithInvader:self];
    [self say:[NSString stringWithFormat:@"-%i",hurt] WithColor: [CCColor colorWithCcColor3b:ccRED]];
    self.health -= hurt;
    CCLabelTTF* healthbar = (CCLabelTTF*)[self.state getChildByName:@"health" recursively:NO];
    [healthbar setString: [NSString stringWithFormat:@"%i", self.health]];
    
    //shajiqi
    _amountofjiqi -= spdhurt;
    
    [((CCScene*)_map.parent) notifyJiQiChangedForInvader:self];
    if (self.health<=0) {
        self.isDead=true;
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
        CGPoint attackpos;
        CCSprite* colorlayer = [CCSprite spriteWithImageNamed:@"maphud.png"];
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
        colorlayer.opacity = 0.8;
        colorlayer.position = [self convertToMapCord:attackpos] ;
        //colorlayer.anchorPoint = CGPointMake(-0.5, 0.5);
        [colorlayer setContentSize: [ _map tileSize]];

        [atklayer addChild:colorlayer z:10];
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
    CCActionSequence* actions = [CCActionSequence actions:action, callback, nil];
    [_bigIcon runAction:actions];
    self.position = despoint;

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
    [_map addChild:words z:100];
    CCActionMoveBy* moveUp = [CCActionMoveBy actionWithDuration:1 position:CGPointMake(0,2*words.contentSize.height)];
    CCActionCallFunc* delete = [CCActionCallFunc actionWithTarget:words selector:@selector(removeFromParent)];
    CCActionSequence* actions = [CCActionSequence actions:moveUp, delete, nil];
    [words runAction:actions];
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

    int newspeed = (int)((acumebuff + agilebuff + poisionbleedbuff + staminabuff + basepoint)*_angryRate/100);
    //CCLOG(@"%f",_jiqispeed);
    //if (_angryRate>=100) { //战意》100 集气翻倍
    //    newspeed *=2;
    //}
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
    return _agile*1.5;
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
//attack may trigger special effect sometime for certaion wugong
-(BOOL)triggerSpecialEffectWithProbility:(int) p// Invader:(Invader*) person
{
    Invader* person = self;
	float probility = p;
    //general equation
    probility = p+ person.maxhealth*4/(person.health+20)+person.stamina/20;
    //acume effect
    p=p+MAX((person.acume/500),20);

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
    if (CCRANDOM_0_1()*100<=probility) {
        return true;
    }else{
        float luck = 100 - person.talent;
        probility = probility + person.stamina/400;
        if (CCRANDOM_0_1()*100<=luck) {
            if (CCRANDOM_0_1()*100<=probility) {
                return true;
            }
        }
    }
	return false;

}

-(NSMutableDictionary*)calculateWugongHurtLifeWithWugong:(Wugong*)wu WithInvader:(Invader*) beingAttacked
{
    //武功伤害生命
    //enemyid 敌人战斗id，
    //wugong  我方使用武功
    //返回：伤害点数
    NSMutableDictionary* hurtDic = [[NSMutableDictionary alloc]init];
    
    Invader* pid=self;
    Invader* eid=beingAttacked;
	int dng=0;
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
	
    for (Wugong* eidWugong in eid.wugongArr) {
        if ([eidWugong.wugongType isEqualToString:@"内功"]) {
        
        if ([eid triggerSpecialEffectWithProbility:10]) {
                int damage = eidWugong.qigongValue;
                if (damage > dng) {
                    dng = damage;
                    //TODO 内功护体
                    NSString* words = [NSString stringWithFormat:@"%@%@",eidWugong.wugongName,@"\n护体!" ];
                    [eid say:words WithColor:[CCColor colorWithCcColor3b:ccWHITE]];
                }
            }
        }
    }

    
    float hurt = 0;
    if (level > 10) {
        hurt = ((float)[[wu.damage objectAtIndex:10]integerValue]) /3.0;
        level = 10;
    }else{
        hurt = ((float)[[wu.damage objectAtIndex:level]integerValue])/4.0;
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
    atk=atk+mywuxue+pid.mainNeiGong.qigongValue/10;
    
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
	hurt=hurt-def/8;
	
    hurt=hurt-dng/30+pid.stamina/5-eid.stamina/5+eid.bleed/3-pid.bleed/3+eid.poision/2-pid.poision/2;

    if (hurt<0) {
        hurt = 1;
    }
    
    // --考虑距离因素
    float offset = ccpDistance(pid.position, eid.position);
    if (offset<10) {
        hurt = hurt * (100-(offset-1)*3)/100;
    }else{
        hurt = hurt*2/3;
    }
   	
    //bleed effects
	hurt=hurt*(1-pid.bleed*0.002);
    hurt=hurt*(1+eid.bleed*0.0015);
            
    
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

    
    [hurtDic setValue:[NSNumber numberWithInt:hurt] forKey:@"hurt"];
    
    //Calculate spdhurt
    int spdhurt = 0;
    if (dng == 0) {//no neigong protect
        spdhurt += pid.mainNeiGong.qigongValue/8;
    }
    spdhurt += hurt*0.7;
    [hurtDic setValue:[NSNumber numberWithInt:spdhurt] forKey:@"spdhurt"];
    
    //calculate poision and other stuff TODO
    return hurtDic;
}
@end
