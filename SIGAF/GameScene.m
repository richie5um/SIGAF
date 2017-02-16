//
//  GameScene.m
//  SIGAF
//
//  Created by RichS on 15/02/2017.
//  Copyright © 2017 RichS. All rights reserved.
//

#import "GameScene.h"
#import "UIColor+Hex.h"

@implementation GameScene {
    SKLabelNode *_noLabel;
    SKLabelNode *_yesLabel;
    NSArray *_colors;
}

- (void)sceneDidLoad {
    // Setup your scene here
    
    _noLabel = (SKLabelNode *)[self childNodeWithName:@"//noLabel"];
    _yesLabel = (SKLabelNode *)[self childNodeWithName:@"//yesLabel"];
    
    _noLabel.alpha = 0.0;
    _yesLabel.alpha = 0.0;
    
    SKNode* node1 = (SKLabelNode *)[self childNodeWithName:@"//text1Label"];
    SKNode* node2 = (SKLabelNode *)[self childNodeWithName:@"//text2Label"];
    SKNode* node3 = (SKLabelNode *)[self childNodeWithName:@"//text3Label"];
    SKNode* node4 = (SKLabelNode *)[self childNodeWithName:@"//blackOutLabel"];
    SKNode* node5 = (SKLabelNode *)[self childNodeWithName:@"//fuckLabel"];
    SKNode* node6 = (SKLabelNode *)[self childNodeWithName:@"//shakeLabel"];
    
    node1.alpha = 0.0;
    node2.alpha = 0.0;
    node3.alpha = 0.0;
    node4.alpha = 0.0;
    node5.alpha = 0.0;
    node6.alpha = 0.0;
    
    [node1 runAction:[SKAction sequence:@[[SKAction waitForDuration:0.0], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node2 runAction:[SKAction sequence:@[[SKAction waitForDuration:0.4], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node3 runAction:[SKAction sequence:@[[SKAction waitForDuration:0.8], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node4 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.2], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node5 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.6], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node6 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.9], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    
    _colors = @[
                [UIColor colorWithHex:0xE64E42], // Red
                [UIColor colorWithHex:0xE64E42], // Red
                [UIColor colorWithHex:0xE64E42], // Red
                [UIColor colorWithHex:0xE64E42], // Red
                [UIColor colorWithHex:0xE64E42], // Red
                [UIColor colorWithHex:0xFEA829], // Orange
                [UIColor colorWithHex:0x3B9AD9], // Blue
                [UIColor colorWithHex:0x39CB75], // Green
                [UIColor colorWithHex:0x7561C3], // Purple
                [UIColor colorWithHex:0xFFCC2F]  // Yellow
    ];

}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self hideAnswer];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch* touch in touches) {
        NSArray* nodes = [self nodesAtPoint:[touch locationInNode:self]];
        for(SKNode* node in nodes) {
            if ([node.name hasPrefix:@"fuckLabel"]) {
                [self updateFuckLabel];
            } else if ([node.name hasPrefix:@"blackOutLabel"]) {
                [node runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0.0 duration:0.5], [SKAction removeFromParent]]]];
            }
        }
    }
}

-(void)updateFuckLabel {
    NSInteger randomValue = arc4random_uniform(_colors.count);
    
    SKLabelNode* label = (SKLabelNode *)[self childNodeWithName:@"//fuckLabel"];
    label.fontColor = [_colors objectAtIndex:randomValue];
}

-(void)hideAnswer {
    [_noLabel removeAllActions];
    [_yesLabel removeAllActions];
    
    [_noLabel runAction:[SKAction fadeAlphaTo:0.0 duration:0.2]];
    [_yesLabel runAction:[SKAction fadeAlphaTo:0.0 duration:0.2]];
}

-(void)shaken {
    [self hideAnswer];
    
    NSInteger randomValue = arc4random_uniform(2);
    
    if (0 == randomValue) {
        [self showLabel:_noLabel];
    } else if (1 == randomValue) {
        [self showLabel:_yesLabel];
    }
}

@end
