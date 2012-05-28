#import "DBService.h"
#import "ScheduleService.h"
#import "Menu.h"
#import "User.h"
#import "Lecture.h"
#import "Note.h"
#import "Message.h"

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
    if(self = [super init]) {
    }
    return self;
}

/*********************************************************************
 METHOD : GET ALL USER'S LECTURE OBJECTS FROM USER-DATA AND CURRENT WEEK
 ACCEPTS: Student/Admin object, NSArray of Lecture objects, NSUInteger of current week    
 RETURNS: NSArray with Lecture objects
 *********************************************************************/
-(NSArray*)getLecturesOfWeek:(User*)user 
                    lectures:(NSArray *)lectures
                 currentWeek: (NSUInteger) currentWeek {
    
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
 METHOD : GET ALL LECTURE OBJECTS SORTED NEWEST VERSION IN MONDAY - FRIDAY
 ACCEPTS: NSDictionary with Lecture objects sorted in KEYS MONDAY - FRIDAY
 RETURNS: NSDictionary with Lecture objects sorted only newest version in KEYS MONDAY - FRIDAY
 *********************************************************************/
-(NSDictionary*)getLecturesWithVersion:(NSDictionary *)lectures {
    NSDictionary* lecturesDays = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSMutableArray array], @"MONDAY",
                                  [NSMutableArray array], @"TUESDAY",
                                  [NSMutableArray array], @"WEDNESDAY",
                                  [NSMutableArray array], @"THURSDAY",
                                  [NSMutableArray array], @"FRIDAY",nil];
    for (NSString* weekDay in lectures){            // EACH WEEKDAY
        //NSLog(@"%@", weekDay);
        // CHECKS NUMBER OF DIFFERENT COURSES FOR EACH DAY
        NSString* top = @"0";
        for (Lecture* lec in [lectures objectForKey:weekDay]){ // EACH LECTURE IN CURRENT DAY - CHECK ID COUNT
            if ([[lec courseID] isGreaterThan:top]) {
                top = [lec courseID];
            }
        }
        //FINDS TOP VERSION OF EACH COURSE FOR THE DAY
        NSInteger COURSESNUM = [top integerValue];
        for (NSInteger CURRENTCOURSE=1; CURRENTCOURSE<=COURSESNUM; CURRENTCOURSE++){
            // CHECKS DIFFERENT COURSES
            NSString* versionTop = @"0";
            Lecture* lecture = [Lecture alloc];
            for (Lecture* lec in [lectures objectForKey:weekDay]){  // EACH LECTURE IN CURRENT DAY
                if([[lec courseID]isEqualTo:[NSString stringWithFormat:@"%d", CURRENTCOURSE]]
                   &&[[lec version]isGreaterThan:versionTop]) { // IS SPECIFIC COURSE AND VERSION IS HIGHER THAN PREVIOUS
                    versionTop = [lec version];
                    lecture = [lecture initCourseWithName:[lec course] 
                                                    grade:[lec grade] 
                                                  teacher:[lec teacher] 
                                                     room:[lec room] 
                                                 courseID:[lec courseID] 
                                                  version:[lec version] 
                                                startTime:[lec startTime] 
                                                 stopTime:[lec stopTime] 
                                               lunchStart:[lec lunchStart] 
                                                lunchStop:[lec lunchStop] 
                                                     year:[lec year] 
                                               daysOfWeek:[lec daysOfWeek] 
                                                    weeks:[lec weeks] 
                                                couchDBId:[lec couchDBId] 
                                               couchDBRev:[lec couchDBRev]];
                }
            }
            if([lecture courseID]) {
                [[lecturesDays objectForKey:weekDay] addObject:lecture];
            }
            
        }
        
    }
    return lecturesDays;
}

