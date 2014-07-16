//
//  MenPai.h
//  Ennuma
//
//  Created by ennuma on 14-7-1.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenPaiScene.h"
#import "Invader.h"
//todo this class need to be refactor

@interface MenPai : CCNode {
    NSMutableArray* _neighbours;
    CCSprite* _city;
    MenPaiScene* _menPaiScene;
    int _population;
    BOOL _controlByPlayer;
}

+(MenPai*) menPaiWithLocation:(CGPoint) position;
-(MenPaiScene*)getMenPaiScene;
-(void)initMenPaiScene;
-(void)initMenPaiData;
-(void)defendInvader:(Invader*)invader;
-(void)scheduleInvader:(Invader*)invader InvadeMenPai:(MenPai*)menpai;
-(void)deltatime:(CCTime)delta invadeMenPai:(MenPai*)menpai WithInvader:(Invader*)invader;
@property (nonatomic,readwrite) NSMutableArray* neighbours;
@property (nonatomic,readwrite) CCSprite* city;
@property (nonatomic,readwrite) MenPaiScene* menPaiScene;
@property (nonatomic) int population;
@property (nonatomic) BOOL controlByPlayer;
@end
