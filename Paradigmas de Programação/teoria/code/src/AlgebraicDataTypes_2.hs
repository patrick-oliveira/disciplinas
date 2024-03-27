-- Building a more secure User type
-- By using Sum type, the admin user will have its own constructor, making it
-- impossible to build an admin type without access to the constructor,
-- which is only available inside the module.

-- module Paradigmas de Programação.AlgebraicDataTypes_2
--     ( createNewUser
--     , getYourUser
--     , openSecretDoor
--     , openDoor
--     ) where

data User =
    Admin { _openDoor :: Int -> IO Int }
    | User {
        _userName :: String,
        _openDoor :: Int -> IO Int
    }

-- getYourUser :: String -> String -> IO User
-- getYourUser username password = do
--     db <- openDB
--     user <- queryDB db username password
--     closeDB db
--     return user 

-- createNewUser :: User -> Bool -> String -> (Int -> IO Int) -> IO ()
-- createNewUser (Admin _) isAdm username opendoors =
--     openDB >>= createUser isAdm username opendoors >>= closeDB
-- createNewUser _ _ _ _ = print "You are not allowed to create a new user"

openSecretDoor :: User -> IO (Maybe Int)
openSecretDoor (Admin _) = pure $ Just 1234
openSecretDoor _ = print "DENIED!" >> pure Nothing

-- openDoor :: User -> Int -> IO Int
-- openDoor = _openDoor