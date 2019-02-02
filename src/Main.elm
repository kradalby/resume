module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import Resume


-- ---------------------------
-- PORTS
-- ---------------------------


port toJs : String -> Cmd msg



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { counter : Int
    }


init : Decode.Value -> ( Model, Cmd Msg )
init flags =
    ( { counter = 0 }, Cmd.none )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = Inc


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Inc ->
            ( { model | counter = model.counter + 1 }, Cmd.none )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 [] [ text "Hellow" ] ]



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program Decode.Value Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \msg ->
                { title = "Resume - Kristoffer Dalby"
                , body = [ view msg ]
                }
        , subscriptions = \_ -> Sub.none
        }
