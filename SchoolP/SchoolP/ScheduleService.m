#import "ScheduleService.h"
#import "Admin.h"
#import "Student.h"
#import "Lecture.h"

@implementation ScheduleService

+(id)schedule {
    return [self createSchedule];
}
+(id)createSchedule {
    return [[self alloc] initSchedule];
}

-(id)init {
    return [self initSchedule];
}
-(id)initSchedule {
    if(self = [super init])
    {}
    return self;
}


-(NSArray*)getLecturesOfWeek:(id)user lectures:(NSArray *)lectures currentWeek: (NSUInteger) currentWeek {
    NSLog(@"%lu", currentWeek);
    NSLog(@"%@", [user mailAddress]);
    NSMutableArray* userLectures = [NSMutableArray array];
    for(NSString* courseID in [user courses]) {                                              // loop every student's courses
        for(id lecture in lectures) {                                                   // loop every school course
            if([courseID isEqualTo:[lecture courseID]]) {                                       // if course is on student's list
                for(NSString* week in [lecture weeks]) {                                        // loop all weeks course is   
                    if([week isEqualTo:[NSString stringWithFormat:@"%d", currentWeek]]) {       // if course is within current week
                        NSLog(@"%@, %@", [user firstName], [lecture course]);
                        [userLectures addObject:lecture];
                    }      
                }
            }
        }
    }
    return userLectures;
}

//-(NSArray*)getLecturesOfDay:(id)user lectures:(NSArray *)lectures currentWeek:(NSUInteger)currentWeek {}

-(NSDictionary*)getLecturesPerDays:(NSArray *)lectures {
    NSDictionary* lecturesDays = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSMutableArray array], @"MONDAY",
                                  [NSMutableArray array], @"TUESDAY",
                                  [NSMutableArray array], @"WEDNESDAY",
                                  [NSMutableArray array], @"THURSDAY",
                                  [NSMutableArray array], @"FRIDAY",nil];
    for(NSArray* day in lecturesDays) {
        //NSLog(@"DICTIONARY DAY %@", day);
        for(Lecture* lecture in lectures) {
            for(NSString* weekDay in [lecture daysOfWeek]) {
                if(![weekDay caseInsensitiveCompare:[NSString stringWithFormat:@"%@", day]]) {
                    //NSLog(@"WEEKDAY %@", weekDay);
                    [[lecturesDays objectForKey:day] addObject:lecture];
                }
            }
        }
    }
    return lecturesDays;
    
}

@end
