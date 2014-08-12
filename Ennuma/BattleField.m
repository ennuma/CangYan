//
//  BattleField.m
//  Ennuma
//
//  Created by ennuma on 14-7-7.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "BattleField.h"

@implementation BattleField
@synthesize height = _height;
@synthesize width = _width;

static float current_clock = 0;
//Test constant
CCSprite* sp1;
CCSprite* sp2;
CCSprite* bar;
//End of test
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    redTeam = [[NSMutableArray alloc] init];
    blueTeam = [[NSMutableArray alloc] init];
    whateverTeam = [[NSMutableArray alloc] init];
    _touches = [[NSMutableSet alloc]init];
    
    interval = 0.1;
    tick = 0;
    maxJiQi = 1000;
    
    //Test Purpose
    //sp1 = [CCSprite spriteWithImageNamed:@"Enemy1.png"];
    //sp2 = [CCSprite spriteWithImageNamed:@"Enemy2.png"];
    bar = [CCSprite spriteWithImageNamed:@"hud.png"];
    bar.position = CGPointMake([self contentSize].width/2, [self contentSize].height- [bar contentSize].height);
    
    //[self addChild:sp1 z:99];
    //[self addChild:sp2 z:99];
    [self addChild:bar z:98];
    
    map = [CCTiledMap tiledMapWithFile:@"BattleField2.tmx"];
    [self addChild:map z:-99];
    _width = map.mapSize.width;
    _height = map.mapSize.height;
    
    [self setUserInteractionEnabled:YES];
    
    UIPinchGestureRecognizer *twoFingerPinch =[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchZoomWithRecognizer:)];
    [[CCDirector sharedDirector].view addGestureRecognizer:twoFingerPinch];
    
    return self;
}
+(BattleField*)scene
{
    BattleField* bf = [[self alloc]init];
    return bf;
}

-(void)startBattle
{
    isExiting = false;
    [self schedule:@selector(startJiqi:) interval:0.01];
}

-(void)addEntity:(Invader *)obj ForTeam:(NSString*)teamtype AtPos:(CGPoint)spawnPos
{
    obj.map = map;
    if ([teamtype isEqualToString:@"red"]) {
        [redTeam addObject:obj];
        
        //Test
        //obj.smallIcon = sp1;
        obj.allie = redTeam;
        obj.enemy = blueTeam;
        [obj initPosition:spawnPos];
    }
    else if ([teamtype isEqualToString:@"blue"]){
        [blueTeam addObject:obj];
        
        //Test
        //obj.smallIcon = sp2;
        obj.allie = blueTeam;
        obj.enemy = redTeam;
        [obj initPosition:spawnPos];
    }
    
    [obj initForBattleWithParent:self];
    [whateverTeam addObject:obj];
    //CGPoint spp = CGPointMake([self contentSize].width/2-[bar contentSize].width/2+ [sp1 contentSize].width/2, [self contentSize].height- [bar contentSize].height);

    //test
    //obj.smallIcon.position = spp;
    float percentage = obj.amountofjiqi/maxJiQi;
    float newx = bar.contentSize.width*percentage + bar.position.x - bar.contentSize.width/2;
    obj.smallIcon.position = CGPointMake(newx, [self contentSize].height- [bar contentSize].height);
    [self addChild:obj.smallIcon z:99];
}

