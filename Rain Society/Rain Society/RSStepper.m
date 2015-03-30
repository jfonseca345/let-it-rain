//
//  RSStepper.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSStepper.h"
#import "RSButton.h"

@interface RSStepper()

@property (nonatomic, setter=setValueLabel:) int value;
@property (nonatomic) int minValue;
@property (nonatomic) int maxValue;
@property (nonatomic) int amount;

@end
@implementation RSStepper

-(id)initWithProperties:(int) initialValue andMinValue:(int)minValue andMaxValue:(int)maxValue andAmount:(int)amount{
    
    self = [super init];
    
    SKLabelNode* textScore;
    RSButton* buttonPlus;
    RSButton* buttonMinus;
    self.value=initialValue;
    self.minValue = minValue;
    self.maxValue = maxValue;
    self.amount = amount;
    
    buttonMinus = [[RSButton alloc] initWithText:@" - "];
    buttonPlus = [[RSButton alloc] initWithText:@" + "];
    [buttonMinus setSize:buttonPlus.frame.size];
    textScore = [[SKLabelNode alloc]initWithFontNamed:@"Verdana"];
    [textScore setName:@"value"];
    [textScore setText:[NSString stringWithFormat:@"%d", self.value]];
    
    [self setSize:CGSizeMake(buttonPlus.frame.size.width*5., buttonPlus.size.height*2.)];
    
    [buttonMinus setPosition:CGPointMake(CGRectGetMinX(self.frame)+CGRectGetWidth(buttonPlus.frame)/2.0, 0)];
    [buttonPlus setPosition:CGPointMake(CGRectGetMaxX(self.frame) - CGRectGetWidth(buttonPlus.frame)/2.0, 0)];
    [textScore setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    
    [buttonMinus setHandler:^{
        
        self.value-=self.amount;
        if (self.value<self.minValue){
            self.value = self.minValue;
        }
        NSLog(@"Ue");
    }];
    [buttonPlus setHandler:^{
        self.value+=self.amount;
        if (self.value>self.maxValue){
            self.value = self.maxValue;
        }
        NSLog(@"Uai");
    }];
    
    [self addChild:textScore];
    [self addChild:buttonMinus];
    [self addChild:buttonPlus];
    
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    /*for (UITouch *touch in touches) {
     
     CGPoint location = [touch locationInNode:self];
     SKNode *touchedNode = [self nodeAtPoint:location];
     
     if ([touchedNode.name isEqual:@" + "] || [touchedNode.parent.name isEqual:@" + "]){
     self.value++;
     NSLog(@"Ue");
     }
     else if ([touchedNode.name isEqual:@" - "] || [touchedNode.parent.name isEqual:@" - "]){
     self.value--;
     NSLog(@"Uai");
     }
     SKLabelNode *label = (SKLabelNode*)[self childNodeWithName:@"value"];
     
     [label setText:[NSString stringWithFormat:@"%d", self.value]];
     
     }*/
}

-(void) setButtonColor:(UIColor *)color{
    NSArray* childrenOfSelf = [self children];
    for (SKNode* node in childrenOfSelf){
        NSLog(@"%@", node.name);
        if ([node.name isEqual:@" + "]){
            RSButton* button = (RSButton*)node;
            [button setColor:color];
        }
        else if ([node.name isEqual:@" - "]){
            RSButton* button = (RSButton*)node;
            [button setColor:color];
        }
    }
    
}

-(void) setValueLabel:(int)value {
    _value = value;
    SKLabelNode *label = (SKLabelNode*)[self childNodeWithName:@"value"];
    [label setText:[NSString stringWithFormat:@"%d", _value]];
}

-(int) getValueLabel{
    return _value;
}
@end