/*********************************************************************
 METHOD : GET ALL LECTURE OBJECTS SORTED NEWEST VERSION IN MONDAY - FRIDAY
 ACCEPTS: NSArray with Lecture objects
 RETURNS: NSDictionary with Lecture objects sorted only newest version in KEYS MONDAY - FRIDAY
 *********************************************************************/
-(NSDictionary*)getLecturesPerDaysRefined:(NSArray*)lectures {
    NSDictionary* tempSort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              [NSMutableArray array], @"MONDAY",
                              [NSMutableArray array], @"TUESDAY",
                              [NSMutableArray array], @"WEDNESDAY",
                              [NSMutableArray array], @"THURSDAY",
                              [NSMutableArray array], @"FRIDAY",nil];
    NSDictionary* lecturesDays = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSMutableArray array], @"MONDAY",
                                  [NSMutableArray array], @"TUESDAY",
                                  [NSMutableArray array], @"WEDNESDAY",
                                  [NSMutableArray array], @"THURSDAY",
                                  [NSMutableArray array], @"FRIDAY",nil];
    for(NSArray* day in tempSort) {
        //NSLog(@"DICTIONARY DAY %@", day);
        for(Lecture* lecture in lectures) {
            for(NSString* weekDay in [lecture daysOfWeek]) {
                if(![weekDay caseInsensitiveCompare:[NSString stringWithFormat:@"%@", day]]) {
                    //NSLog(@"WEEKDAY %@", weekDay);
                    [[tempSort objectForKey:day] addObject:lecture];
                }
            }
        }
    }
    
    for (NSString* weekDay in tempSort){            // EACH WEEKDAY
        //NSLog(@"%@", weekDay);
        // CHECKS NUMBER OF DIFFERENT COURSES FOR EACH DAY
        NSString* top = @"0";
        for (Lecture* lec in [tempSort objectForKey:weekDay]){ // EACH LECTURE IN CURRENT DAY - CHECK ID COUNT
            if ([[lec courseID] isGreaterThan:top]) {
                top = [lec courseID];
            }
        }
        //FINDS TOP VERSION OF EACH COURSE FOR THE DAY
        NSInteger COURSESNUM = [top integerValue];
        for (NSInteger CURRENTCOURSE=1; CURRENTCOURSE<=COURSESNUM; CURRENTCOURSE++){
            // CHECKS DIFFERENT COURSES
            NSString* versionTop = @"0";
            Lecture* lecture = [Lecture alloc];
            for (Lecture* lec in [tempSort objectForKey:weekDay]){  // EACH LECTURE IN CURRENT DAY
                if([[lec courseID]isEqualTo:[NSString stringWithFormat:@"%d", CURRENTCOURSE]]
                   &&[[lec version]isGreaterThan:versionTop]) { // IS SPECIFIC COURSE AND VERSION IS HIGHER THAN PREVIOUS
                    versionTop = [lec version];
                    lecture = [lecture initCourseWithName:[lec course] 
                                                    grade:[lec grade] 
                                                  teacher:[lec teacher] 
                                                     room:[lec room] 
                                                 courseID:[lec courseID] 
                                                  version:[lec version] 
                                                startTime:[lec startTime] 
                                                 stopTime:[lec stopTime] 
                                               lunchStart:[lec lunchStart] 
                                                lunchStop:[lec lunchStop] 
                                                     year:[lec year] 
                                               daysOfWeek:[lec daysOfWeek] 
                                                    weeks:[lec weeks] 
                                                couchDBId:[lec couchDBId] 
                                               couchDBRev:[lec couchDBRev]];
                }
            }
            if([lecture courseID]) {
                [[lecturesDays objectForKey:weekDay] addObject:lecture];
            }
            
        }
        
    }
    return lecturesDays;
}

/*********************************************************************
 METHOD : GET LECTURE OBJECTS FROM USER-DATA AND CALCULATED CURRENT DAY
 ACCEPTS: Student/Admin object and NSDictionary with Lecture objects sorted in KEYS MONDAY - FRIDAY 
 RETURNS: NSSet with Lecture objects
 *********************************************************************/
