//
//  GuanYuan.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Invader.h"
@interface GuanYuan : CCNode
{
    int _zhongcheng;
    int _zhihui;
    int _wuli;
    int _qinglian;
    int _fenglu;
    NSString* _guanzhi;
    NSString* _juewei;
    NSString* _guanyuanname;
    int _age;
}
@property int zhongcheng;
@property int zhihui;
@property int wuli;
@property int qinglian;
@property int fenglu;
@property NSString* guanzhi;
@property NSString* juewei;
@property NSString* guanyuanname;
@property int age;
+(GuanYuan*)initFromDictionary:(NSDictionary*)dic;
-(Invader*)transformToInvader;
@end
