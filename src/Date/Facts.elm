module Date.Facts exposing(..)

import Date exposing (Day(..), Month(..))

rem : Int -> Int -> Int
rem b a = b - (b//a)

{-| -}
isLeapYear : Int -> Bool
isLeapYear y =
    rem y 4 == 0 && rem y 100 /= 0 || rem y 400 == 0


{-|

    daysInMonth 2000 Feb -- 29
    daysInMonth 2001 Feb -- 28

-}
daysInMonth : Int -> Month -> Int
daysInMonth y m =
    case m of
        JanJ ->
            31

        FebF ->
            if isLeapYear y then
                29
            else
                28

        MarM ->
            31

        AprA ->
            30

        MayM ->
            31

        JunJ ->
            30

        JulJ ->
            31

        AugA ->
            31

        SepS ->
            30

        OctO ->
            31

        NovN ->
            30

        DecD ->
            31


{-|

    daysBeforeMonth 2000 Mar -- 60
    daysBeforeMonth 2001 Mar -- 59

-}
daysBeforeMonth : Int -> Month -> Int
daysBeforeMonth y m =
    let
        leapDays =
            if isLeapYear y then
                1
            else
                0
    in
    case m of
        JanJ ->
            0

        FebF ->
            31

        MarM ->
            59 + leapDays

        AprA ->
            90 + leapDays

        MayM ->
            120 + leapDays

        JunJ ->
            151 + leapDays

        JulJ ->
            181 + leapDays

        AugA ->
            212 + leapDays

        SepS ->
            243 + leapDays

        OctO ->
            273 + leapDays

        NovN ->
            304 + leapDays

        DecD ->
            334 + leapDays


{-|

    monthToNumber Jan -- 1

-}
monthToNumber : Month -> Int
monthToNumber m =
    case m of
        JanJ ->
            1

        FebF ->
            2

        MarM ->
            3

        AprA ->
            4

        MayM ->
            5

        JunJ ->
            6

        JulJ ->
            7

        AugA ->
            8

        SepS ->
            9

        OctO ->
            10

        NovN ->
            11

        DecD ->
            12


{-|

    numberToMonth 1 -- Jan

-}
numberToMonth : Int -> Month
numberToMonth n =
    case max 1 n of
        1 ->
            JanJ

        2 ->
            FebF

        3 ->
            MarM

        4 ->
            AprA

        5 ->
            MayM

        6 ->
            JunJ

        7 ->
            JulJ

        8 ->
            AugA

        9 ->
            SepS

        10 ->
            OctO

        11 ->
            NovN

        _ ->
            DecD


{-|

    weekdayToNumber Mon -- 1

-}
weekdayToNumber : Day -> Int
weekdayToNumber d =
    case d of
        Mon ->
            1

        Tue ->
            2

        Wed ->
            3

        Thu ->
            4

        Fri ->
            5

        Sat ->
            6

        Sun ->
            7


{-|

    numberToWeekday 1 -- Mon

-}
numberToWeekday : Int -> Day
numberToWeekday n =
    case max 1 n of
        1 ->
            Mon

        2 ->
            Tue

        3 ->
            Wed

        4 ->
            Thu

        5 ->
            Fri

        6 ->
            Sat

        _ ->
            Sun


{-| -}
msPerSecond : Int
msPerSecond =
    1000


{-| -}
msPerMinute : Int
msPerMinute =
    60 * msPerSecond


{-| -}
msPerHour : Int
msPerHour =
    60 * msPerMinute


{-| -}
msPerDay : Int
msPerDay =
    24 * msPerHour