//
//  SoldierRecruit.h
//  Ennuma
//
//  Created by Zhaoyang on 14-8-4.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
@interface SoldierRecruit : CCScene
{
    NSMutableSet* purchaseRecords;
    CCSlider *slider;
    CCLabelTTF* purchaseNumber;
    CCLabelTTF* requiredMoney;
    int maxNumber;
    int price;
}
+(SoldierRecruit*)sharedSoldierRecruit;
-(void)resetPurchaseRequest;
@end
