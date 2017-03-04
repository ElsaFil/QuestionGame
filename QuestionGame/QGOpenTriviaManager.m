//
//  QGOpenTriviaManager.m
//  QuestionGame
//
//  Created by Elsa Filippidou on 04/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//

#import "QGOpenTriviaManager.h"

NSString *baseURL = @"https://www.opentdb.com/api.php?";

@implementation QGOpenTriviaManager

- (void)getQuestionsForCategory:(QGCategories)category numberOfQuestions:(NSInteger)count difficulty:(QGDifficulty)difficulty type:(QGAnswerType)type encoding:(QGEncoding)encoding
{
    self.amount = (count > 0)?count:10;
    self.category = category;
    self.difficulty = [self getDifficultyString:difficulty];
    self.type = [self getTypeString:type];
    self.encoding = [self getEncodingString:encoding];
    
    // construct the URL
    // e.g. https://www.opentdb.com/api.php?amount=10&category=12&difficulty=easy&type=multiple&encode=url3986
    NSString *urlString = baseURL;
    [urlString stringByAppendingString:[NSString stringWithFormat:@"&amount=%lu", self.amount]];
    [urlString stringByAppendingString:[NSString stringWithFormat:@"&category=%lu", self.category]];
    
    if (self.difficulty && self.difficulty.length > 0) {
        [urlString stringByAppendingString:[NSString stringWithFormat:@"&difficulty=%@", self.difficulty]];
    }
    if (self.type && self.type.length > 0){
        [urlString stringByAppendingString:[NSString stringWithFormat:@"&type=%@", self.type]];
    }
    if (self.encoding && self.encoding.length > 0){
        [urlString stringByAppendingString:[NSString stringWithFormat:@"&encode=%@", self.encoding]];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = nil;
    __weak QGOpenTriviaManager *weakSelf = self;
    task = [session dataTaskWithURL:url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *connectionError)
            {
                if (connectionError){
                    // handle error
                    return;
                }
                
                NSError *error;
                NSArray *questions = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                
                if (error) {
                    // handle error
                    return;
                }
                
                for (int i = 0; i < questions.count; i++) {
                    
                    NSDictionary *aQuestion = [questions objectAtIndex:i];
                    
                    // TODO setup Question and Answer objects
                    
                    // TODO save
                    
                }
                
                // update UI in main thread
                dispatch_sync(dispatch_get_main_queue(), ^{
                    // stop spinner
                    // start game
                });
                
            }];
    [task resume];
}

- (NSString*)getDifficultyString:(QGDifficulty)difficultyInteger
{
    NSString *result = nil;
    
    switch (difficultyInteger) {
        case QGDifficultyEasy:
            result = @"easy";
            break;
        case QGDifficultyMedium:
            result = @"medium";
            break;
        case QGDifficultyHard:
            result = @"hard";
            break;
        default:
            break;
    }
    
    return result;
}

- (NSString*)getTypeString:(QGAnswerType)answerTypeInteger
{
    NSString *result = nil;
    
    switch (answerTypeInteger) {
        case QGAnswerTypeMultipleChoice:
            result = @"multiple";
            break;
        case QGAnswerTypeTrueFalse:
            result = @"boolean";
            break;
        default:
            break;
    }
    
    return result;
}

- (NSString*)getEncodingString:(QGEncoding)encodingInteger
{
    NSString *result = nil;
    
    switch (encodingInteger) {
        case QGEncodingRFC_URL:
            result = @"url3986";
            break;
        case QGEncodingBase64:
            result = @"base64";
            break;
        default:
            break;
    }
    
    return result;
}

@end
