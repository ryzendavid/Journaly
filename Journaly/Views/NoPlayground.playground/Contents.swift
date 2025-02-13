import UIKit
import Foundation

var greeting = "Hello, playground"

func myFunction(){
    print("not first function again")
    secondFunc()
}

func secondFunc(){
    print("not second function, again")
}

myFunction()

var myvar = "hello world"
print(myvar)

func usersname() -> Int{
    let nameint = 4
    return nameint
}

func checkUnameint() -> String{
    return "true"
}

let uName = usersname()
print(uName)

// passing data from functions


func ShowfirstScreen() {
    let onboardingScreen = true
    let userLoggedIN = true
    let userStatus = ShowSecondScreen(onboardComplete: onboardingScreen, IsLoggedIn: userLoggedIN)
}


func ShowSecondScreen(onboardComplete: Bool, IsLoggedIn: Bool) -> Bool{
    if onboardComplete || IsLoggedIn == true {
        return true
    } else {
        return false
    }
}

if ShowSecondScreen(onboardComplete: true, IsLoggedIn: false) == true{
    showThirdScreen()
} else {
    onBoardincomplete()
}
    

func showThirdScreen(){
   
        print("User has logged in and completed onboarding")
    
}

    func onBoardincomplete(){
        print("onboarding is not complete")
    }

// guard

func movieName() {
    let movie1 = "Interstelelar"
    
    guard movie1 == "Interstellar" else {
        print("Not favorite movie")
        return
    }
    
    print("movie")
   
  
}
movieName()



// calculated variable (are functions)

func calNumbers() -> Int{
    let num1 = 5
    let num2 = 6
    
    return num1 + num2
}

calNumbers()
 

// unwarapping optionals using nil coalescing
let someBool : Bool? = nil
 
//let newBool : Bool  = someBool ?? false
print(someBool ?? true)

let loggedIn : Bool? = nil

func checkLogIN() -> Bool?{
    return loggedIn ?? false
}

//let isLogged = checkLogIN()
//print (checkLogIN()!)


// unwrapping using if statements

func checkLog() -> Bool{
    // if checkLogIn has a value, assign it to the new variable/ constant logchecked otherwise, run code in else statement
    if let logChecked = loggedIn{
        return logChecked
    } else{
       return false
    }
    
}

//rewriting

func checklog2() -> Bool{
    // if loggedIn contains a value, return it
    if let loggedIn{
        return loggedIn
    }
    return false
}


// using guard

func checklog3() -> Bool {
    //makes sure there is a value in logged in. if there isn't, return false (else) is executed. If there is, else statement is skipped and logchecked is returned
    guard let logchecked = loggedIn else{
        return false
    }
    return logchecked
}

// guard can also be written similarly to the second if statement.


//

let userNew: Bool? = true
let UserCompleteOnboard : Bool? = true
let userMovie: String? = "nieouwehl"

func getUSerStats(userNew:Bool, UserCompleteOnboard: Bool, userMovie: String)-> Bool{
    if userNew && UserCompleteOnboard{
        return true
    }
    return false
}

func checkuserSetup() -> Bool{
    if let usernew = userNew, let userC = UserCompleteOnboard, let UserM = userMovie {
        return getUSerStats(userNew: usernew, UserCompleteOnboard: userC, userMovie: UserM)
    }
return false
}

// easier if let syntax
func checkuserSetup2() -> Bool{
    if let userNew, let UserCompleteOnboard, let userMovie {
        return getUSerStats(userNew: userNew, UserCompleteOnboard: UserCompleteOnboard, userMovie: userMovie)
    }
return false
}
    
checkuserSetup()



//tuples ex

let name : String? = "name"
let LName : String? = nil
let signedUp = false


func getUser()-> (String?, String?, Bool){
    return (name, LName, signedUp)
}

getUser()
//print(test ?? "test returned nothing")

func te() -> String{
    let test : String? = nil
    return test!
}


