#import "Lecture.h"

@implementation Lecture {
    NSMutableArray *lessonDays;
    NSMutableArray *lessonWeeks;
}

@synthesize couchDBId = _couchDBId;
@synthesize couchDBRev = _couchDBRev;

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
               weeks:(NSArray *)weeks 
           couchDBId: (NSString *) couchDBId
          couchDBRev: (NSString *) couchDBRev{
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
                                     weeks:weeks 
                                 couchDBId:couchDBId 
                                couchDBRev:couchDBRev];
}

-(id) initCourseWithName:(NSString *)course
                   grade:(NSString *)grade
                 teacher:(NSString*)teacher
                    room:(NSString*)room
                courseID:(NSString *)courseID
               startTime:(NSString *)startTime
                stopTime:(NSString *)stopTime
              lunchStart:(NSString *)lunchStart
               lunchStop:(NSString *)lunchStop
                    year:(NSString *)year
              daysOfWeek:(NSArray *)daysOfWeek
                   weeks:(NSArray *)weeks
               couchDBId:(NSString *) couchDBId
              couchDBRev:(NSString *) couchDBRev; {
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
        _couchDBId = couchDBId;
        _couchDBRev = couchDBRev;
        
    }
    return self;
}

-(id) asDictionary {
    
    if (self.couchDBId) {
        return [NSDictionary dictionaryWithObjectsAndKeys:self.course, @"course", 
                self.grade, @"grade", 
                self.teacher, @"teacher",
                self.room, @"room", 
                self.courseID, @"courseID",
                self.startTime, @"startTime", 
                self.stopTime, @"stopTime",
                self.lunchStart, @"lunchStart", 
                self.lunchStop, @"lunchStop",
                self.year, @"year",
                self.couchDBId, @"_id", 
                self.couchDBRev, @"_rev",
                lessonDays, @"lessondays",
                lessonWeeks, @"lessonWeeks", 
                nil];
    }
    else {
        return [NSDictionary dictionaryWithObjectsAndKeys:self.course, @"course", 
                self.grade, @"grade", 
                self.teacher, @"teacher",
                self.room, @"room", 
                self.courseID, @"courseID",
                self.startTime, @"startTime", 
                self.stopTime, @"stopTime",
                self.lunchStart, @"lunchStart", 
                self.lunchStop, @"lunchStop",
                self.year, @"year",
                lessonDays, @"lessondays",
                lessonWeeks, @"lessonWeeks", 
                nil];
    }
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
    NSLog(@"\nCourse: %@, %@, \nTeacher: %@, \nRoom: %@, \nCourseID: %@, \nTime: %@-%@, \nLunch: %@-%@, \nYear: %@, \n_id: %@, \n_rev: %@ \n ",
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
          self.couchDBId,
          self.couchDBRev);
}

@end
