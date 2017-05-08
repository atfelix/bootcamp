//
//  ViewController.m
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "GameModel.h"
#import "Player.h"
#import "Question.h"

@interface ViewController ()

@property (nonatomic) GameModel *game;
@property (nonatomic, assign) NSUInteger currentAnswer;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *player1ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *player2ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctnessLabel;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *submitAnswerButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.game = [[GameModel alloc] init];
    [self.button0 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.button1 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.button3 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.button4 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.button5 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.button6 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.button7 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.button8 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.button9 addTarget:self
                     action:@selector(digitButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];

    [self.submitAnswerButton addTarget:self
                                action:@selector(submit)
                      forControlEvents:UIControlEventTouchUpInside];

    [self updateQuestionLabel];
    self.correctnessLabel.alpha = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateCurrentAnswerLabel {
    self.currentAnswerLabel.text = [NSString stringWithFormat:@"Current Answer: %ld", self.currentAnswer];
}

-(void) updatePlayerLabels {
    NSArray<NSNumber *> *scores = [self.game getGameState];

    if (scores.count != 2) {
        NSLog(@"There's an error");
        exit(EXIT_FAILURE);
    }

    self.player1ScoreLabel.text = [NSString stringWithFormat:@"Player 1: %@\n",scores[0]];
    self.player2ScoreLabel.text = [NSString stringWithFormat:@"Player 2: %@\n", scores[1]];
}

-(void) updateQuestionLabel {
    self.questionLabel.text = [NSString stringWithFormat:@"Player %lu: %lu + %lu?",
                               self.game.currentIndex + 1,
                               self.game.currentQuestion.leftValue,
                               self.game.currentQuestion.rightValue];
}

-(void) updateLabels {
    [self updateCurrentAnswerLabel];
    [self updatePlayerLabels];
    [self updateQuestionLabel];
}

-(void) digitButtonTapped:(UIButton *) sender {
    self.currentAnswer = (10 * self.currentAnswer) + [sender.titleLabel.text intValue];
    [self updateCurrentAnswerLabel];
}

-(void) displayCorrectnessLabel:(BOOL)correctness {
    if (correctness) {
        self.correctnessLabel.backgroundColor = [UIColor greenColor];
        self.correctnessLabel.text = @"Correct";
    }
    else {
        self.correctnessLabel.backgroundColor = [UIColor redColor];
        self.correctnessLabel.text = @"Wrong";
    }
    self.correctnessLabel.alpha = 1;

    [UIView animateWithDuration:1
                     animations:^{
                         self.correctnessLabel.alpha = 0;
                     }];
}

-(void) evaluateAnswer {
    BOOL correctAnswer = [self.game takeTurnWithAnswer:self.currentAnswer];

    [self displayCorrectnessLabel:correctAnswer];

    self.currentAnswer = 0;
}

-(void) submit {
    [self evaluateAnswer];

    if (self.game.gameOver) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Player %lu won", self.game.currentIndex + 1]
                                                                       message:@"Would you like to play again?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYES = [UIAlertAction actionWithTitle:@"Yes"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action){
                                                              [self.game restart];
                                                              [self updateLabels];
                                                          }];
        UIAlertAction *actionNO = [UIAlertAction actionWithTitle:@"No"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){
                                                             exit(EXIT_SUCCESS);
                                                         }];
        [alert addAction:actionYES];
        [alert addAction:actionNO];

        [self presentViewController:alert
                           animated:YES
                         completion:nil];
    }

    [self updateLabels];
}

@end