-(void)dealloc
{
    redTeam = nil;
    blueTeam = nil;
}
-(void)waitForMove
{
    waitForMove = true;
}
-(void)waitForAttack
{
    waitForAttack = true;
}
-(void)waitForChooseWugong
{
    [self showWugongMenu];
    waitForChooseWugong = true;
}
-(void)showWugongMenu
{
    Invader* inv = (Invader*)isActing;
    CCNode* menu = [CCNode node];
    int count = 0;
    for (Wugong* wg in inv.wugongArr)
    {
        CCLabelTTF* label = [CCLabelTTF labelWithString:wg.wugongName fontName:@"Verdana-Bold" fontSize:18.0f];
        [label addChild:wg z:0 name:@"wugong"];
        label.position = CGPointMake(self.contentSize.width/2, self.contentSize.height/2+100*count);
        [menu addChild:label];
        count++;
    }
    [self addChild:menu z:0 name:@"wugongmenu"];
}
-(void)hiddenWugongMenu
{
    [self removeChildByName:@"wugongmenu"];
}
-(void)update:(CCTime)delta{
    //CCLOG(@"update");
    if ([self checkEndBattle]) {
        if (!isExiting) {
            CCLOG(@"END BATTLE");
            //self.paused = YES;
            //TODO
            //battle ends here, its time to change scene or pop scene
            CCActionDelay* delay = [CCActionDelay actionWithDuration:2];
            CCActionCallFunc* pop = [CCActionCallFunc actionWithTarget:self selector:@selector(pop)];
            CCActionSequence* seq = [CCActionSequence actions:delay,pop, nil];
            isExiting = true;
            [self runAction:seq];
        }
    }
}
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([self getChildByName:@"show" recursively:NO]!=nil) {
        [self removeChildByName:@"show"];
        [self resumeAction];
        return;
    }
    lastloc = [touch locationInNode:map];
    if (waitForMove) {
        CCLOG(@"wait for move");
        CGPoint realpos = [touch locationInNode:map];
        CGPoint convertedpos = [self tileCoordForPosition:realpos];
        CCLOG(@"%f,%f",convertedpos.x,convertedpos.y);
        Invader* inv = (Invader*)isActing;
        if ([inv.reachableSet containsObject:[NSValue valueWithCGPoint:convertedpos]]) {
            [inv moveTo:convertedpos];
            waitForMove = false;
        }
        return;
    }
    if (waitForChooseWugong) {
        CCNode* menu = [self getChildByName:@"wugongmenu" recursively:NO];
        for (CCNode* wg in menu.children) {
            if (CGRectContainsPoint(wg.boundingBox, [touch locationInNode:self])) {
                Wugong* wgnode = (Wugong*)[wg getChildByName:@"wugong" recursively:NO];
                CCLOG(wgnode.wugongName);
                Invader* inv = (Invader*)isActing;
                [inv chooseWugong:wgnode];
                choosedWugong = wgnode;
                [self hiddenWugongMenu];
                waitForChooseWugong = false;
            }
        }
        return;
    }
    if (waitForAttack) {
        CCLOG(@"atk");
        //CCNode* node = [map getChildByName:@"attackLayer" recursively:NO];
        //NSAssert(node!=nil, @"attackLayer is nil");
        Invader* inv = (Invader*)isActing;
        for (CCNode* atpos in inv.attackableSet) {
            CGRect box = atpos.boundingBox;
            CGPoint worldPoint = [atpos convertToWorldSpace:CGPointZero];
            box.origin = worldPoint;
            //CCLOG(@"boxorignin: %f,%f.",box.origin.x,box.origin.y);
            //CCLOG(@"box: %f,%f.",box.size.width,box.size.height);
            if (CGRectContainsPoint(box, [touch locationInNode:self])) {
                int direction = 0;
                CGPoint mappos = [self tileCoordForPosition:atpos.position];
                CCLOG(@"attack at : %f,%f",mappos.x,mappos.y);
                if(mappos.y>inv.position.y){
                    direction = 1;
                }
                if (mappos.y < inv.position.y) {
                    direction = 2;
                }
                if (mappos.x < inv.position.x) {
                    direction = 3;
                }
                if (mappos.x > inv.position.x) {
                    direction = 4;
                }
                [inv attackWithWugong:choosedWugong Direction:direction];
                waitForAttack = false;
            }
        }
        return;
    }
}
-(CGPoint) tileCoordForPosition:(CGPoint) position
{
    int x = position.x / map.tileSize.width;
    int y = ((map.mapSize.height * map.tileSize.height) - position.y) / map.tileSize.height;
    return CGPointMake(x, y);
}
-(void)pop
{
    [[CCDirector sharedDirector]popScene];
}
-(bool)checkEndBattle
{
    bool aliveInRed = false;
    bool aliveInBlue = false;
    for (Invader* inv in redTeam) {
        if (!inv.isDead) {
            aliveInRed = true;
        }
    }
    
    for (Invader* inv in blueTeam) {
        if (!inv.isDead) {
            aliveInBlue = true;
        }
    }
    return !(aliveInRed&&aliveInBlue);
}
-(void)startJiqi:(CCTime) delta
{
    current_clock += delta;
    if (current_clock>interval) {
        tick++;
        [self updateAllObjsJiQi];
        current_clock = current_clock - interval;
    }
}
/**
 The objs may do action at the same time. fixed
 **/
