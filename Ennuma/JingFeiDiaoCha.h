//
//  JingFeiDiaoCha.h
//  Ennuma
//
//  Created by Zhaoyang on 14-8-6.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
@interface JingFeiDiaoCha : CCScene
{
    //NSMutableSet* adjustRecords;
    CCSlider *slider;
    CCLabelTTF* purchaseNumber;
    CCLabelTTF* requiredMoney;
    int maxNumber;
}

+(JingFeiDiaoCha*)sharedJingfei;
@end