-(NSSet*)getLecturesOfDay:(NSDictionary*) lectures {
    NSDate *date = [NSDate date];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEEE"];
    
    NSSet* lecturesOfDay = [lectures objectForKey:[[weekDay stringFromDate:date] uppercaseString]];
    
    return lecturesOfDay;
}

/*********************************************************************
 METHOD : GET ALL USER'S NOTE OBJECTS FROM USER-DATA AND CURRENT WEEK
 ACCEPTS: Student/Admin object, NSArray of Note objects, NSUInteger of current week    
 RETURNS: NSArray with Note objects 
 *********************************************************************/
-(NSArray*)getNotesOfWeek:(User*)user 
                    notes:(NSArray *)notes 
              currentWeek:(NSUInteger)currentWeek {
    
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
 METHOD : GET NOTE OBJECTS FROM USER-DATA AND CALCULATED CURRENT DAY
 ACCEPTS: Student/Admin object and NSDictionary with Note objects sorted in KEYS MONDAY - FRIDAY 
 RETURNS: NSSet with Note objects
 *********************************************************************/
-(NSSet*)getNotesOfDay:(NSDictionary*) notes {
    NSDate *date = [NSDate date];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEEE"];
    
    NSSet* notesOfDay = [notes objectForKey:[[weekDay stringFromDate:date] uppercaseString]];
    
    return notesOfDay;
}

/*********************************************************************
 METHOD : GET ALL MESSAGE OBJECTS FROM USER-DATA
 ACCEPTS: NSDictionary with at least NSSet of Message objects
 RETURNS: NSArray with Message objects for User
 *********************************************************************/
-(NSArray*)getUserMessages:(User*)user notifications:(NSDictionary *)notifications {
    NSMutableArray* inbox = [NSMutableArray array];
    for(Message* message in [notifications objectForKey:@"MESSAGE"]) {
        for(NSString* email in [message receiver]) {
            if([[user mailAddress]isEqualTo:email]) {
                [inbox addObject:message];
            }
        }
    }
    return inbox;
}

/*********************************************************************
 METHOD : CREATE SCHEDULE TEMPLATE OBJECT - SUPPLY WITH JSON
 ACCEPTS: NSString PATH to JSON DATA
 RETURNS: NONE
 *********************************************************************/
-(void)createSchedule:(NSArray *)lectures jsonPath:(NSString *)jsonPath {
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data 
                                                                options:NSJSONReadingMutableContainers 
                                                                  error:NULL];
    // ID STAMP
    NSString* numID = @"0";
    int idInt = [numID intValue];
    idInt +=1;
    numID = [NSString stringWithFormat:@"%d", idInt];
    NSLog(@"COURSEID %@", numID);
    [dict setObject:numID forKey:@"courseID"];
    [dict setObject:@"1" forKey:@"version"];
    NSLog(@"%@", dict);
    [DBService lectureToDataBase:dict];
    
}

/*********************************************************************
 METHOD : CREATE NOTE OBJECT - SUPPLY WITH JSON
 ACCEPTS: NSString PATH to JSON DATA
 RETURNS: NONE
 *********************************************************************/
-(void)createNote:(NSString *)jsonPath {
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data 
                                                                options:NSJSONReadingMutableContainers 
                                                                  error:NULL];
    [dict setObject:@"note" forKey:@"type"];
    [DBService notificationToDataBase:dict];
}

/*********************************************************************
 METHOD : CREATE MESSAGE OBJECT - SUPPLY WITH JSON
 ACCEPTS: NSString PATH to JSON DATA
 RETURNS: NONE
 *********************************************************************/
