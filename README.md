# ios-base 

A bolierplate ios application written in Swift. 

### What's Included?
-  Account management
-  Simple admin controls
-  Post creation 
-  Commenting
-  News feed
-  User profiles 
    
### Demos

### Setting Up 


##### Update Xcode

Make sure you are updated to Xcode 8 or above, which comes with Swift 3.0 or above. If you do not have this updated version of Xcode, you can install it on the App Store. If you are not running osX Sierra, you may have to upgrade your operating system before the App Store will allow you to upgrade Xcode. 

##### Clone the repo

```
$ git clone https://github.com/hack4impact/ios-base.git
$ cd ios-base
```

### Set up Parse on Heroku 

Install the Heroku Command Line Interface: 
```
$  brew install heroku
```

Set up the Parse server using this tutorial https://medium.com/@timothy_whiting/setting-up-your-own-parse-server-568ee921333a. This should be done once at the beginning of the project by the PM or TL. Once this is done, do not commit the parse-server-example code to your repository. Also, you may use the Hack4Impact Heroku account for the Heroku deployment. You may also use the Hack4Impact Mlab account. 

To hookup your new parse server to the Swift application, change lines 16-19 in ios-base/ios-base/AppDelegate.swift/. This is the part of the tutorial that tells you  "Your initialization block in your client code should now look something like this (this is Swift in my example)."" 

Once this is done, test that your Parse server is successfully running. 


##### Install CocoaPods
```
$ sudo gem install cocoapods
$ pod install 
```


### To do
 - Implement more modular layers for developers 

### License

MIT
