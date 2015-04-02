//
//  RSButton.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSButton.h"


@interface RSButton()
@end

@implementation RSButton


-(id)initWithText:(NSString *)text{
    SKLabelNode* buttonText;
    self = [super init];
    buttonText = [SKLabelNode labelNodeWithText:text];
    [self setName:text];
    [buttonText setFontName:@"Verdana"];
    [buttonText setName:@"label"];
    
    //[buttonText setFontSize:100];
    
    [self setSize:CGSizeMake(buttonText.frame.size.width*2, buttonText.frame.size.height*2)];
    [buttonText setPosition:CGPointMake(0, -buttonText.frame.size.height/2)];
    //[self setSize:buttonText.frame.size];
    [self setTexture:[SKTexture textureWithImageNamed:@"background"]];
   [self addChild:buttonText];
    
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.handler();
}

-(void) setText: (NSString*) text{
    SKLabelNode *label = [self getLabel];
    [label setText:text];
    [self setName:text];
    [self setSize:CGSizeMake(label.frame.size.width*2,label.frame.size.height*2)];
    
}

-(SKLabelNode* )getLabel{
    return (SKLabelNode*)[self childNodeWithName:@"label"];
}

@end
