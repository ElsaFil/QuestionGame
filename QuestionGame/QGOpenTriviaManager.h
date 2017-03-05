//
//  QGOpenTriviaManager.h
//  QuestionGame
//
//  Created by Elsa Filippidou on 04/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//
//
// Open Trivia Database API documentation: https://opentdb.com/api_config.php

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *baseURL;

typedef NS_ENUM (NSUInteger,QGCategories) {
    QGCategoryGeneral = 0,
    QGCategoryFilm,
    QGCategoryMusic,
    QGCategoryComputers
};
typedef NS_ENUM (NSUInteger,QGDifficulty) {
    QGDifficultyEasy = 0,
    QGDifficultyMedium,
    QGDifficultyHard
};
typedef NS_ENUM (NSUInteger,QGAnswerType) {
    QGAnswerTypeAny = 0,
    QGAnswerTypeMultipleChoice,
    QGAnswerTypeTrueFalse
};
typedef NS_ENUM (NSUInteger,QGEncoding) {
    QGEncodingDefault = 0, /* Default */
    QGEncodingLegacyURL, /* Legacy URL Encoding */
    QGEncodingRFC_URL, /* URL Encoding (RFC 3986) */
    QGEncodingBase64 /* Base64 Encoding */
};

@interface QGOpenTriviaManager : NSObject

@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, strong) NSString *difficulty;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *encoding;

@property (nonatomic, strong) UIActivityIndicatorView *spinner;

+ (instancetype)sharedInstance;

/**
 @brief Makes a REST call to the Open Trivia Database API to fetch questions and answers following the specified (or the default) parameters.
 @param category Category of the questions. Default: any
 @param count Number of questions to return. Default: 10. Maximum: 50 per API call.
 @param difficulty The difficulty level of the questions. Default: any
 @param type The type of the answer (multiple selection or true/false). Default: any
 @param encoding The encoding of the questions in the result. Default: default encoding of the API that does not include special characters.
 */
- (void)getQuestionsForCategory:(QGCategories)category numberOfQuestions:(NSInteger)count difficulty:(QGDifficulty)difficulty type:(QGAnswerType)type encoding:(QGEncoding)encoding completionBlock:(void (^)(BOOL success, NSError *error))completionHandler;

@end
