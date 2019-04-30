module Main exposing (Event, Model, Msg(..), eventConfig, main, model, timeSlotConfig, update, view, viewConfig)

import Calendar
import Date exposing (Date)
import Fixtures
import Html exposing (..)


main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }


type alias Model =
    { calendarState : Calendar.State }


type alias Event =
    { id : String
    , title : String
    , start : Date
    , end : Date
    }


model : Model
model =
    { calendarState = Calendar.init Calendar.Month Fixtures.viewing }


type Msg
    = SetCalendarState Calendar.Msg
    | SelectDate Date


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCalendarState calendarMsg ->
            let
                ( updatedCalendar, maybeMsg ) =
                    Calendar.update eventConfig timeSlotConfig calendarMsg model.calendarState

                newModel =
                    { model | calendarState = updatedCalendar }
            in
            case maybeMsg of
                Nothing ->
                    newModel

                Just updateMsg ->
                    update updateMsg newModel

        SelectDate date ->
            model


view : Model -> Html Msg
view model =
    div []
        [ Html.map SetCalendarState (Calendar.view viewConfig Fixtures.events model.calendarState) ]


viewConfig : Calendar.ViewConfig Event
viewConfig =
    Calendar.viewConfig
        { toId = .id
        , title = .title
        , start = .start
        , end = .end
        , event =
            \event isSelected ->
                Calendar.eventView
                    { nodeName = "div"
                    , classes =
                        [ ( "elm-calendar--event-content", True )
                        , ( "elm-calendar--event-content--is-selected", isSelected )
                        ]
                    , children =
                        [ div []
                            [ text <| event.title ]
                        ]
                    }
        }


eventConfig : Calendar.EventConfig Msg
eventConfig =
    Calendar.eventConfig
        { onClick = \_ -> Nothing
        , onMouseEnter = \_ -> Nothing
        , onMouseLeave = \_ -> Nothing
        , onDragStart = \_ -> Nothing
        , onDragging = \_ _ -> Nothing
        , onDragEnd = \_ _ -> Nothing
        }


timeSlotConfig : Calendar.TimeSlotConfig Msg
timeSlotConfig =
    Calendar.timeSlotConfig
        { onClick = \date pos -> Just <| SelectDate date
        , onMouseEnter = \_ _ -> Nothing
        , onMouseLeave = \_ _ -> Nothing
        , onDragStart = \_ _ -> Nothing
        , onDragging = \_ _ -> Nothing
        , onDragEnd = \_ _ -> Nothing
        }
