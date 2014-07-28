//
//  HuangDi.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "HuangDi.h"

@implementation HuangDi
@synthesize tili = _tili;
@synthesize nianling = _nianling;
@synthesize jiankang = _jiankang;
@synthesize wuli = _wuli;
@synthesize zhili = _zhili;
@synthesize kuaile = _kuaile;
@synthesize maxjiankang = _maxjiankang;
@synthesize maxkuaile = _maxkuaile;
@synthesize maxnianling = _maxnianling;
@synthesize maxtili = _maxtili;
@synthesize maxwuli = _maxwuli;
@synthesize maxzhili = _maxzhili;
static HuangDi* sharedHuangDi;
+(HuangDi*)sharedHuangDi
{
    if (sharedHuangDi) {
        return sharedHuangDi;
    }
    sharedHuangDi = [[self alloc]init];
    [sharedHuangDi initData];
    return sharedHuangDi;
}
-(void)initData
{
    _tili = 100;
    _nianling = 17;
    _jiankang = 100;
    _wuli = 30;
    _zhili = 24;
    _kuaile = 40;
    
    _maxzhili = 100;
    _maxwuli = 100;
    _maxtili = 150;
    _maxnianling = 70;
    _maxkuaile = 100;
    _maxjiankang = 100;
}
@end
