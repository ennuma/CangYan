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
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.range = 3;
    self.rangeType = 2;
    self.damage = 50;
    self.poisionIndex=0;
    self.bleedIndex=0;
    //level = 1;
    
    return self;
}

@end
