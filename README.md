# GetReactive
A simple iOS app using reactive programming

Oh Wordz?
=============

Set up of project:

1. Install XCode IDE - https://itunes.apple.com/us/app/xcode/id497799835?mt=12
2. Install "command line tools" if you don't have this already - http://stackoverflow.com/questions/18216865/how-to-install-command-line-tools-on-osx-mavericks

Set up CocoaPods
==============
1. Install cocoapods
```
$ sudo gem install cocoapods
```
2. Install pods after cloning the repository
```
$ pod install
```
Run through
==============
1. I started with creating the models such as a Player, a dictionary word that the player has to guess, Tile of character that the player will choose, along with game status and underlying rules
2. I then mapped out all the classes and view controllers that I'll need, keeping in mind the division of concerns
3. I used `URLSession` to get the words from the API provided and transformed them into dictionary word objects
4. After that, I decided to use string manupulation with NSString and NSRange to traverse and replace the occurances of the character if the player choose the correct character
5. If they choose an incorrect character, the remaining guess count will go down and I will keep tracking this until it hits 0. With each incorrect guess, I added animations for the tiles to drop
6. If the maximum guess is hit, then the game is over
7. If player chooses correct word that matches our secret word, they win and a little confetti animation will show up on screen

Video demo
=============
https://drive.google.com/file/d/1eMOCSX-W9rvJT6Y7MqfEbkt5ZB0k3kHR/view?usp=sharing

