//
//  Field.m
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSField.h"


@implementation RSField

-(id) initWithTemperature : (int) temperature Pressure: (int) pressure Wind: (int) wind{
    self = [super init];
    self.temperature=temperature;
    self.pressure=pressure;
    self.wind=wind;
    self.sprites = [[NSMutableArray alloc] initWithArray:@[]];
    self.changed = NO;
    self.cloudControl = NO;
    return self;
}

-(void) addSprite:(RSSprite*) sprite{
    [self.sprites addObject:sprite];
}

-(void)showPopup: (SKNode*)gameScene{
    if ([gameScene childNodeWithName:@"PopupMain"]!=nil)
        return;
    
    self.popup = [[RSContainer alloc] initWithColor:[UIColor blueColor]];
    [self.popup setName:@"PopupMain"];
    self.popup.attach = self;
    self.popup.zPosition = 200;
    
    SKLabelNode* temperatureLabel = [[SKLabelNode alloc] initWithFontNamed:@"Verdana"];
    [temperatureLabel setName:@"temperatureLabel"];
    [temperatureLabel setText:@"Temperatura:"];
    temperatureLabel.position = CGPointMake(-(temperatureLabel.frame.size.width)/2+40, temperatureLabel.frame.size.height*1.2);
    
    SKLabelNode* windLabel = [[SKLabelNode alloc] initWithFontNamed:@"Verdana"];
    [windLabel setName:@"windLabel"];
    [windLabel setText:@"Vento:"];
    windLabel.position = CGPointMake(-(temperatureLabel.frame.size.width)/2-10, temperatureLabel.frame.size.height*0.1-15);
    
    
    //RSStepper* pressureStepper = [[RSStepper alloc]initWithProperties:self.pressure andMinValue:0 andMaxValue:50 andAmount:25];
    RSStepper* temperatureStepper = [[RSStepper alloc] initWithProperties:self.temperature andMinValue:-5 andMaxValue:5 andAmount:1];
    temperatureStepper.position = CGPointMake(10+(temperatureLabel.frame.size.width)/2, temperatureLabel.frame.size.height*1.4);
    [temperatureStepper setName:@"temperature"];
    [temperatureStepper setColor:[UIColor redColor]];
    [temperatureStepper setButtonColor:[UIColor blueColor]];
    
    RSStepper* windStepper = [[RSStepper alloc]initWithProperties:self.wind andMinValue:-1 andMaxValue:1 andAmount:1];
    windStepper.position = CGPointMake(10+(temperatureLabel.frame.size.width)/2, temperatureLabel.frame.size.height*0.1-15);
    [windStepper setName:@"wind"];
    [windStepper setColor:[UIColor redColor]];
    [windStepper setButtonColor:[UIColor blueColor]];
    
    SKSpriteNode* rectangle = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0 green:0.7 blue:0.9 alpha:0.5] size:self.region.size];
    [rectangle setPosition:self.region.origin];
    [rectangle setAnchorPoint:CGPointMake(0, 0)];
    [rectangle setZPosition:100];
    [gameScene addChild:rectangle];
    
    RSButton* okButton = [[RSButton alloc]initWithText:@"OK"];
    [okButton setColor:[UIColor redColor]];
    okButton.position=CGPointMake(0, -temperatureLabel.frame.size.height*1.7);
    [okButton setSize:CGSizeMake(70, 40)];
    
    [self.popup setSize:CGSizeMake(temperatureLabel.frame.size.width+temperatureStepper.frame.size.width+40, temperatureLabel.frame.size.height*5.5)];
    
    [okButton setHandler:^{
        NSArray* childrenScene = [gameScene children];
        RSContainer* popup;
        
        for (SKNode* node in childrenScene){
            if ([node.name isEqualToString:@"PopupMain"]){
                popup=(RSContainer*)node;
            }
        }
        
        NSArray* childrenPopup = [popup children];
        RSStepper* stepper;
        
        for (SKNode* node in childrenPopup){
            if ([node.name isEqualToString:@"wind"]){
                stepper=(RSStepper*)node;
                ((RSField*)popup.attach).wind = [stepper getValueLabel];
            }
            if ([node.name isEqualToString:@"temperature"]){
                stepper=(RSStepper*)node;
                ((RSField*)popup.attach).temperature = [stepper getValueLabel];
            }
            
        }
        [rectangle removeFromParent];
        ((RSField*)popup.attach).changed=YES;
        [popup removeFromParent];
    }];
    
    [self.popup addChild:temperatureLabel];
    [self.popup addChild:windLabel];
    [self.popup addChild:temperatureStepper];
    [self.popup addChild:windStepper];
    [self.popup addChild:okButton];
    
    [self.popup setPosition:CGPointMake(500,200)];
    [gameScene addChild:self.popup];
    
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"temperature,pressure, wind,region: (%d, %d, %d, (%f,%f,%f,%f))", self.temperature, self.pressure, self.wind, self.region.origin.x, self.region.origin.y, self.region.size.width,self.region.size.height];
}


@end
