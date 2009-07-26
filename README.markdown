Overview
========
This example project demonstrates how to provide search interfaces to both the Flickr and the Yahoo Image Search web services. The search results can be viewed either in a table view (using TTTableViewController) or in the Three20 photo browsing system (TTThumbsViewController and TTPhotoViewController). This project also demonstrates how to process both JSON and XML HTTP responses.

As Joe Hewitt noted on the message board, the motivation behind the separation between the TTModel and TTTableViewDataSource is to allow complex apps to separate their data model from the way that the data will be displayed (e.g. in a UITableView). This demo app is not inherently complex, but I decided to treat it as a "complex" app and go for the total separation that TTModel was designed for. 

The advantage of this modular approach is that it is relatively easy to do the following:
- create new ways to visualize the search results besides a table view or the thumbs view (e.g. MapKit, or maybe a calendar?)
- add more search providers (Google Images, Bing Images?)
- add support for new/alternative backend data interchange formats (YAML, etc.)

The downside to this approach is that it is overkill if all you are trying to do is a simple tableview. I hope that other members of the Three20 community will contribute their own examples or tutorials. My intent with this project is to provide an example of how you would use TTModel in a real application.

Getting Started
===============
1. git clone git://github.com/klazuka/TTRemoteExamples.git
2. cd TTRemoteExamples
3. git submodule update --init
4. open TTRemoteExamples.xcodeproj
5. Build and Go!

What's Included
===============
I tried to make things as simple as possible by bundling both json-framework and KissXML with this demo app. I also configured the project such that it uses Joe's three20 repository as a git submodule within the project directory. This way there will be fewer version compatibility problems as three20 HEAD advances (especially since Joe likes to do heavy refactoring on the master branch :-)

Enjoy,
-keith