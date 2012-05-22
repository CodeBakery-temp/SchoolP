#import "ScheduleService.h"
#import "Admin.h"
#import "Student.h"
#import "Lecture.h"
#import "DBService.h"
#import "Note.h"
#import "Message.h"
#import "Menu.h"

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
    //NSLog(@"WEEK %lu", currentWeek);
    //NSLog(@"USER %@", [user mailAddress]);
    //NSLog(@"LECTURES %@", lectures);
    NSMutableArray* userLectures = [NSMutableArray array];
    for(NSString* courseID in [user courses]) {                                              // loop every student's courses
        for(id lecture in lectures) {                                                   // loop every school course
            if([courseID isEqualTo:[lecture courseID]]) {                                       // if course is on student's list
                for(NSString* week in [lecture weeks]) {                                        // loop all weeks course is   
                    if([week isEqualTo:[NSString stringWithFormat:@"%d", currentWeek]]) {       // if course is within current week
                        //NSLog(@"%@, %@", [user firstName], [lecture course]);
                        [userLectures addObject:lecture];
                    }      
                }
            }
        }
    }
    return userLectures;
}



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

-(NSSet*)getLecturesOfDay:(id)user {
    NSDate *date = [NSDate date];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEEE"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSWeekCalendarUnit fromDate:date];
    
    NSSet* lecturesOfDay;
    if(!lecturesOfDay) {
        DBService* db = [DBService database];
        NSArray* lectures = [db getLectures];   // get all lectures
        NSArray* weekLectures = [self getLecturesOfWeek:user lectures:lectures currentWeek:[components week]];
        lecturesOfDay = [[self getLecturesPerDays:weekLectures]objectForKey:[[weekDay stringFromDate:date] uppercaseString]];
    }
    return lecturesOfDay;
}

-(NSArray*)getNotesOfWeek:(id)user notes:(NSArray *)notes currentWeek:(NSUInteger)currentWeek {
    NSMutableArray* userNotes = [NSMutableArray array];
    for(id course in [user courses]) {
        for(Note* note in notes) {
            if([[note courseID]isEqualTo:course]) {
                [userNotes addObject:note];
            }
        }
    }
    return userNotes;
}

-(NSDictionary*)getNotesPerDays:(NSArray *)notes {
    NSDictionary* notesDays = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                               [NSMutableArray array], @"MONDAY",
                               [NSMutableArray array], @"TUESDAY",
                               [NSMutableArray array], @"WEDNESDAY",
                               [NSMutableArray array], @"THURSDAY",
                               [NSMutableArray array], @"FRIDAY",nil];
    for(NSArray* day in notesDays) {
        for(Note* note in notes) {
            if(![[note day]caseInsensitiveCompare:[NSString stringWithFormat:@"%@", day]]) {
                [[notesDays objectForKey:day] addObject:note];
            }
        }
    }
    return notesDays;
}

-(void)printLecturesWithNotes:(NSDictionary *)lectures notes:(NSDictionary *)notes {
    NSLog(@"MONDAY");
    for(Lecture* lecture in [lectures objectForKey:@"MONDAY"]) {
        NSLog(@"%@", [lecture course]);
        for(Note* note in [notes objectForKey:@"MONDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"%@", [note text]);
            }
        }
    }
    NSLog(@"TUESDAY");
    for(Lecture* lecture in [lectures objectForKey:@"TUESDAY"]) {
        NSLog(@"%@", [lecture course]);
        for(Note* note in [notes objectForKey:@"TUESDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"%@", [note text]);
            }
        }
    }
    NSLog(@"WEDNESDAY");
    for(Lecture* lecture in [lectures objectForKey:@"WEDNESDAY"]) {
        NSLog(@"%@", [lecture course]);
        for(Note* note in [notes objectForKey:@"WEDNESDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"%@", [note text]);
            }
        }
    }
    NSLog(@"THURSDAY");
    for(Lecture* lecture in [lectures objectForKey:@"THURSDAY"]) {
        NSLog(@"%@", [lecture course]);
        for(Note* note in [notes objectForKey:@"THURSDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"%@", [note text]);
            }
        }
    }
    NSLog(@"FRIDAY");
    for(Lecture* lecture in [lectures objectForKey:@"FRIDAY"]) {
        NSLog(@"%@", [lecture course]);
        for(Note* note in [notes objectForKey:@"FRIDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"%@", [note text]);
            }
        }
    }
    
}

-(void)printWeek:(NSDictionary*) lecturesWeek {
    NSLog(@"MONDAY");
    for(Lecture* lec in [lecturesWeek objectForKey:@"MONDAY"]) {
        [lec printLecture];
    }
    NSLog(@"TUESDAY");
    for(Lecture* lec in [lecturesWeek objectForKey:@"TUESDAY"]) {
        [lec printLecture];
    }
    NSLog(@"WEDNESDAY");
    for(Lecture* lec in [lecturesWeek objectForKey:@"WEDNESDAY"]) {
        [lec printLecture];
    }
    NSLog(@"THURSDAY");
    for(Lecture* lec in [lecturesWeek objectForKey:@"THURSDAY"]) {
        [lec printLecture];
    }
    NSLog(@"FRIDAY");
    for(Lecture* lec in [lecturesWeek objectForKey:@"FRIDAY"]) {
        [lec printLecture];
    }
}

@end