-(void)createMessage:(NSString *)jsonPath {
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data 
                                                                options:NSJSONReadingMutableContainers 
                                                                  error:NULL];
    [dict setObject:@"message" forKey:@"type"];
    [DBService lectureToDataBase:dict];
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
-(void)updateLectureEvent:(NSString *)courseID 
                  version:(NSString*)version 
                 lectures:(NSArray *)lectures
                 jsonPath:(NSString*)jsonPath {
    
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
-(void)updateLectureTemplate:(Lecture*)lecture {
    // check if class is Lecture object
}

/*********************************************************************
 METHOD : UPDATE LECTURE OBJECT - CREATE MODIFIED INSTANCE OR EDIT INSTANCE - SUPPLY WITH OBJECT
 ACCEPTS: Lecture object
 RETURNS: NONE
 *********************************************************************/
-(void)updateLectureEvent:(Lecture*)lecture {
    // check if class is Lecture object
}

/*********************************************************************
 METHOD : PRINT ALL LECTURE OBJECTS WITH RELATED NOTE OBJECTS OF CURRENT WEEK
 ACCEPTS: NSDictionary with sorted Lecture objects, NSDictionary with sorted Note objects
 RETURNS: NONE
 *********************************************************************/
-(void)printCurrentWeek:(NSDictionary *)lectures notes:(NSDictionary *)notes {
    NSLog(@"MONDAY");
    for(Lecture* lecture in [lectures objectForKey:@"MONDAY"]) {
        NSLog(@"-LECTURE: %@ v%@", [lecture course], [lecture version]);
        for(Note* note in [notes objectForKey:@"MONDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"--NOTE: %@", [note text]);
            }
        }
    }
    NSLog(@"TUESDAY");
    for(Lecture* lecture in [lectures objectForKey:@"TUESDAY"]) {
        NSLog(@"-LECTURE: %@ v%@", [lecture course], [lecture version]);
        for(Note* note in [notes objectForKey:@"TUESDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"--NOTE: %@", [note text]);
            }
        }
    }
    NSLog(@"WEDNESDAY");
    for(Lecture* lecture in [lectures objectForKey:@"WEDNESDAY"]) {
        NSLog(@"-LECTURE: %@ v%@", [lecture course], [lecture version]);
        for(Note* note in [notes objectForKey:@"WEDNESDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"--NOTE: %@", [note text]);
            }
        }
    }
    NSLog(@"THURSDAY");
    for(Lecture* lecture in [lectures objectForKey:@"THURSDAY"]) {
        NSLog(@"-LECTURE: %@ v%@", [lecture course], [lecture version]);
        for(Note* note in [notes objectForKey:@"THURSDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"--NOTE: %@", [note text]);
            }
        }
    }
    NSLog(@"FRIDAY");
    for(Lecture* lecture in [lectures objectForKey:@"FRIDAY"]) {
        NSLog(@"-LECTURE: %@ v%@", [lecture course], [lecture version]);
        for(Note* note in [notes objectForKey:@"FRIDAY"]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"--NOTE: %@", [note text]);
            }
        }
    }
}


/*********************************************************************
 METHOD : PRINT ALL LECTURE OBJECTS WITH RELATED NOTE OBJECTS OF CURRENT DAY
 ACCEPTS: NSDictionary with sorted Lecture objects, NSDictionary with sorted Note objects
 RETURNS: NONE
 *********************************************************************/
-(void)printCurrentDay:(NSDictionary *)lectures notes:(NSDictionary *)notes {
    NSDate *date = [NSDate date];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEEE"];
    
    NSLog(@"%@", [[weekDay stringFromDate:date] uppercaseString]);
    for(Lecture* lecture in [lectures objectForKey:[[weekDay stringFromDate:date] uppercaseString]]) {
        NSLog(@"-LECTURE: %@ v%@", [lecture course], [lecture version]);
        for(Note* note in [notes objectForKey:[[weekDay stringFromDate:date] uppercaseString]]) {
            if([[lecture courseID]isEqualTo:[note courseID]]) {
                NSLog(@"--NOTE: %@", [note text]);
            }
        }
    }
}



@end
