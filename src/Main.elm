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
    { resume : Maybe Resume.Resume
    }


init : Decode.Value -> ( Model, Cmd Msg )
init flag =
    case Decode.decodeValue Resume.decoder flag of
        Ok resume ->
            ( { resume = Just resume }, Cmd.none )

        Err err ->
            ( { resume = Nothing }, Cmd.none )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = Inc


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Inc ->
            ( model, Cmd.none )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Html Msg
view model =
    case model.resume of
        Nothing ->
            text "Could not parse resume"

        Just resume ->
            div []
                [ section [ class "sheet padding-10mm" ]
                    [ article []
                        [ text "This will be CV" ]
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
