//
//  HouGong.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FeiZi.h"
@interface HouGong : CCScene
{
    CCLabelTTF* huanghou;
    int hougongSize;
    NSMutableDictionary* hougongDic;
    int stage;
    FeiZi* shiqin;
    int newstage;
    CCSprite* popup;
}
+(CCScene*)sharedScene;
@end
