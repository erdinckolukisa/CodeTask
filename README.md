# Mobiquity Code Task
## Erdinc Kolukisa
### erdinckolukisa@gmail.com

## XCode 13.3  is used for development
## Tested using iPhone 13 Pro Max


## Description

The application consists of 1 view with a collection view which displays the search result into two column. In this view we have a search bar to help our users to search for a keyword in Flickr to display relevant photos with this keyword. User can display previous search items in a table view in this screen as well. 

The search functionality works as the user inputs the string, however it is set up so that it searches only when the user stops inputting for a certain amount of time (1 seconds) . The purpose of this behaviour is to prevent unnecessary API calls.

Userdefaults is used for saving searched items. SearchProvider class deals with all saved items process like finding a saved item, save a new item etc. 

For networking Networking protocol is created and both WebApi and StubApi conforms to this protocol. WebApi uses URLSession for networking and StubApi uses locally saved json files in order to use it as a backup in some cases to see a dummy result. By default WebAPi is injected to viewmodels but StubApi could also be injected without any side effects. 

MVVM pattern was used and SOLID principles were used as much as I could. Some Unit Tests were created, but due the limited time the coverage was also limited. I would be glad to discuss this further in the interview.

## Third Party Libraries

Kingfisher is used for caching the images. It is easy to use and performs well in the project. 

Swinject is used to manage injection of dependencies.
