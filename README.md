# A simple GitHub Direct Messaging app.

# Scenario

An iOS team with 5 members. Long term project, with both development and maintenance being handled within the team. Design the app and as the tech lead, implement the main fundamental functionalities.

# How to run the app

Open `Messenger/Messenger.xcodeproj`, and `Run (Cmd + R)`.

<p align="center">
  <img width="414" height="896" src="GithubDemo.gif"/>
</p>
 

# Technical notes

- [x] Show a list of users retrieved from GitHub.
- [x] Handle rate limit case.
- [x] Pull to refresh list users.
- [x] Paging loading.
- [x] Support landscape and portrait.
- [x] Images caching.
- [x] Direct messaging screen functionalities.
- [x] UI improved.
- [x] Storing messages for each user.
- [x] Following VIPER architechture.
- [x] UnitTests.
- [x] Swiftlint for coding styles & clean code.
- [x] Support `fastlane`. Run `fastlane scan` in Xcode project directory.
- [x] Prepared to support multi environments (dev and prod).

# Project structures
```
Messenger
├── Resources
├── Models
├── Modules
├── Core
│  └── Image
│  └── Persistence
│  └── Helper
|  └── Extensions
|  └── Networking
│  └── BaseVIPER
|     └── Presenter
|     └── Router
|     └── View

MessengerTests
```

### VIPER
[VIPER](https://medium.com/@smalam119/viper-design-pattern-for-ios-application-development-7a9703902af6) is a very clean architecture. It isolates each module from others. So changing or fixing bugs are very easy as you only have to update a specific module. Also for having modular approach VIPER creates a very good environment for unit testing.
###### Other Key Advantages of VIPER Architecture:
- Good for large teams.
- Makes it scalable. Enable developers to simultaneously work on it as seamlessly as possible.
- Makes it easy to add new features.
- Makes it easy to write automated tests since your UI logic is separated from the business logic.
- Makes it easier to track issues via crash reports due to the Single Responsibility Principle.
- Makes the source code cleaner, more compact, and reusable.
- Reduces the number of conflicts within the development team.
- Applies SOLID principles.
- Reduces the number of merge conflicts.

#### VIPER Template
I created a VIPER Xcode template to make the work easier, reduce time for create new files and repeate the same code per module.

[Installation Instruction](https://github.com/m-rec/524ad38f766143bd5e1f804e231ba7a3b8877ce6/tree/master/XCode%20Templates)

To create new module: `Create new Group as your module name ---> Add new File --> Scroll down to select VIPER template --> type your module name.`

### BaseNetworking
A very lightweight URLSession wrapper to work with REST APIs. Easy to use and flexible with diffirent endpoints, methods.

```swift
networkClient.fetch(endPoint: ListUsersEndpoint.fetchListUser(lastId: lastId), type: [User].self) { (result) in
            switch result {
            case .success(let users):
                print("Fetched list users: \(users)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
```

### TestCases

Add test cases for each modules or base components to make sure we won't break it after changes. Can run `fastlane scan` 
[x] PersistenceTests.
[x] ImagesCacheTests.
[x] ListUsersTests.
[x] DirectMessagesTests.
[x] Support Mockable test or load data from local JSON.

# Things to improve
1. Intergrate CI/CD with this repo, to double check every commit/PR pass the test cases.
2. Separate Chat sessions by date. And store it with CoreData/Realm, not UserDefault like current approach.
3. Add UI tests.

