import String
import Debug
fail : Int
fail = 32

names : List String
names =
    ["python","java","haskell"]

type Visibility = All | Active | Completed


toString : Visibility -> String
toString v =
    case v of
        All -> "hello"
        Active -> "Active"
        Completed -> "completed"

type User = Anonymous | LoggedIn String

userPhoto : User -> String
userPhoto user =
    case user of
        Anonymous -> "a"
        LoggedIn name ->
            "users/" ++ name ++ "photo.png"

activeUsers : List User
activeUsers = [Anonymous, LoggedIn "quan", Anonymous]

Debug.crash "TODO"