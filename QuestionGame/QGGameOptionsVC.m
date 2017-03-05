//
//  QGGameOptionsVC.m
//  QuestionGame
//
//  Created by Elsa Filippidou on 04/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//

#import "QGGameOptionsVC.h"
#import "QGOptionButton.h"
#import "QGOpenTriviaManager.h"

@interface QGGameOptionsVC ()

@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) QGOptionButton *generalBtn;
@property (nonatomic, strong) QGOptionButton *musicBtn;
@property (nonatomic, strong) QGOptionButton *filmsBtn;
@property (nonatomic, strong) QGOptionButton *computersBtn;

@property (nonatomic, strong) UILabel *difficultyLabel;
@property (nonatomic, strong) QGOptionButton *easyBtn;
@property (nonatomic, strong) QGOptionButton *mediumBtn;
@property (nonatomic, strong) QGOptionButton *hardBtn;

@property (nonatomic, strong) NSArray *categoryButtons;
@property (nonatomic, strong) NSArray *difficultyButtons;

@property (nonatomic, strong) UIButton *startGameBtn;

@property (nonatomic, assign) QGCategories selectedCategory;
@property (nonatomic, assign) QGDifficulty selectedDifficulty;

@end

@implementation QGGameOptionsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedCategory = 0;
    self.selectedDifficulty = 0;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.categoryLabel = [[UILabel alloc] init];
    [self.categoryLabel setText:@"Choose Category:"];
    [self.categoryLabel setTextAlignment:NSTextAlignmentCenter];
    [self.categoryLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
    [self.view addSubview:self.categoryLabel];
    
    self.generalBtn = [[QGOptionButton alloc] init];
    [self.generalBtn setTitle:@"General" forState:UIControlStateNormal];
    [self.view addSubview:self.generalBtn];
    
    self.musicBtn = [[QGOptionButton alloc] init];
    [self.musicBtn setTitle:@"Music" forState:UIControlStateNormal];
    [self.view addSubview:self.musicBtn];
    
    self.filmsBtn = [[QGOptionButton alloc] init];
    [self.filmsBtn setTitle:@"Films" forState:UIControlStateNormal];
    [self.view addSubview:self.filmsBtn];
    
    self.computersBtn = [[QGOptionButton alloc] init];
    [self.computersBtn setTitle:@"Tech" forState:UIControlStateNormal];
    [self.view addSubview:self.computersBtn];
    
    self.difficultyLabel = [[UILabel alloc] init];
    [self.difficultyLabel setText:@"Choose Difficulty:"];
    [self.difficultyLabel setTextAlignment:NSTextAlignmentCenter];
    [self.difficultyLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
    [self.view addSubview:self.difficultyLabel];
    
    self.easyBtn = [[QGOptionButton alloc] init];
    [self.easyBtn setTitle:@"easy" forState:UIControlStateNormal];
    [self.view addSubview:self.easyBtn];
    self.mediumBtn = [[QGOptionButton alloc] init];
    [self.mediumBtn setTitle:@"medium" forState:UIControlStateNormal];
    [self.view addSubview:self.mediumBtn];
    self.hardBtn = [[QGOptionButton alloc] init];
    [self.hardBtn setTitle:@"hard" forState:UIControlStateNormal];
    [self.view addSubview:self.hardBtn];
    
    self.categoryButtons = @[self.generalBtn, self.musicBtn, self.filmsBtn, self.computersBtn];
    self.difficultyButtons = @[self.easyBtn, self.mediumBtn, self.hardBtn];
    
    // set common properties for all buttons
    for (QGOptionButton *btn in self.categoryButtons){
        [btn setType:QGOptionButtonTypeCategory];
        [btn addTarget:self action:@selector(toggleOptions:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (QGOptionButton *btn in self.difficultyButtons){
        [btn setType:QGOptionButtonTypeDifficulty];
        [btn addTarget:self action:@selector(toggleOptions:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    [backButton setTintColor:[UIColor magentaColor]];
    self.navigationItem.leftBarButtonItem = backButton;
    
    // start game button
    self.startGameBtn = [[UIButton alloc] init];
    [self.startGameBtn setTitle:@"Ready!" forState:UIControlStateNormal];
    [self.startGameBtn addTarget:self action:@selector(downloadQuestionsAndStartGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.startGameBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [self.startGameBtn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.startGameBtn];
}

- (void)viewDidLayoutSubviews
{
    float offsetY = 120.0;
    float maxWidth = self.view.frame.size.width - 40;
    
    [self.categoryLabel setFrame:CGRectMake(20, offsetY, maxWidth, 21)];
    
    offsetY += self.categoryLabel.frame.size.height + 20;
    
    float offsetX = 20;
    float btnWidth = (maxWidth - 3*8)/4;
    
    [self.generalBtn setFrame:CGRectMake(offsetX, offsetY, btnWidth, 40)];
    
    offsetX +=  btnWidth + 8;
    [self.musicBtn setFrame:CGRectMake(offsetX, offsetY, btnWidth, 40)];
    
    offsetX += btnWidth + 8;
    [self.filmsBtn setFrame:CGRectMake(offsetX, offsetY, btnWidth, 40)];
    
    offsetX += btnWidth + 8;
    [self.computersBtn setFrame:CGRectMake(offsetX, offsetY, btnWidth, 40)];
    
    offsetY += self.generalBtn.frame.size.height + 30;
    
    [self.difficultyLabel setFrame:CGRectMake(20, offsetY, maxWidth, 21)];
    
    offsetY += self.difficultyLabel.frame.size.height + 20;
    
    offsetX = 20;
    btnWidth = (maxWidth - 2*8)/3;
    [self.easyBtn setFrame:CGRectMake(offsetX, offsetY, btnWidth, 40)];
    
    offsetX += btnWidth + 8;
    [self.mediumBtn setFrame:CGRectMake(offsetX, offsetY, btnWidth, 40)];
    
    offsetX += btnWidth + 8;
    [self.hardBtn setFrame:CGRectMake(offsetX, offsetY, btnWidth, 40)];
    
    // turn off all options
    for (QGOptionButton *btn in self.categoryButtons){
        [btn setIsSelected:NO];
    }
    for (QGOptionButton *btn in self.difficultyButtons){
        [btn setIsSelected:NO];
    }
    
    [self.startGameBtn setFrame:CGRectMake(20, self.view.frame.size.height - 60.0, maxWidth, 30.0)];
}

- (void)toggleOptions:(QGOptionButton*)sender
{
    sender.isSelected = !sender.isSelected;
    
    if (sender.isSelected) {
        // turn off other options
        if (sender.type == QGOptionButtonTypeCategory) {
            
            self.selectedCategory = [self.categoryButtons indexOfObject:sender];
            
            for (QGOptionButton *btn in self.categoryButtons){
                if (![btn isEqual:sender]) {
                    btn.isSelected = NO;
                    [btn layoutSubviews];
                }
            }
        }
        else if (sender.type == QGOptionButtonTypeDifficulty){
            
            self.selectedDifficulty = [self.difficultyButtons indexOfObject:sender];
            
            for (QGOptionButton *btn in self.difficultyButtons){
                if (![btn isEqual:sender]) {
                    btn.isSelected = NO;
                    [btn layoutSubviews];
                }
            }
        }
    }
}

- (void)goBack:(UIButton*)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)downloadQuestionsAndStartGame:(UIButton*)sender
{
    [[QGOpenTriviaManager sharedInstance] getQuestionsForCategory:self.selectedCategory
                                                numberOfQuestions:50
                                                       difficulty:self.selectedDifficulty
                                                             type:QGAnswerTypeAny
                                                         encoding:QGEncodingDefault
                                                  completionBlock:^(BOOL success, NSError *error) {
                                                      
                                                      if (success && !error) {
                                                          // continue with game
                                                      }
                                                      else {
                                                          // show alert
                                                      }
                                                  }];
}


@end
