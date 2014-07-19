//
//  Wugong.m
//  Ennuma
//
//  Created by ennuma on 14-7-14.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Wugong.h"


@implementation Wugong
@synthesize range = _range;
@synthesize damage = _damage;
@synthesize poisionIndex = _poisionIndex;
@synthesize bleedIndex = _bleedIndex;
@synthesize level = _level;
@synthesize rangeType = _rangeType;
@synthesize acumeCost = _acumeCost;
@synthesize wugongName = _wugongName;
@synthesize wugongType = _wugongType;
@synthesize qigongValue =_qigongValue;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.damage = [NSMutableArray array];
    [self initPoisionAndBleed];
    [self initRangeAndRangeType];
    [self initWugongNameAndTypeAndAcumeCost];
    [self initWugongDamageForEachLevelAndQigongValue];
    _level = 1;
    return self;
}
-(void)initWugongDamageForEachLevelAndQigongValue
{
    for (int i = 0;  i < 11;  i++) {
        [_damage addObject:[NSNumber numberWithInt:0]];
    }
    //damage for each level
    [_damage insertObject:[NSNumber numberWithInt:1000]  atIndex:1];
    [_damage insertObject:[NSNumber numberWithInt:2]  atIndex:2];
    [_damage insertObject:[NSNumber numberWithInt:3]  atIndex:3];
    [_damage insertObject:[NSNumber numberWithInt:4]  atIndex:4];
    [_damage insertObject:[NSNumber numberWithInt:5]  atIndex:5];
    [_damage insertObject:[NSNumber numberWithInt:6]  atIndex:6];
    [_damage insertObject:[NSNumber numberWithInt:7]  atIndex:7];
    [_damage insertObject:[NSNumber numberWithInt:8]  atIndex:8];
    [_damage insertObject:[NSNumber numberWithInt:9]  atIndex:9];
    [_damage insertObject:[NSNumber numberWithInt:10]  atIndex:10];
    
    //qigong value for neigong
    _qigongValue = 10;
}
-(void)initRangeAndRangeType
{
    _range = 3;
    _rangeType = 2;
}

-(void)initPoisionAndBleed
{
    _poisionIndex = 0;
    _bleedIndex = 0;
}

-(void)initWugongNameAndTypeAndAcumeCost
{
    _wugongName = @"普通武功";
    _wugongType = @"外功";
    _acumeCost = 50;
}

@end
