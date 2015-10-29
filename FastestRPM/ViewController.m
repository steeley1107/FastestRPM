//
//  ViewController.m
//  FastestRPM
//
//  Created by Steele on 2015-10-29.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *needleImage;
@property (nonatomic) float rpm;
@property (nonatomic) float rpmOffset;
@property (nonatomic) float minAngle;
@property (nonatomic) float maxAngle;
@property (nonatomic) float minSpeed;
@property (nonatomic) float maxSpeed;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.rpmOffset = -220*M_PI/180;
    self.minAngle = self.rpmOffset;
    self.maxAngle = 280*M_PI/180 + self.rpmOffset;
    
    self.rpm = self.minAngle;
    
    self.needleImage.transform = CGAffineTransformMakeRotation(self.rpm);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {
    
    CGPoint position = [sender velocityInView:self.view];
    float velocity = sqrtf(pow(position.x, 2) * pow(position.y, 2));
    self.maxSpeed = 2000000;
    self.minSpeed = 0;
    
    self.rpm = velocity / (self.maxSpeed - self.minSpeed) * (self.maxAngle - self.minAngle) + self.minAngle;
    self.needleImage.transform = CGAffineTransformMakeRotation(self.rpm);
    
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(setSpeedToZero)
                                       userInfo:nil
                                        repeats:NO];
    }
}

-(void)setSpeedToZero {
    self.rpm = self.minAngle;
    self.needleImage.transform = CGAffineTransformMakeRotation(self.rpm);
}

@end
