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
    UITextField* _textField;
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
    SKNode* node4 = (SKLabelNode *)[self childNodeWithName:@"//fuckLabel"];
    SKNode* node5 = (SKLabelNode *)[self childNodeWithName:@"//shakeLabel"];
    SKNode* node6 = (SKLabelNode *)[self childNodeWithName:@"//editLabel"];
    SKNode* node7 = (SKLabelNode *)[self childNodeWithName:@"//resetLabel"];
    
    
    node1.alpha = 0.0;
    node2.alpha = 0.0;
    node3.alpha = 0.0;
    node4.alpha = 0.0;
    node5.alpha = 0.0;
    node6.alpha = 0.0;
    node7.alpha = 0.0;
    
    [node1 runAction:[SKAction sequence:@[[SKAction waitForDuration:0.0], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node2 runAction:[SKAction sequence:@[[SKAction waitForDuration:0.4], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node3 runAction:[SKAction sequence:@[[SKAction waitForDuration:0.8], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node4 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.6], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node5 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.9], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node6 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.9], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];
    [node7 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.9], [SKAction fadeAlphaTo:1.0 duration:0.3]]]];

    [self loadLabel];
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
            [_textField resignFirstResponder];
            
            if ([node.name hasPrefix:@"fuckLabel"] || [node.name hasPrefix:@"editLabel"] || [node.name hasPrefix:@"editTouch"]) {
                [self editLabel];
            } else if ([node.name hasPrefix:@"shakeLabel"] || [node.name hasPrefix:@"shakeTouch"]) {
                [self hideAnswer];
                [self runAction:[SKAction sequence:@[[SKAction waitForDuration:0.5], [SKAction runBlock:^{
                    [self shaken];
                }]]]];
            } else if ([node.name hasPrefix:@"resetLabel"] || [node.name hasPrefix:@"resetTouch"]) {
                [self saveLabel:@"????"];
            }
        }
    }
}

-(BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    [self saveLabel:newString];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)editLabel {
    if (nil == _textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10,10,100,30)];
        _textField.delegate = self;
        _textField.hidden = true;
        
        [self.view addSubview:_textField];
    }
    
    SKLabelNode* textNode = (SKLabelNode *)[self childNodeWithName:@"//fuckLabel"];
    _textField.text = textNode.text;
    
    [_textField becomeFirstResponder];
}

-(void)saveLabel:(NSString*)text {
    SKLabelNode* textNode = (SKLabelNode *)[self childNodeWithName:@"//fuckLabel"];
    textNode.text = text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:text forKey:@"labelText"];
    [defaults synchronize];
}

-(void)loadLabel {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    SKLabelNode* textNode = (SKLabelNode *)[self childNodeWithName:@"//fuckLabel"];
    textNode.text = [defaults objectForKey:@"labelText"];
    if (0 == textNode.text.length) {
        [self saveLabel:@"????"];
    }
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
