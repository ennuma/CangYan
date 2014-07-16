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
@synthesize position = _position;
@synthesize headIcon = _headIcon;
@synthesize state = _state;
@synthesize isDefending = _isDefending;
@synthesize isDead = _isDead;

-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    //need to be change later TODO
    _bigIcon = [CCSprite spriteWithImageNamed:@"Enemy1.png"];
    _smallIcon = [CCSprite spriteWithImageNamed:@"Enemy1.png"];
    
    wugong = [[NSMutableArray alloc]init];
    reachable = [[NSMutableSet alloc]init];
    reachableLookup =[[NSMutableDictionary alloc]init];
    [self initWuGong];
    return self;
}
-(void)initWuGong
{
    Wugong* basic = [Wugong node];
    [wugong addObject:basic];
}
-(void)initForBattleWithParent:(CCNode *)parent
{
    _amountofjiqi = 0;
    
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
    //CCLOG(@"endofAct");
    [_smallIcon.parent schedule:@selector(startJiqi:) interval:0.1];
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
    
    int direction = [self getAttackDir:despoint WithWugong:wugong2];
    
   // [self renderAttackWithWugong:wugong Direction:direction Position:despoint];
    
    CCActionCallFuncNNN* render = [CCActionCallFuncNNN actionWithTarget:self selector:@selector(renderAttackWithWugong:Direction:Position:) Id:wugong2 Id:direction Id:[NSValue valueWithCGPoint:despoint]];

    NSMutableArray* invadersBeingAttacked = [self invadersBeingAttakedWithWugong:wugong2 Direction:direction Position:[NSValue valueWithCGPoint:despoint]];
    
    CCActionCallFunc *attackInvaders = [CCActionCallFuncAttackInvader actionWithTarget:self selector:@selector(attackInvaders:WithWuGong:) Invaders:invadersBeingAttacked Wugong:wugong2];
    
    CCActionDelay* delay = [CCActionDelay actionWithDuration:1];//play animation after this TODO
    
    CCActionSequence* actions = [CCActionSequence actions:action,render,delay,
                                 attackInvaders,callback, nil];
    [_bigIcon runAction:actions];
    self.position = despoint;
    
    //release invaders
    invadersBeingAttacked = nil;
}

-(void)attackInvaders:(NSMutableArray *)invaders WithWuGong:(Wugong *)wugong
{
    for (Invader* inv in invaders) {
        inv.isDefending = TRUE;
        [inv defendInvader:self WhoUseWuGong:wugong];
        while (inv.isDefending) {
            //do nothing, wait
        }
    }
}
-(void)defendInvader:(Invader *)invader WhoUseWuGong:(Wugong *)m_wugong
{
    //do things success
    //CCLOG(@"im defending");
    self.health -= m_wugong.damage;
    CCLabelTTF* healthbar = (CCLabelTTF*)[self.state getChildByName:@"health" recursively:NO];
    [healthbar setString: [NSString stringWithFormat:@"%i", self.health]];
    
    if (self.health<0) {
        self.isDead=true;
    }
    self.isDefending = false;
}

-(NSMutableArray*)invadersBeingAttakedWithWugong:(Wugong*)wugong Direction:(int)dir Position:(NSValue*)val
{
    CGPoint pos = [val CGPointValue];
    NSMutableArray* invaders = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < wugong.range ; i++) {
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

-(void)renderAttackWithWugong:(Wugong*)wugong Direction:(int)dir Position:(NSValue*)val
{
    CGPoint pos = [val CGPointValue];
    CCNode* atklayer = [CCNode node];
    atklayer.position = _map.position;
    [_map addChild:atklayer z:1 name:@"attackLayer"];
    for (int i = 0 ; i < wugong.range ; i++) {
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

-(int)getAttackDir:(CGPoint)pos WithWugong:(Wugong*)wugong
{
    int range = wugong.range;
    int maxhit = -999;
    int dir = 0;
    if (wugong.rangeType==2) {
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
-(NSValue*)getMaxAttackPosWithWugong:(Wugong*)wugong
{
    CGPoint maxpos;
    int maxhit=-999;
    
    for (NSValue* val in reachable) {
        int hit = [self getMaxAttackForSinglePos: [val CGPointValue] WithWugong:wugong];
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

-(int)getMaxAttackForSinglePos:(CGPoint)pos WithWugong:(Wugong*) wugong
{
    int range = wugong.range;
    int maxhit = -999;
    if (wugong.rangeType==2) {
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
        //CCLOG(@"%i",dis);
        //CCLOG(@"----------");
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
                    //CCLOG(@"%@",next);
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

-(float)getnewmove
{
    if (_agile>160){
        return 6+(_agile-160)/60;
    }
    else if (_agile>80){
        return 4+(_agile-80)/40;
    }
    else if (_agile>30){
        return 2+(_agile-30)/25;
    }
    else{
        return	_agile/15;
    }
}
@end
