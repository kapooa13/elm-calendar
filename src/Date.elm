module Date exposing(..)

{-| Library for working with dates. Email the mailing list if you encounter
issues with internationalization or locale formatting.

-}

import Task exposing (..)
import Time exposing (..)
import Result exposing (Result)



-- DATES


{-| Updated representation of a date.
-}
type alias Date = Posix

canada = customZone (-4*60) []


{-| Get the `Date` at the moment when this task is run.
-}
now : Task x Date
now = Time.now


-- CONVERSIONS AND EXTRACTIONS


year : Date -> Int
year date = toYear canada date

month : Date -> Month
month date = toMonth canada date

day : Date -> Int
day date = toDay canada date

dayOfWeek : Date -> Weekday
dayOfWeek date = toWeekday canada date

