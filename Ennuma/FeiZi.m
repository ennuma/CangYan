//
//  FeiZi.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "FeiZi.h"

@implementation FeiZi
@synthesize beijing = _beijing;
@synthesize jieshao = _jieshao;
@synthesize meili = _meili;
@synthesize feiziname = _feiziname;
@synthesize zhiwei = _zhiwei;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.feiziname = @"无";
    self.jieshao = @"无";
    self.meili = 0;
    self.beijing = @"无";
    return self;
}
@end
