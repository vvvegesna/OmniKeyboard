To see the project's entire history, you can visit the repository at: https://bitbucket.org/omnikeyboard/omnikeyboard

Our app, the Omni Keyboard, is a unique and customizable keyboard designed for quick, precicion typing without relying on prediction. Several symbols are grouped together into one key, and when the user touches that key, all the keys change into those symbols. Dragging over them and lifting will type the symbol.

Cut, Copy and Clear commands have been added which always effect the all of the text, so it is not necessary to carefully selected all of the text with iOS's default selection method, however this is still possible if you with to select or edit portions of the text.

The keyboard supports custom layouts, which the user may create. An in-app "Help" page contains instructions for creating valid layouts. Once created, the layouts can be placed into the app's documents directory using iTunes*. They will then appear under "Keyboards".

Some alternate layouts have already been created, and are available from a sever. These can be found under "Download".


*GETTING CUSTOM FILES TO APPEAR IN THE SIMULATOR
------------------------------------------------
Our app is designed to detect and list XML files located in the app's documents directory. The simulator does have a documents directory for each app, however it is not a part of Xcode's project structure. Because of this, to verify this feature, you'll need to put any files into the correct location yourself. Unfortunately, the location differs from system to system. 

To locate the correct directory to play xml files, run the app from Xcode. A debug message will print the documents directory the simulator is using. To easily navigate to this folder, you can copy the text, open Finder, and while the Finder window has focus, press "Command + Shift + G" to open the go-to dialog. Paste the URL you copied and press "Go" to be taken directly to the correct folder. You can place any XML files here. Note that the app will not list files without an XML extension.

One layout has been included for you, named "ABC.xml". It is in the same folder as this readme file.
