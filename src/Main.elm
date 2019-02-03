module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import Resume


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
    div []
        [ section [ class "sheet padding-10mm" ]
            [ article []
                [ text "This is an A4 document." ]
            ]
        , section [ class "sheet padding-10mm" ]
            [ article []
                [ text "This is an A4 document." ]
            ]
        ]



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program Decode.Value Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view =
            \msg ->
                view msg
        , subscriptions = \_ -> Sub.none
        }
