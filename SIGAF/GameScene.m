//
//  GameScene.m
//  SIGAF
//
//  Created by RichS on 15/02/2017.
//  Copyright © 2017 RichS. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKLabelNode *_noLabel;
    SKLabelNode *_yesLabel;
}

- (void)sceneDidLoad {
    // Setup your scene here
    
    _noLabel = (SKLabelNode *)[self childNodeWithName:@"//noLabel"];
    _yesLabel = (SKLabelNode *)[self childNodeWithName:@"//yesLabel"];
    
    _noLabel.alpha = 0.0;
    _yesLabel.alpha = 0.0;
    
    SKNode* text1 = (SKLabelNode *)[self childNodeWithName:@"//text1Label"];
    SKNode* text2 = (SKLabelNode *)[self childNodeWithName:@"//text2Label"];
    SKNode* text3 = (SKLabelNode *)[self childNodeWithName:@"//text3Label"];
    SKNode* text4 = (SKLabelNode *)[self childNodeWithName:@"//shakeLabel"];
    
    text1.alpha = 0.0;
    text2.alpha = 0.0;
    text3.alpha = 0.0;
    text4.alpha = 0.0;
    
    [text1 runAction:[SKAction fadeAlphaTo:1.0 duration:0.3]];
    [text2 runAction:[SKAction fadeAlphaTo:1.0 duration:0.6]];
    [text3 runAction:[SKAction fadeAlphaTo:1.0 duration:0.9]];
    [text4 runAction:[SKAction fadeAlphaTo:1.0 duration:1.2]];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake ) {
        [self shaken];
    }
}

-(void)showLabel:(SKLabelNode*)label {
    [label runAction:[SKAction sequence:@[
                                         [SKAction fadeAlphaTo:1.0 duration:0.2],
                                         [SKAction waitForDuration:3.0],
                                         [SKAction fadeAlphaTo:0.0 duration:1.0]
                                         ]]];
}

-(void)shaken {
    [_noLabel removeAllActions];
    [_yesLabel removeAllActions];
    
    [_noLabel runAction:[SKAction fadeAlphaTo:0.0 duration:0.2]];
    [_yesLabel runAction:[SKAction fadeAlphaTo:0.0 duration:0.2]];
    
    NSInteger randomValue = arc4random_uniform(2);
    
    if (0 == randomValue) {
        [self showLabel:_noLabel];
    } else if (1 == randomValue) {
        [self showLabel:_yesLabel];
    }
}

@end
