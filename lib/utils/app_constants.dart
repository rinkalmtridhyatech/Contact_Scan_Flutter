class AppConstants {
  //App related
  static const String appName = 'Contact Scan';
  static const int appVersion = 1;

  //API related
  static String baseApi = '';
  static const String baseApiEndPoint = '/api/v2';
  static const String authApiEndPoint = '/api/v2/public';
  static const String authenticate = '/authenticate';
  static const String getEvents =
      'https://www.eventsquid.com/api/v2/public/getHosts?app=cs ';
  static const String searchAPI = '/attendeeSearch/';

  //API results
  static const String failed = 'Failed';
  static const String checkInFail = 'Check-In Failed';
  static const String attendeeAlreadyCheckedIn = 'Attendee already checked in.';
  static const String registrationItemNotFound = 'Registration item not found.';
  static const String attendeeAlreadyCheckedOut =
      'Attendee is already checked out for this event.';
  static const String attendeeAlreadyCheckedInItem =
      'Attendee is already checked in for this registration item.';
  static const String attendeeAlreadyCheckedOutItem =
      'Attendee is already checked out for this registration item.';
  static const String notCheckedIn =
      'Attendee must be checked in for this registration item before being checked out.';

  /*
Shared Pref
  */
  static const String apiKey = 'apiKey';
  static const String baseUrl = 'baseUrl';
  static const String showInstruction = 'showInstruction';
  static const String eventAuthData = 'eventAuthData';
  static const String eventIdNumber = 'eventConfNumber';
  static const String eventName = 'eventName';
  static const String eventDataFetched = 'eventDataFetched';
  static const String eventAuthPassword = 'eventAuthPassword';
  static const String dropdownValue = 'dropdownValue';
  static const String scopeName = 'scopeName';
  static const String selectedIndex = 'selectedIndex';
  static const String isEventCheck = 'isEventCheck';
  static const String isAttendeeCheck = 'isAttendeeCheck';
  static const String itemCategory = 'itemCategory';
  static const String eventFeeID = 'eventFeeID';
  static const String disableDecrementing = 'disableDecrementing';
  static const String currentTime = 'currentTime';

  /*
  UI related
  */
  //dashboard
  static const String alsoWorksWith = 'also works with';

  //event selection
  static const String selectEventHost = 'Select event host site';
  static const String eventIdentification = 'Event identification';
  static const String accessScanner = 'Access Scanner';
  static const String eventIdHint = 'Event ID';
  static const String eventCodeHint = 'Authorization Code';
  static const String eventIdDesc =
      'Please enter the eventID and authorization code provided by the event host.';
  static const String authorize = 'AUTHORIZE';
  static const String changeEvent = 'change event';
  static const String changeEventCaps = 'CHANGE EVENT';
  static const String cancel = 'cancel';
  static const String areYouSure = 'ARE YOU SURE?';
  static const String eventChangeConfirmation =
      'By changing the event, you will no longer be able to scan people attending the current event.';
  static const String eventChangeRefresh =
      'If you need to refresh the current event’s data, use the'
      ' refresh function in the main menu.';

  //Stats
  static const String scanAttendeesBadge =
      'Scan attendee’s badge or phone QR code';
  static const String connectWIFIMsg =
      'Make sure you are connected to wifi or a cellular signal before attempting to send an email of your list.';
  static const String wrongQRMsg =
      'Either the attendee’s QR code is not associated with this event or you are not connected to the internet via wifi or cellular.';
  static const String notActivatedContactScan =
      'The event host has not activated contact scanning.';
  static const String conference =
      '2021 Conference on Contact Scanning Procedures With Two Lines for The Title - Centered';

  //validation
  static const String validEmail = 'Please enter a valid email address';
  static const String noInternet = 'Please check your internet connection';
  static const String emptyValueEventId = 'Please enter eventID';
  static const String somethingWentWrong = 'Something went wrong';
  static const String userAuthFailed = 'Either the credentials you entered are incorrect or the event host has not activated contact scanning for this event.';
  static const String userPermissionFailed =
      'Please provide required permissions';
  static const String inValidQrCodeString =
      'Either the attendee’s QR code is not associated with this event or you are'
      ' not connected to the internet via wifi or cellular.';
  static const String noInternetForEmail =
      'Make sure you are connected to wifi or a cellular signal before attempting to send an email of your list.';
  static const String tryAgain = 'TRY AGAIN';
  static const String somethingIsUp = 'Something is up…';
  static const String authDenied = 'AUTHORIZATION DENIED';
  static const String hostNotActivated =
      'The event host has not activated contact scanning.';

  static const String searchValidation =
      'Kindly enter two or more characters for search';
  static const String invalidDetails = 'Invalid Details';
  static const String notActivated = 'Not Activated';
  static const String scanError = 'SCAN ERROR';
  static const String uhOh = 'UH OH…';
  static const String emptyValueAuthorizationCode =
      'Please enter authorization code';

  //Search
  static const String search = 'SEARCH';
  static const String guests = ' guests)';
  static const String go = 'Go';
  static const String searchHint = 'Search';
  static const String swipeLeft = 'Swipe left to remove the contact.';

  // check in stats
  static const String inn = 'in';
  static const String out = 'out';

  // session related strings
  static const String sessionExpired =
      'Your session has expired. Please re-authorize the app for your event.';
  static const String kindlyLoginAgain = 'Kindly login again.';
  static const String cancelExport =
      'Are you sure you want to cancel the export ?';
  static const String ok = 'Ok';
  static const String yes = 'Yes';
  static const String no = 'No';

  // session time
  static const int timeDifference = 1;

// contact list
  static const String exportList = 'Export List';
  static const String emailList = 'EMAIL LIST';
  static const String emailAddress = 'Email Address';
  static const String sendCsv = 'Send a CSV file to:';
  static const String cancelEmail = 'DONE';
  static const String sendEmail = 'EMAIL';
  static const String contacts = 'Contact';
  static const String notes = 'Notes';
  static const String save = 'DONE';
  static const String notesSaved = 'Notes saved successfully';
  static const String emailAddressEmpty = 'Please enter an email address';
  static const String contactOptions =
      'Contact this attendee using your native SMS, email and calling tools.';
}
