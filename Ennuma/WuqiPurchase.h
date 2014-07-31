//
//  WuqiPurchase.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-31.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
@interface WuqiPurchase : CCScene
{
    NSMutableSet* purchaseRecords;
    CCSlider *slider;
    CCLabelTTF* purchaseNumber;
    CCLabelTTF* requiredMoney;
    int maxNumber;
    int price;
}
+(WuqiPurchase*)sharedWuqiPurchase;
-(void)resetPurchaseRequest;
@end
