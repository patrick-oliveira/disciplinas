-- One way to define a product type
data User' = MkUser' Bool String (Int -> IO Int)
-- Another way to define a product type
data User = MkUser
    { 
        _isAdmin :: Bool,
        _userName :: String,
        _openDoor :: Int -> IO Int
    }

openSecretDoor :: User -> IO Int
openSecretDoor user
    | _isAdmin user = getSecretPIN
    | otherwise = pure 0
        where
            getSecretPIN :: IO Int
            getSecretPIN = pure 1

-- What is the problem with the above function?
-- The secretPIN could be incorrectly return without checking if the user is an admin,
-- if the developer forgets to check the user's role.
-- Another problem is that a user type can be created by anyone, so the developer could just create a user with the isAdmin field set to True.
-- The second problem can be solved by limmiting what can be imported from the library. We do this in the following manner:
-- module Users
--     ( createNewUser
--     , getYourUser
--     , openSecretDoor
--     , openDoor
--     ) where
-- So the problem here is: How can we force a condition over the execution of a function?

-- getYourUser :: String -> String -> IO User
-- getYourUser username password = do
--     db <- openDB
--     user <- queryDB db username password
--     closeDB db
--     return user

-- createNewUser :: User -> Bool -> String -> (Int -> IO Int) -> IO ()
-- createNewUser user isAdm username opendoors
--     | _isAdmin user = openDB >>= createUser isAdm username opendoors >>= closeDB
--     | otherwise = print "You are not allowed to create a new user"

data Door a = Open | Closed | Breached a
    deriving Eq

instance Functor Door where
    fmap :: (a -> b) -> Door a -> Door b
    fmap f (Breached a) = Breached (f a)
    fmap _ Open = Open
    fmap _ Closed = Closed

data Breach = Hacked | Broken | NoEnergy
    deriving Eq

doorStatus :: Int -> Door Breach
doorStatus door
    | door == 0 = Open
    | otherwise = Closed

openDoor :: User -> Int -> IO (Maybe Int)
openDoor user door =
    case doorStatus door of
        Open -> print "You don't need a code." >> pure Nothing
        Closed -> Just <$> _openDoor user door
        Breached breach -> print "The door is breached." >> pure Nothing

fromBreachToStr :: Door Breach -> Door String
fromBreachToStr = fmap b2s
    where
        b2s Hacked = "You have been hacked."
        b2s Broken = "The door has been forced and broken!"
        b2s NoEnergy = "We lost energy, guard the door!"




