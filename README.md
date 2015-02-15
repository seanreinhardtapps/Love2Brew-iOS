# Love2Brew-iOS
Love 2 Brew Application - iOS Version

***********************************  Overview  ***********************************

App loads JSON data and png images from a remote web service API

The front view controller loads a table view with Coffee Brewers using custom table Cells

Once a brewer is selected, a set of tabbed view controllers are launched

The view controllers are embedded in a navigation bar to allow navigation back to the front page

The Nav Bar has a button to open a dialog modal view to "Set a Reminder"

The reminder modal view allows 12 hour, 24 hour, 5 minute, and 90 second reminders

The reminder is loaded to the local notification service that displays a notification
that "Coffee is Ready"

Downloaded data is stored into Core Data

***********************************  Features  ***********************************

The following features of iOS were exercised in the app:

    - Interface Builder
    - Table View Controllers
    - Nav Bar Controller
    - Tabbed View Controller
    - Custom table cells
    - Segues launched by code from Table Row Selecton
    - HTTP URL Connections to download JSON Arrays
    - De-serializing JSON String
    - MVC - Definition of Model Class for Data / Controllers / Custom Table cell View Class
    - Asynchronous task for image download using central dispatch
    - NSURL Connections for image downloads
    - CoreData Entities
    - Show(Push) and Modal Segues
    - Local Notifications
    - Programmatic display of images
