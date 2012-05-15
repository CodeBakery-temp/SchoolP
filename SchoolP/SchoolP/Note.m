#import "Note.h"

@implementation Note

@synthesize text = _text;
@synthesize week = _week;
@synthesize day = _day;
@synthesize courseID = _courseID;

+(id) noteWithText:(NSString *)text
              week:(NSString *)week
               day:(NSString *)day
          courseID:(NSString *)courseID{
    return [[self alloc]initNoteWithText:text
                                    week:week
                                     day:day
                                courseID:courseID];
}

-(id) initNoteWithText:(NSString *)text
                  week:(NSString *)week
                   day:(NSString *)day
              courseID:(NSString *)courseID{
    if(self = [super init])
    {
        _text = text;
        _week = week;
        _day = day;
        _courseID = courseID;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Text: %@, Week: %@, Day: %@, CourseID: %@",
            self.text,
            self.week,
            self.day,
            self.courseID];
}

@end
