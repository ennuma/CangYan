//
//  GameScene.h
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
@interface GameScene : CCScene {
    Player* player;
    CGPoint lasttouchloc;
    BOOL isMovingPlayer;
    NSMutableArray* routine;
    //NSMutableArray* bufferRoutine;
    CCSpriteBatchNode *batchnode;
    float travelDistance;
    //GameScene* sharedScene;
}
+(GameScene*)scene;
+(GameScene*)sharedScene;
@end

