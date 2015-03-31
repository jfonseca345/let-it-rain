//
//  ECloud.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 31/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "ECloud.h"
#import "RSContainer.h"
#import "RSStepper.h"
#import "RSButton.h"
#import "RSMap.h"
#import "RSField.h"

@implementation ECloud

-(id) initWithPosition: (CGPoint) position{
    self = [super initWithImageNamed:@"nuvem"];
    self.zPosition = 2;
    [self.physicsBody setDynamic:NO];
    [self setPosition:position];
    [self setUserInteractionEnabled:YES];
    return self;
}

-(void)showPopup{
    if ([self childNodeWithName:@"PopupCloud"]!=nil)
        return;
    
    RSContainer * popup = [[RSContainer alloc] initWithColor:[UIColor blueColor]];
    [popup setName:@"PopupCloud"];
    popup.attach = self;
    popup.zPosition = 200;
    
    SKLabelNode* pressureLabel = [[SKLabelNode alloc] initWithFontNamed:@"Verdana"];
    [pressureLabel setName:@"pressureLabel"];
    [pressureLabel setText:@"Pressao:"];
    pressureLabel.position = CGPointMake(-(pressureLabel.frame.size.width)/2, pressureLabel.frame.size.height*1.25);
    
    RSStepper* pressureStepper = [[RSStepper alloc]initWithProperties:self.pressure andMinValue:0 andMaxValue:50 andAmount:25];
        pressureStepper.position = CGPointMake(20+(pressureLabel.frame.size.width)/2, pressureLabel.frame.size.height*1.5-10);
    [pressureStepper setName:@"pressure"];
    [pressureStepper setColor:[UIColor redColor]];
    [pressureStepper setButtonColor:[UIColor blueColor]];
    
    [popup setSize:CGSizeMake(pressureLabel.frame.size.width+pressureStepper.frame.size.width+30, pressureLabel.frame.size.height*4)];
    
    RSButton* okButton = [[RSButton alloc]initWithText:@"OK"];
    [okButton setColor:[UIColor redColor]];
    okButton.position=CGPointMake(0, -pressureLabel.frame.size.height*1.5);
    
    [okButton setHandler:^{
        NSArray* childrenScene = [self children];
        RSContainer* popupC;
        
        for (SKNode* node in childrenScene){
            if ([node.name isEqualToString:@"PopupCloud"]){
                popupC=(RSContainer*)node;
            }
        }
        RSStepper* stepper;
        for (SKNode* node in [popupC children]){
            if ([node.name isEqualToString:@"pressure"]){
                stepper=(RSStepper*)node;
                ((ECloud*)popupC.attach).pressure = [stepper getValueLabel];
                RSMap* map = (RSMap*) self.mapParent;
                RSField* field = map.fields[self.fieldX][self.fieldY];
                [field setChanged:YES];
                
            }
            
            
        }
        [popupC removeFromParent];
    }];
    
    [popup addChild:pressureLabel];
    [popup addChild:pressureStepper];
    [popup addChild:okButton];
    
    [popup setPosition:CGPointMake(0,0)];
    [self addChild:popup];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self showPopup];
}

@end
