#import <Foundation/Foundation.h>

@interface Lecture : NSObject

@property (nonatomic, copy) NSString *course;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, copy) NSString *courseID;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *stopTime;
@property (nonatomic, copy) NSString *lunchStart;
@property (nonatomic, copy) NSString *lunchStop;
@property (nonatomic, copy) NSString *year;

// daysOfWeek
// weeks

+ (id) courseWithName: (NSString *)course grade: (NSString *) grade teacher: (NSString*) teacher room: (NSString*) room courseID: (NSString *) courseID startTime: (NSString *) startTime stopTime: (NSString *) stopTime lunchStart: (NSString *) lunchStart lunchStop: (NSString *) lunchStop year: (NSString *) year daysOfWeek: (NSArray *) daysOfWeek weeks: (NSArray *) weeks;

- (id) initCourseWithName: (NSString *)course grade: (NSString *) grade teacher: (NSString*) teacher room: (NSString*) room courseID: (NSString *) courseID startTime: (NSString *) startTime stopTime: (NSString *) stopTime lunchStart: (NSString *) lunchStart lunchStop: (NSString *) lunchStop year: (NSString *) year daysOfWeek: (NSArray *) daysOfWeek weeks: (NSArray *) weeks ;

-(NSMutableArray *)daysOfWeek;

-(NSMutableArray *)weeks;

-(void)printLecture;

@end