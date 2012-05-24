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

/*********************************************************************
 METHOD : GET ALL USER'S LECTURE OBJECTS FROM USER-DATA AND CURRENT WEEK
 ACCEPTS: Student/Admin object, NSArray of Lecture objects, NSUInteger of current week    
 RETURNS: NSArray with Lecture objects
 *********************************************************************/
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

/*********************************************************************
 METHOD : GET ALL LECTURE OBJECTS SORTED IN MONDAY - FRIDAY
 ACCEPTS: NSArray with Lecture objects
 RETURNS: NSDictionary with Lecture objects sorted in KEYS MONDAY - FRIDAY
 *********************************************************************/
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

/*********************************************************************
 METHOD : GET LECTURE OBJECTS FROM USER-DATA AND CURRENT DAY
 ACCEPTS: Student/Admin object
 RETURNS: NSSet with Lecture objects
 *********************************************************************/
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

/*********************************************************************
 METHOD : GET ALL USER'S NOTE OBJECTS FROM USER-DATA AND CURRENT WEEK
 ACCEPTS: Student/Admin object, NSArray of Note objects, NSUInteger of current week    
 RETURNS: NSArray with Note objects 
 *********************************************************************/
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

/*********************************************************************
 METHOD : GET ALL NOTE OBJECTS SORTED IN MONDAY - FRIDAY
 ACCEPTS: NSArray with Note objects
 RETURNS: NSDictionary with Note objects sorted in KEYS MONDAY - FRIDAY
 *********************************************************************/
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

/*********************************************************************
 METHOD : UPDATE LECTURE OBJECT TEMPLATE WITH VERSION 1 - SUPPLY WITH JSON
 ACCEPTS: NSString with number of ID, NSArray with Lecture objects, NSString PATH to JSON DATA
 RETURNS: NONE
 *********************************************************************/
-(void)updateLectureTemplate:(NSString *)courseID lectures:(NSArray *)lectures jsonPath:(NSString*)jsonPath {
    for(Lecture* lec in lectures) {
        if([[lec courseID]isEqualTo:courseID]&&[[lec version]isEqualTo:@"1"]) {
            NSLog(@"FOUND: %@", lec);
            NSData *data = [NSData dataWithContentsOfFile:jsonPath];
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data 
                                                                        options:NSJSONReadingMutableContainers 
                                                                          error:NULL];
            [dict setObject:[lec couchDBId] forKey:@"_id"];
            [dict setObject:[lec couchDBRev] forKey:@"_rev"];
            [dict setObject:@"1" forKey:@"version"];
            [DBService lectureToDataBase:dict];
            
            break;
        }
    }
}

/*********************************************************************
 METHOD : UPDATE LECTURE OBJECT - CREATE MODIFIED INSTANCE OR EDIT INSTANCE - SUPPLY WITH JSON
 ACCEPTS: NSString with number of ID, NSString with number of version, NSArray with Lecture objects, NSString PATH to JSON DATA
 RETURNS: NONE
 *********************************************************************/
-(void)updateLectureEvent:(NSString *)courseID version:(NSString*)version lectures:(NSArray *)lectures jsonPath:(NSString*)jsonPath {
    for(Lecture* lec in lectures) {
        if([[lec courseID]isEqualTo:courseID]&&[[lec version]isEqualTo:version]) {
            NSLog(@"FOUND: %@", lec);
            NSData *data = [NSData dataWithContentsOfFile:jsonPath];
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data 
                                                                        options:NSJSONReadingMutableContainers 
                                                                          error:NULL];
            if(version==@"1") {
                // CREATE NEW EVENT
                // VERSION STAMP
                NSString* ver = @"1";
                for(Lecture* lec in lectures) {
                    if([[lec courseID]isEqualTo:[dict objectForKey:@"courseID"]]&&[[lec version]isGreaterThan:ver]) {
                        ver = [lec version];
                        NSLog(@"VER: %@", [lec version]);
                    }
                }
                int verInt = [ver intValue];
                verInt +=1;
                ver = [NSString stringWithFormat:@"%d", verInt];
                NSLog(@"VERSION %@", ver);
                [dict setObject:ver forKey:@"version"];
                NSLog(@"%@", dict);
                [DBService lectureToDataBase:dict];
                
            }
            else {
                // EDIT EXISTING EVENT
                [dict setObject:[lec couchDBId] forKey:@"_id"];
                [dict setObject:[lec couchDBRev] forKey:@"_rev"];
                [dict setObject:[lec version] forKey:@"version"];
                [DBService lectureToDataBase:dict];
            }
            break;
        }
    }
}

/*********************************************************************
 METHOD : UPDATE LECTURE OBJECT TEMPLATE WITH VERSION 1 - SUPPLY WITH OBJECT
 ACCEPTS: Lecture object
 RETURNS: NONE
 *********************************************************************/
-(void)updateLectureTemplate:(id)lecture {
    // check if class is Lecture object
}

/*********************************************************************
 METHOD : UPDATE LECTURE OBJECT - CREATE MODIFIED INSTANCE OR EDIT INSTANCE - SUPPLY WITH OBJECT
 ACCEPTS: Lecture object
 RETURNS: NONE
 *********************************************************************/
-(void)updateLectureEvent:(id)lecture {
    // check if class is Lecture object
}

/*********************************************************************
 METHOD : PRINT ALL LECTURE OBJECTS WITH RELATED NOTE OBJECTS - CONSOLE
 ACCEPTS: NSDictionary with sorted Lecture objects, NSDictionary with sorted Note objects
 RETURNS: NONE
 *********************************************************************/
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

/*********************************************************************
 METHOD : PRINT ALL LECTURE OBJECTS - CONSOLE
 ACCEPTS: NSDictionary with sorted Lecture objects
 RETURNS: NONE
 *********************************************************************/
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
