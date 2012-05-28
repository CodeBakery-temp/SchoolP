#import "Menu.h"
#import "ScheduleService.h"
#import "Lecture.h"
#import "User.h"
#import "Note.h"
#import "DBService.h"
#import "LoginService.h"
#import "Message.h"

@implementation Menu

@synthesize menu = _menu;

-(id)initMenu : (int) menu
{
    return [self initMenu:0];
}

+(void) menu
{
    int value = 0;
    //////TO GET ONE USER FROM LOGIN START//////
    DBService* db = [DBService database];
    ScheduleService* schedule = [ScheduleService schedule];
    
    // DATE
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSWeekCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    
    // LOGIN
    NSMutableDictionary* usersInADic = [NSMutableDictionary dictionaryWithDictionary:[db getUsers]];
    
    LoginService* userLogin = [LoginService withUserDictionary:usersInADic];
    User* user = [userLogin checkLogin:usersInADic];
    NSLog(@"User logged in: \n %@", user);
    NSArray* lectures = [db getLectures];
    NSArray* allYourLectures = [schedule getLecturesOfWeek:user lectures:lectures currentWeek:[components week]];
    NSDictionary* lecturesSorted = [schedule getLecturesPerDays:allYourLectures];
    NSSet* lecturesToday = [schedule getLecturesOfDay:lecturesSorted];
    
    NSDictionary* notifications = [db getNotifications];
    // GET NOTES
    NSArray* notes = [notifications objectForKey:@"NOTES"];
    NSArray* allYourNotes = [schedule getNotesOfWeek:user notes:notes currentWeek:[components week]];
    NSDictionary* notesSorted = [schedule getNotesPerDays:allYourNotes];
    //[schedule printLecturesWithNotes:lecturesSorted notes:notesSorted];
    NSArray* message = [notifications objectForKey:@"MESSAGES"];
    NSLog(@"%lu", [message count]);
    
    
    if ([[user admin] isEqualTo:@"1"]) {
        
        // GET TODAY'S, THIS WEEK'S SCHEDULE & READ MESSAGES
        
        /////// Denna kod här nedanför är menyn för ADMIN
        
        NSLog (@"\n\n 1 = Create Schedule \n 2 = Send Message \n 3 = Send Message to all \n 4 = Edit Schedule \n 5 = Today \n 6 = Week \n 0 = Exit\n\n\n");
        
        NSLog(@"Pick a number between 1 and 7:");
        do {
            scanf ("%i", &value);
            switch (value)
            {
                case 1:
                    [DBService postToDatabase:[DBService lecturesDB] sourcePath:@"/Users/DQF/Desktop/schema.json"];
                    
                    break;
                case 2:
                    //Create Message
                    [schedule createMessage:@"/Users/Evhuul/Desktop/message.json"];
                    
                    break;
                case 3:
                    //Create Message to to all
                    [schedule createMessage:@"/Users/Evhuul/Desktop/messageall.json"];
                    
                    break;
                case 4:
                    [[ScheduleService alloc] updateLectureTemplate:@"3" //id på kursen 1 JavaScript, 2 Objective-C, 3 InDesign
                                                          lectures:lectures 
                                                          jsonPath:@"/Users/DQF/Desktop/schema.json"];
                
                    break;
                case 5:
                    for (Lecture* lec in lecturesToday) {
                        [lec printLecture];
                    }
                    break;
                case 6:
                    //NSLog (@"\nlectures this week:\n%@", [lecturesSorted description]);
                    [schedule printCurrentWeek:lecturesSorted notes:notesSorted];
                    
                    break;
                default:
                    while (value != 0);
                    NSLog(@"Good bye!");
                    break;
            }
        }while (value != 0); 
        /////// Denna kod här nedanför är menyn för STUDENT
    } else {NSLog (@"\n\n 1 = Today \n 2 = Week \n 3 = Messages \n 0 = Exit\n\n\n");
        NSLog(@"Pick a number between 1 and 3:");
        do {
            scanf ("%i", &value);
            switch (value)
            {
                case 1:
                    for (Lecture* lec in lecturesToday) {
                        [lec printLecture];
                    }
                    break;
                case 2:
                    //NSLog (@"\nlectures this week:\n%@", [lecturesSorted description]);
                    [schedule printCurrentWeek:lecturesSorted notes:notesSorted];
                    
                    break;
                case 3:
                    //NSLog (@"Reminder Notes: %@", [notesSorted description]);
                    [schedule getUserMessages:user messages:message];
                    
                    break;
                default:
                    while (value != 0);
                    NSLog(@"Good bye!");
                    break;
            }
        }while (value != 0);
    }
}

@end