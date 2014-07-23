//
//  CanYan.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "CangYan.h"


@implementation CangYan
@synthesize player = _player;
@synthesize day = _day;
@synthesize place = _place;

static CangYan* sharedScene;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    inPlace = false;
    
    return self;
}
+(CangYan*)scene
{
    sharedScene = [[self alloc]init];
    [sharedScene loadData];
    return sharedScene;
}
+(CangYan*)sharedScene
{
    NSAssert(sharedScene!=nil, @"sharedScene not initialized yet");
    return sharedScene;
}
-(void)loadData
{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    if (true) {
        _day = 1;
        
        CCSprite* topbar = [CCSprite spriteWithImageNamed:@"topbar.png"];
        [topbar setScaleX:winSize.width/topbar.contentSize.width];
        [topbar setScaleY:winSize.height/topbar.contentSize.height/6];
        topbar.position = CGPointMake(topbar.contentSize.width*topbar.scaleX/2, winSize.height-topbar.contentSize.height*topbar.scaleY/2);
        [self addChild:topbar z:0 name:@"topbar"];
        
        CCSprite* bottombar = [CCSprite spriteWithImageNamed:@"bottombar.png"];
        [bottombar setScaleX:winSize.width/bottombar.contentSize.width];
        [bottombar setScaleY:(winSize.height-bottombar.contentSize.height*topbar.scaleY)/bottombar.contentSize.height/5];
        bottombar.position = CGPointMake(bottombar.contentSize.width*bottombar.scaleX/2, bottombar.contentSize.height*bottombar.scaleY/2);
        [self addChild:bottombar z:0 name:@"bottombar"];
        
        CCSprite* leftbar = [CCSprite spriteWithImageNamed:@"leftbar.png"];
        [leftbar setScaleX:winSize.width/leftbar.contentSize.width/5];
        [leftbar setScaleY:(winSize.height-topbar.contentSize.height*topbar.scaleY-bottombar.contentSize.height*bottombar.scaleY)/leftbar.contentSize.height];
        leftbar.position = CGPointMake(leftbar.contentSize.width*leftbar.scaleX/2, leftbar.contentSize.height*leftbar.scaleY/2+bottombar.contentSize.height*bottombar.scaleY);
        [self addChild:leftbar z:0 name:@"leftbar"];
    
        
        //init day
        CCLabelTTF* labelDay = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Day: %i",_day] fontName:@"Verdana-Bold" fontSize:30];
        [leftbar addChild:labelDay];
        labelDay.position = CGPointMake(leftbar.contentSize.width/2*leftbar.scaleX,leftbar.contentSize.height/2*leftbar.scaleY);
        //[leftbar addChild:labelDay];
        
        
        //init zhujjiao
        _player = [Entity node];
        _player.jianfa = 40;
        _player.entityName = @"剑神一笑";
        _player.entityMale = @"男";
        _player.wuLinName = @"少侠";
        _player.atk=5;
        _player.def = 5;
        _player.agile = 5;
        
        //init place
        Place_XinShouCun* xinshoucun = [Place_XinShouCun node];
        _place = xinshoucun;
    }
}
-(void)update:(CCTime)delta
{
    if (!inPlace) {
        [self enterPlace];
        inPlace = true;
    }
}
-(void)enterPlace
{
    //CCSprite* place = _place.bg;
    [self setBackGroundForPlace:_place];
    inEvent = [_place enterPlaceOnDay:_day];
    inPlace = true;
}
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (inEvent) {
        _place
    }
}

-(void)setBackGroundForPlace:(Place*)place
{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    CCNode* topbar = [self getChildByName:@"topbar" recursively:NO];
    CCNode* bottombar = [self getChildByName:@"bottombar" recursively:NO];
    CCNode* leftbar = [self getChildByName:@"leftbar" recursively:NO];
    
    CCSprite* main = _place.bg;
    [main setScaleX:(winSize.width-leftbar.contentSize.width*leftbar.scaleX)/main.contentSize.width];
    [main setScaleY:(winSize.height-topbar.contentSize.height*topbar.scaleY-bottombar.contentSize.height*bottombar.scaleY)/main.contentSize.height];
    main.position = CGPointMake(main.contentSize.width*main.scaleX/2+leftbar.contentSize.width*leftbar.scaleX, main.contentSize.height*main.scaleY/2+bottombar.contentSize.height*bottombar.scaleY);
    [self addChild:main z:0 name:@"main"];
}
@end
