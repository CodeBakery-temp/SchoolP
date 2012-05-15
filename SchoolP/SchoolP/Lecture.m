#import "Lecture.h"

@implementation Lecture {
    NSMutableArray *lessonDays;
    NSMutableArray *lessonWeeks;
}

@synthesize course = _course;
@synthesize grade = _grade;
@synthesize teacher = _teacher;
@synthesize room = _room;
@synthesize courseID = _courseID;
@synthesize startTime = _startTime;
@synthesize stopTime = _stopTime;
@synthesize lunchStart = _lunchStart;
@synthesize lunchStop = _lunchStop;
@synthesize year = _year;

// daysOfWeek
// weeks

+(id) courseWithName:(NSString *)course
               grade:(NSString *)grade
             teacher: (NSString*)teacher
                room: (NSString*)room
            courseID:(NSString *)courseID
           startTime:(NSString *)startTime
            stopTime:(NSString *)stopTime
          lunchStart:(NSString *)lunchStart
           lunchStop:(NSString *)lunchStop
                year:(NSString *)year
          daysOfWeek:(NSArray *)daysOfWeek
               weeks:(NSArray *)weeks {
    return [[self alloc]initCourseWithName:course
                                     grade:grade
                                   teacher:teacher
                                      room:room
                                  courseID:courseID
                                 startTime:startTime
                                  stopTime:stopTime
                                lunchStart:lunchStart
                                 lunchStop:lunchStop
                                      year:year
                                daysOfWeek:daysOfWeek
                                     weeks:weeks];
}

-(id) initCourseWithName:(NSString *)course
                   grade:(NSString *)grade
                 teacher: (NSString*)teacher
                    room: (NSString*)room
                courseID:(NSString *)courseID
               startTime:(NSString *)startTime
                stopTime:(NSString *)stopTime
              lunchStart:(NSString *)lunchStart
               lunchStop:(NSString *)lunchStop
                    year:(NSString *)year
              daysOfWeek:(NSArray *)daysOfWeek
                   weeks:(NSArray *)weeks {
    if(self = [super init]) {
        
        lessonDays = [NSMutableArray array];
        for (NSDictionary *object in daysOfWeek) {
            [lessonDays addObject:object];
        }
        lessonWeeks = [NSMutableArray array];
        for (NSDictionary *object in weeks) {
            [lessonWeeks addObject:object];
        }
        
        _course = course;
        _grade = grade;
        _teacher = teacher;
        _room = room;
        _courseID = courseID;
        _startTime = startTime;
        _stopTime = stopTime;
        _lunchStart = lunchStart;
        _lunchStop = lunchStop;
        _year = year;
        
    }
    return self;
}

-(NSMutableArray *)daysOfWeek {
    return lessonDays;
}

-(NSMutableArray *)weeks {
    return lessonWeeks;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"\nCourse: %@,\nGrade: %@, \nTeacher: %@, \nRoom: %@, \nCourseID: %@, \nTime: %@-%@, \nLunch: %@-%@, \nYear: %@, \nDays: %@ \nWeeks: %@",
            self.course,
            self.grade,
            self.teacher,
            self.room,
            self.courseID,
            self.startTime,
            self.stopTime,
            self.lunchStart,
            self.lunchStop,
            self.year,
                [lessonDays componentsJoinedByString:@", "], [lessonWeeks componentsJoinedByString:@", "]];
}

-(void)printLecture {
    NSLog(@"________________________________________________");
    NSLog(@"\nCourse: %@, %@, \nTeacher: %@, \nRoom: %@, \nCourseID: %@, \nTime: %@-%@, \nLunch: %@-%@, \nYear: %@, \n",
          self.course,
          self.grade,
          self.teacher,
          self.room,
          self.courseID,
          self.startTime,
          self.stopTime,
          self.lunchStart,
          self.lunchStop,
          self.year);
}

@end
