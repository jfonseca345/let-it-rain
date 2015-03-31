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
    return self;
}

//-(void) addSprite:(RSSprite*) sprite{
 //   [self.sprites addObject:sprite];
//}
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
    temperatureLabel.position = CGPointMake(-(temperatureLabel.frame.size.width)/2, temperatureLabel.frame.size.height*1.25);
    SKLabelNode* windLabel = [[SKLabelNode alloc] initWithFontNamed:@"Verdana"];
    [windLabel setName:@"windLabel"];
    [windLabel setText:@"Vento:"];
    windLabel.position = CGPointMake(-(temperatureLabel.frame.size.width)/2, temperatureLabel.frame.size.height*0.25-10);
    
    
    //RSStepper* pressureStepper = [[RSStepper alloc]initWithProperties:self.pressure andMinValue:0 andMaxValue:50 andAmount:25];
    RSStepper* temperatureStepper = [[RSStepper alloc] initWithProperties:self.temperature andMinValue:-5 andMaxValue:5 andAmount:1];
    temperatureStepper.position = CGPointMake(20+(temperatureLabel.frame.size.width)/2, temperatureLabel.frame.size.height*1.5-10);
    [temperatureStepper setName:@"temperature"];
    [temperatureStepper setColor:[UIColor redColor]];
    [temperatureStepper setButtonColor:[UIColor blueColor]];
    
    RSStepper* windStepper = [[RSStepper alloc]initWithProperties:self.wind andMinValue:-10 andMaxValue:10 andAmount:1];
    windStepper.position = CGPointMake(20+(temperatureLabel.frame.size.width)/2, temperatureLabel.frame.size.height*0.25-20);
    [windStepper setName:@"wind"];
    [windStepper setColor:[UIColor redColor]];
    [windStepper setButtonColor:[UIColor blueColor]];
    
    RSButton* okButton = [[RSButton alloc]initWithText:@"OK"];
    [okButton setColor:[UIColor redColor]];
    okButton.position=CGPointMake(0, -temperatureLabel.frame.size.height*1.5);
    [self.popup setSize:CGSizeMake(temperatureLabel.frame.size.width+temperatureStepper.frame.size.width+20, temperatureLabel.frame.size.height*5)];
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