static NSObject* isActing = nil;
-(void) updateAllObjsJiQi
{
    isActing = nil;
    //advise arrange element by jiqispeed
    /**
     sorted version of doaction. only the fastest one will act and put others to waitlist
     **/
    NSArray *sorted = [whateverTeam sortedArrayUsingComparator:^(id obj1, id obj2){
       
          Invader *s1 = obj1;
          Invader*s2 = obj2;
            
            if (s1.jiqispeed > s2.jiqispeed) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if (s1.jiqispeed < s2.jiqispeed) {
                return (NSComparisonResult)NSOrderedDescending;
            }
        
        // TODO: default is the same?
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    for (Invader* inv in sorted) {
        if (inv.isDead) {
            continue;
        }
        [self updateJiQi:inv];
    }

}

-(void) updateJiQi: (Invader*) obj
{
    
    [obj updateJiQi];
    
    float percentage = obj.amountofjiqi/maxJiQi;
    float newx = bar.contentSize.width*percentage + bar.position.x - bar.contentSize.width/2;
    obj.smallIcon.position = CGPointMake(newx, obj.smallIcon.position.y);
   // CCLOG(@"%f",obj.amountofjiqi);
    if (obj.amountofjiqi > maxJiQi) {
        //CCLOG(@"startact");
        if (!isActing) {
            [self unschedule:@selector(startJiqi:)];
            [obj doAction];
            isActing=obj;
            obj.amountofjiqi = obj.amountofjiqi - maxJiQi;
        }else{
            obj.amountofjiqi = maxJiQi-1;
        }
        //CCLOG(@"action");
        //Action Begins Here
    }
    
    
    
}

-(void)notifyJiQiChangedForInvader:(id)invader
{
    Invader* obj = (Invader*)invader;
    float percentage = obj.amountofjiqi/maxJiQi;
    float newx = bar.contentSize.width*percentage + bar.position.x - bar.contentSize.width/2;
    CGPoint newpos = CGPointMake(newx, obj.smallIcon.position.y);
    //newpos = CGPointMake(0, obj.smallIcon.position.y);
    //The duration for this action may changed TODO
    CCActionMoveTo* moveTo = [CCActionMoveTo actionWithDuration:0.8 position:newpos];
    [obj.smallIcon runAction:moveTo];
}

-(void)pauseAction
{
    if (isActing) {
        [((Invader*)isActing).bigIcon setPaused:YES];
    }
}

-(void)resumeAction
{
    if (isActing) {
        [((Invader*)isActing).bigIcon setPaused:NO];
    }
}
-(NSString*)getIntroduction
{
    return @"战斗即将开始，众将出击";
}
-(void)onEnter
{
    [self startBattle];
    [super onEnter];
}
/**
-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint curloc = [touch locationInNode:map];
    CGPoint dif = ccp(curloc.x-lastloc.x,curloc.y-lastloc.y);
    if (ccpLength(dif)<25) {
        return;
    }
    CCActionMoveBy* moveBy = [CCActionMoveBy actionWithDuration:0 position:dif];
    if([map numberOfRunningActions]==0){
        [map runAction:moveBy];
    }
    
    lastloc = curloc;
}
 **/
- (void)panForTranslation:(CGPoint)translation {
    translation = ccpMult(translation, map.scale);
    CGPoint newPos = ccpAdd(map.position, translation);
    map.position = newPos;
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInNode:map];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [map convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}

- (void) pinchZoomWithRecognizer: (UIPinchGestureRecognizer *)recognizer
{
    NSLog(@"Pinch scale: %f", recognizer.scale);
    //map.scale *= recognizer.scale; // kPinchZoomCoeff is constant = 1.0 / 200.0f Adjust it for your needs
    static float scale;
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        scale = map.scale;
    }
    
    //remove the fucking black line between IMPORTANT
    CGFloat factor = [recognizer scale];
    
    float toScaleX = scale*factor;
    
    int sX = toScaleX *40; //-xxxx
    
    float finalScale = sX/40.0;//-x.yy
    ///////////////////////////////////////////////
    
    [map setScale:finalScale];

}
@end
