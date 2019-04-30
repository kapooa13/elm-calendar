module Calendar.Week exposing (view, viewDates, viewWeekContent, viewWeekDay, viewWeekHeader)

import Calendar.Day exposing (viewAllDayCell, viewDate, viewDayEvents, viewDaySlotGroup, viewTimeGutter, viewTimeGutterHeader)
import Calendar.Msg exposing (Msg)
import Config exposing (ViewConfig)
import Date exposing (Date)
import Helpers
import Html exposing (..)
import Html.Attributes exposing (..)


viewWeekContent :
    ViewConfig event
    -> List event
    -> Maybe String
    -> Date
    -> List Date
    -> Html Msg
viewWeekContent config events selectedId viewing days =
    let
        timeGutter =
            viewTimeGutter viewing

        weekDays =
            List.map (viewWeekDay config events selectedId) days
    in
    div [ class "elm-calendar--week-content" ]
        (timeGutter :: weekDays)


viewWeekDay : ViewConfig event -> List event -> Maybe String -> Date -> Html Msg
viewWeekDay config events selectedId day =
    let
        viewDaySlots =
            Helpers.hours day
                |> List.map viewDaySlotGroup

        dayEvents =
            viewDayEvents config events selectedId day
    in
    div [ class "elm-calendar--day" ]
        (viewDaySlots ++ dayEvents)


view : ViewConfig event -> List event -> Maybe String -> Date -> Html Msg
view config events selectedId viewing =
    let
        weekRange =
            Helpers.dayRangeOfWeek viewing
    in
    div [ class "elm-calendar--week" ]
        [ viewWeekHeader weekRange
        , viewWeekContent config events selectedId viewing weekRange
        ]


viewWeekHeader : List Date -> Html Msg
viewWeekHeader days =
    div [ class "elm-calendar--week-header" ]
        [ viewDates days
        , viewAllDayCell days
        ]


viewDates : List Date -> Html Msg
viewDates days =
    div [ class "elm-calendar--dates" ]
        (viewTimeGutterHeader :: List.map viewDate days)
