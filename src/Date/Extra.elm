module Date.Extra exposing(..)

import Date exposing(..)
import Time exposing(..)
import Time.Extra exposing(posixToParts)
import Debug exposing(toString)
import String exposing(..)

canada = customZone (-4*60) []

toFormattedString : String -> Date -> String
toFormattedString fstr date =
    let
        parts = posixToParts canada date
        h0 = parts.hour
        h = if h0 > 12 then String.fromInt(h0-12) else String.fromInt(h0)
        m = (fromInt(parts.minute))
        mm = if String.length(m) == 2 then m else "0"++m
        a = if h0 < 12 then " AM" else " PM"
        ee = toString(toWeekday canada date)
        mmm = toString(toMonth canada date)
        d = fromInt(parts.day)
        yyyy = parts.year
    in
        case fstr of
            "h:mm a"    -> h ++ ":" ++ mm ++ a
            "EE MM d"   -> ee ++ " "++ mmm ++ " " ++ d
            "EE M/d"    -> ee ++ " " ++ mmm ++ "/" ++ d
            "MMMM yyyy" -> mm ++ " " ++ String.fromInt(yyyy)
            otherwise   -> "err"

fractionalDay : Date -> Float
fractionalDay date =
    let
        parts = posixToParts canada date
        minspassed = (Basics.toFloat(parts.hour)*60.0) + Basics.toFloat(parts.minute) + (Basics.toFloat(parts.second)/60)
        totalmins = 24*60
    in
        minspassed/totalmins

