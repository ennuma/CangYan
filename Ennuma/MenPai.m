//
//  MenPai.m
//  Ennuma
//
//  Created by ennuma on 14-7-1.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "MenPai.h"


@implementation MenPai
@synthesize neighbours=_neighbours;
@synthesize city=_city;
@synthesize menPaiScene = _menPaiScene;
@synthesize population = _population;
@synthesize controlByPlayer = _controlByPlayer;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _neighbours = [[NSMutableArray alloc]init];
    _controlByPlayer = false;
    return self;
}

+(MenPai*)menPaiWithLocation:(CGPoint)position
{
    MenPai* ret = [[self alloc]init];
    [ret initMenPaiData];
    [ret setCityWithLocation:position];
    [ret initMenPaiScene];
    return ret;
}

-(void)initMenPaiData
{

}

-(void) setCityWithLocation:(CGPoint)position
{
    _city = [CCSprite spriteWithImageNamed:@"menpai.png"];
    _city.position = position;
    [self addChild: _city];
    [self setContentSize:[_city contentSize]];
}

-(void)initMenPaiScene
{
    _menPaiScene = [MenPaiScene sceneWithMenPai:self];
}

-(MenPaiScene*) getMenPaiScene
{
    /**if (_menPaiScene.isControlByPlayer) {
        [_menPaiScene getsp].visible = YES;
    }else{
        [_menPaiScene getsp].visible = NO;

    }**/
    return _menPaiScene;
}

-(CGRect)boundingBox
{
    return [_city boundingBox];
}

-(void)dealloc
{
    _neighbours = nil;
}

-(void)defendInvader:(Invader *)invader
{
    _population -= invader.strength;
    if (_population<0) {
        [self unscheduleAllSelectors];
        _controlByPlayer = YES;
    }
}

-(void)scheduleInvader:(Invader *)invader InvadeMenPai:(MenPai *)menpai
{
    //[self schedule:@selector(deltatime:invadeMenPai:WithInvader:) interval:1];
    [self schedule:@selector(deltatime:invadeMenPai:WithInvader:) interval:1 menpai:menpai invader:invader];
}

-(void)deltatime:(CCTime)delta invadeMenPai:(MenPai*)menpai WithInvader:(Invader*)invader
{
    [menpai defendInvader:invader];
}

@end
