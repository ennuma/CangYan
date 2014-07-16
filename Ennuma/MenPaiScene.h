//
//  MenPaiScene.h
//  Ennuma
//
//  Created by ennuma on 14-7-4.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface MenPaiScene : CCScene {
    int count;
    CCNode* menpai;
    
    CCSprite* sp;
    BOOL _isControlByPlayer;
}
+(MenPaiScene*)sceneWithMenPai:(CCNode*) parent;
-(CCSprite*)getsp;
@property (nonatomic) BOOL isControlByPlayer;
@end
