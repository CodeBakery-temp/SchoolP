#import "Menu.h"
#import "ScheduleService.h"
#import "Lecture.h"
#import "User.h"
#import "Note.h"
#import "DBService.h"
#import "LoginService.h"

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
    NSSet* lecturesToday = [schedule getLecturesOfDay:user];
    
    // GET NOTES
    NSArray* notes = [[db getNotifications]objectForKey:@"NOTES"];
    NSArray* allYourNotes = [schedule getNotesOfWeek:user notes:notes currentWeek:[components week]];
    NSDictionary* notesSorted = [schedule getNotesPerDays:allYourNotes];
    //[schedule printLecturesWithNotes:lecturesSorted notes:notesSorted];

    // GET TODAY'S, THIS WEEK'S SCHEDULE & READ NOTES
    NSLog (@"\n 1 = Today \n 2 = Week \n 3 = Messages \n 0 = Exit");
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
                    [schedule printLecturesWithNotes:lecturesSorted notes:notesSorted];
                    
                    break;
                case 3:
                    //NSLog (@"Reminder Notes: %@", [notesSorted description]);
                    
                    break;
                default:
                    while (value != 0);
                    NSLog(@"Good bye!");
                    break;
            }
    }while (value != 0);
}

@end