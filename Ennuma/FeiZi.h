//
//  FeiZi.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface FeiZi : CCNode
{
    NSString* _feiziname;
    int _meili;
    NSString* _jieshao;
    NSString* _beijing;
    NSString* _zhiwei;
}
@property int meili;
@property NSString* feiziname;
@property NSString* jieshao;
@property NSString* beijing;
@property NSString* zhiwei;
@end
