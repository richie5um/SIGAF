//
//  GameScene.h
//  SIGAF
//
//  Created by RichS on 15/02/2017.
//  Copyright © 2017 RichS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@interface GameScene : SKScene <UITextFieldDelegate>

@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;

@end
