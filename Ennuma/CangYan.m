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
static CangYan* sharedScene;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
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
        [self addChild:topbar];
        
        CCSprite* bottombar = [CCSprite spriteWithImageNamed:@"bottombar.png"];
        [bottombar setScaleX:winSize.width/bottombar.contentSize.width];
        [bottombar setScaleY:(winSize.height-bottombar.contentSize.height*topbar.scaleY)/bottombar.contentSize.height/5];
        bottombar.position = CGPointMake(bottombar.contentSize.width*bottombar.scaleX/2, bottombar.contentSize.height*bottombar.scaleY/2);
        [self addChild:bottombar];
        
        CCSprite* leftbar = [CCSprite spriteWithImageNamed:@"leftbar.png"];
        [leftbar setScaleX:winSize.width/leftbar.contentSize.width/5];
        [leftbar setScaleY:(winSize.height-topbar.contentSize.height*topbar.scaleY-bottombar.contentSize.height*bottombar.scaleY)/leftbar.contentSize.height];
        leftbar.position = CGPointMake(leftbar.contentSize.width*leftbar.scaleX/2, leftbar.contentSize.height*leftbar.scaleY/2+bottombar.contentSize.height*bottombar.scaleY);
        [self addChild:leftbar];
    
        
        CCLabelTTF* labelDay = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Day: %i",_day] fontName:@"Verdana-Bold" fontSize:30];
        [leftbar addChild:labelDay];
        labelDay.position = CGPointMake(leftbar.contentSize.width/2*leftbar.scaleX,leftbar.contentSize.height/2*leftbar.scaleY);
        //[leftbar addChild:labelDay];
        
        _player = [Entity node];
        _player.at
    }
}
@end
