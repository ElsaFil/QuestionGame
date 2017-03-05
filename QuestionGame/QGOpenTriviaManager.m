//
//  QGOpenTriviaManager.m
//  QuestionGame
//
//  Created by Elsa Filippidou on 04/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//

#import "QGOpenTriviaManager.h"
#import "Question+CoreDataClass.h"
#import "Answer+CoreDataClass.h"
#import "AppDelegate.h"

NSString *baseURL = @"https://www.opentdb.com/api.php?";

@implementation QGOpenTriviaManager

+ (instancetype)sharedInstance
{
    static QGOpenTriviaManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[QGOpenTriviaManager alloc] init];
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [spinner setHidesWhenStopped:YES];
    });
    return sharedInstance;
}

- (void)getQuestionsForCategory:(QGCategories)category numberOfQuestions:(NSInteger)count difficulty:(QGDifficulty)difficulty type:(QGAnswerType)type encoding:(QGEncoding)encoding completionBlock:(void (^)(BOOL, NSError *))completionHandler
{
    [self startSpinner];
    
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
                    if (completionHandler){
                        completionHandler(NO, connectionError);
                    }
                    return;
                }
                
                NSError *error;
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSArray *questions = [result objectForKey:@"results"];
                
                if (error) {
                    if (completionHandler){
                        completionHandler(NO, error);
                    }
                    return;
                }
                
                AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
                
                for (int i = 0; i < questions.count; i++) {
                    
                    NSDictionary *questionJSON = [questions objectAtIndex:i];
                    
                    // prepare question
                    Question *nQuestion = [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:context];
                    nQuestion.questionText = [questionJSON objectForKey:@"question"];
                    nQuestion.category = [questionJSON objectForKey:@"category"];
                    nQuestion.type = [questionJSON objectForKey:@"type"];
                    nQuestion.diffuculty = [questionJSON objectForKey:@"difficulty"];
                    
                    // prepare answers - multiple selection and true/false are handled the same
                    
                    Answer *corrAnswer = [NSEntityDescription insertNewObjectForEntityForName:@"Answer" inManagedObjectContext:context];
                    corrAnswer.answerText = [questionJSON objectForKey:@"correct_answer"];
                    corrAnswer.isCorrect = YES;
                    corrAnswer.question = nQuestion;
                    
                    for (NSString *answerString in [questionJSON objectForKey:@"incorrect_answers"]){
                        Answer *answer = [NSEntityDescription insertNewObjectForEntityForName:@"Answer" inManagedObjectContext:context];
                        answer.answerText = answerString;
                        answer.isCorrect = NO;
                        answer.question = nQuestion;
                    }
                    
                    NSError *savingError = nil;
                    if (![context save:&savingError]) {
                        NSLog(@"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                        if (completionHandler){
                            completionHandler(NO, savingError);
                        }
                        return;
                    }
                }
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [weakSelf stopSpinner];
                    if (completionHandler){
                        completionHandler(YES, nil);
                    }
                    return;
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
        case QGAnswerTypeAny: // will return nil
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

- (void)startSpinner
{
    [self.spinner startAnimating];
}

- (void)stopSpinner
{
    [self.spinner stopAnimating];
}

@end
