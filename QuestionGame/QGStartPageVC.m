//
//  QGStartPageVC.m
//  QuestionGame
//
//  Created by Elsa Filippidou on 04/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//

#import "QGStartPageVC.h"

@interface QGStartPageVC ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *infoBtn;
@property (nonatomic, strong) UIButton *howToPlayBtn;
@property (nonatomic, strong) UIButton *startGameBtn;

@end

@implementation QGStartPageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float offsetY = 80.0;
    float width = self.view.frame.size.width - 40;
    
    // title label
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setText:@"Welcome to Question Game!"];
    [self.titleLabel setNumberOfLines:3];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:40.0]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setFrame:CGRectMake(20, offsetY, width, 120.0)]; //dynamic height?
    [self.view addSubview:self.titleLabel];
    
    offsetY += self.titleLabel.frame.size.height + 50.0;
    
    // how to play button
    self.howToPlayBtn = [[UIButton alloc] init];
    [self.howToPlayBtn setTitle:@"How to play" forState:UIControlStateNormal];
    [self.howToPlayBtn addTarget:self action:@selector(showGameInstructions:) forControlEvents:UIControlEventTouchUpInside];
    [self.howToPlayBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
    [self.howToPlayBtn setFrame:CGRectMake(20, offsetY, width, 30.0)];
    [self.howToPlayBtn setBackgroundColor:[UIColor magentaColor]];
    [self.view addSubview:self.howToPlayBtn];
    
    offsetY += self.howToPlayBtn.frame.size.height + 8.0;
    
    // start game button
    self.startGameBtn = [[UIButton alloc] init];
    [self.startGameBtn setTitle:@"Start Game" forState:UIControlStateNormal];
    [self.startGameBtn addTarget:self action:@selector(showStartGamePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.startGameBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
    [self.startGameBtn setFrame:CGRectMake(20, offsetY, width, 30.0)];
    [self.startGameBtn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.startGameBtn];
    
    // info button
    self.infoBtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [self.infoBtn addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.infoBtn setTintColor:[UIColor magentaColor]];
    [self.infoBtn setFrame:CGRectMake(width, 40, 21, 21)];
    [self.view addSubview:self.infoBtn];
}

- (void)showInfo:(UIButton*)sender
{
    
}

- (void)showGameInstructions:(UIButton*)sender
{
    
}

- (void)showStartGamePage:(UIButton*)sender
{
    
}

@end
