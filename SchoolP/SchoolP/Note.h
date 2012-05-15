#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) NSString* week;
@property (nonatomic, copy) NSString* day;
@property (nonatomic, copy) NSString* courseID;

+(id) noteWithText: (NSString *)text
              week: (NSString *)week
               day: (NSString *)day
          courseID: (NSString *)courseID;

-(id) initNoteWithText: (NSString *)text
                  week: (NSString *)week
                   day: (NSString *)day
              courseID: (NSString *)courseID;

@end
