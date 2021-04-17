module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Css exposing (backgroundColor, borderBox, boxSizing, display, float, height, inlineBlock, mm, padding, pct, right, width)
import Html.Styled exposing (Html, div, span, text, toUnstyled)
import Html.Styled.Attributes exposing (class, css)
import Json.Decode as Decode
import Resume
import Theme exposing (bBoxBlock, email, entry, github, globe, h, h1l, h2l, h2r, h3l, leftWidth, linkedin, mbElement, phone, rightWidth, theme, whatsapp)



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    Maybe Resume.Resume


init : Decode.Value -> ( Model, Cmd Msg )
init flag =
    case Decode.decodeValue Resume.decoder flag of
        Ok resume ->
            ( Just resume, Cmd.none )

        Err _ ->
            ( Nothing, Cmd.none )



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
    case model of
        Nothing ->
            text "Could not parse resume"

        Just resume ->
            div []
                [ div [ class "sheet" ]
                    [ viewLeft resume
                    , viewRight resume
                    ]
                ]


viewLeft : Resume.Resume -> Html Msg
viewLeft resume =
    div
        [ css
            [ boxSizing borderBox
            , display inlineBlock
            , backgroundColor theme.primary
            , height (mm h)
            , width (mm leftWidth)
            , padding (mm 10)
            ]
        ]
        [ viewMaybe viewBasics resume.basics
        , viewMaybe viewSkills resume.skills
        , viewMaybe viewLanguages resume.languages
        , viewMaybe viewInterests resume.interests
        ]


viewRight : Resume.Resume -> Html Msg
viewRight resume =
    div
        [ css
            [ boxSizing borderBox
            , display inlineBlock
            , backgroundColor theme.secondary
            , height (mm h)
            , width (mm rightWidth)
            , padding (mm 10)
            , float right
            ]
        ]
        [ viewMaybe viewWork resume.work
        , viewMaybe viewEducations resume.education
        , viewMaybe viewVolunteer resume.volunteer
        ]


viewMaybe : (msg -> Html Msg) -> Maybe msg -> Html Msg
viewMaybe viewFunc data =
    case data of
        Nothing ->
            text ""

        Just d ->
            viewFunc d



-- viewKeywords : Resume.Keywords -> Html Msg
-- viewKeywords courses =
--     div [] <| List.map viewString courses
--
--
-- viewHighlights : Resume.Highlights -> Html Msg
-- viewHighlights courses =
--     div [] <| List.map viewString courses
-- -----------------------------------------------
--  Educations
-- -----------------------------------------------


viewEducations : Resume.Educations -> Html Msg
viewEducations educations =
    let
        entries =
            List.map viewEducation educations
    in
    div
        [ css [ mbElement ]
        ]
    <|
        [ h2r "Education"
        ]
            ++ entries


viewEducation : Resume.Education -> Html Msg
viewEducation education =
    let
        institution =
            Maybe.withDefault "" education.institution

        studyType =
            Maybe.withDefault "" education.studyType

        area =
            Maybe.withDefault "" education.area

        startDate =
            Maybe.withDefault "" education.startDate

        endDate =
            Maybe.withDefault "" education.endDate

        summary =
            Maybe.withDefault "" education.summary
    in
    -- edu institution studyType area startDate endDate
    entry (area ++ " - " ++ studyType) summary "" institution startDate endDate



-- viewCourses : Resume.Courses -> Html Msg
-- viewCourses courses =
--     div [] <| List.map viewString courses
-- -----------------------------------------------
-- END Educations
-- -----------------------------------------------
-- -----------------------------------------------
--  Interests
-- -----------------------------------------------


viewInterests : Resume.Interests -> Html Msg
viewInterests interests =
    let
        entries =
            List.map viewInterest interests
    in
    div [ css [ mbElement ] ] <|
        [ h2l "Interests"
        ]
            ++ entries


viewInterest : Resume.Interest -> Html Msg
viewInterest interest =
    let
        name =
            Maybe.withDefault "" interest.name
    in
    Theme.interest name



-- -----------------------------------------------
-- END Interests
-- -----------------------------------------------
-- -----------------------------------------------
--  Languages
-- -----------------------------------------------


viewLanguages : Resume.Languages -> Html Msg
viewLanguages languages =
    let
        entries =
            List.map viewLanguage languages
    in
    div [ css [ mbElement ] ] <|
        [ h2l "Languages"
        ]
            ++ entries


viewLanguage : Resume.Language -> Html Msg
viewLanguage language =
    let
        lang =
            Maybe.withDefault "" language.language

        fluency =
            Maybe.withDefault "" language.fluency
    in
    Theme.language lang fluency



-- -----------------------------------------------
-- END Languages
-- -----------------------------------------------
-- -----------------------------------------------
--  Skills
-- -----------------------------------------------


viewSkills : Resume.Skills -> Html Msg
viewSkills skills =
    let
        entries =
            List.map
                viewSkill
                skills
    in
    div [ css [ mbElement ] ] <|
        [ h2l "Skills"
        ]
            ++ entries


viewSkill : Resume.Skill -> Html Msg
viewSkill skill =
    let
        name =
            Maybe.withDefault "" skill.name

        level =
            Maybe.withDefault "" skill.level

        keywords =
            Maybe.withDefault [] skill.keywords
    in
    Theme.skill name level keywords



-- -----------------------------------------------
-- END Skills
-- -----------------------------------------------
-- -----------------------------------------------
--  Volunteer
-- -----------------------------------------------


viewVolunteer : Resume.Volunteer -> Html Msg
viewVolunteer volunteer =
    let
        entries =
            List.map viewVolunteering volunteer
    in
    div
        [ css [ mbElement ]
        ]
    <|
        [ h2r "Volunteering"
        ]
            ++ entries


viewVolunteering : Resume.Volunteering -> Html Msg
viewVolunteering volunteer =
    let
        position =
            Maybe.withDefault "" volunteer.position

        summary =
            Maybe.withDefault "" volunteer.summary

        website =
            Maybe.withDefault "" volunteer.website

        startDate =
            Maybe.withDefault "" volunteer.startDate

        endDate =
            Maybe.withDefault "" volunteer.endDate

        organization =
            Maybe.withDefault "" volunteer.organization
    in
    entry position summary website organization startDate endDate



-- -----------------------------------------------
-- END Volunteer
-- -----------------------------------------------
-- -----------------------------------------------
--  Work
-- -----------------------------------------------


viewWork : Resume.Work -> Html Msg
viewWork jobs =
    let
        entries =
            List.map viewJob jobs
    in
    div
        [ css [ mbElement ]
        ]
    <|
        [ h2r "Experience"
        ]
            ++ entries


viewJob : Resume.Job -> Html Msg
viewJob job =
    let
        position =
            Maybe.withDefault "" job.position

        summary =
            Maybe.withDefault "" job.summary

        website =
            Maybe.withDefault "" job.website

        startDate =
            Maybe.withDefault "" job.startDate

        endDate =
            Maybe.withDefault "" job.endDate

        company =
            Maybe.withDefault "" job.company
    in
    entry position summary website company startDate endDate



-- -----------------------------------------------
-- END Work
-- -----------------------------------------------
-- -----------------------------------------------
--  Basics
-- -----------------------------------------------


viewBasics : Resume.Basics -> Html Msg
viewBasics basics =
    div
        [ css
            [ boxSizing borderBox
            , width (pct 100)
            , display inlineBlock
            ]
        ]
        [ viewMaybe viewName basics.name
        , viewMaybe viewLabel basics.label
        , viewContact basics
        ]


viewName : String -> Html Msg
viewName name =
    h1l name


viewLabel : String -> Html Msg
viewLabel label =
    span [ css [ mbElement, bBoxBlock ] ] [ h3l label ]


viewContact : Resume.Basics -> Html Msg
viewContact basics =
    div [ css [ mbElement ] ]
        [ h2l "Contact"
        , viewMaybe viewLocation basics.location
        , viewMaybe email basics.email
        , viewMaybe phone basics.phone

        -- , viewMaybe telegram basics.phone
        , viewMaybe viewProfiles basics.profiles
        ]


viewLocation : Resume.Location -> Html Msg
viewLocation location =
    let
        place =
            case ( location.city, location.countryCode ) of
                ( Nothing, Nothing ) ->
                    ""

                ( Just city, Nothing ) ->
                    city

                ( Nothing, Just countryCode ) ->
                    countryCodeToCountry countryCode

                ( Just city, Just countryCode ) ->
                    city
                        ++ ", "
                        ++ countryCodeToCountry countryCode
    in
    globe place


countryCodeToCountry : String -> String
countryCodeToCountry countryCode =
    case countryCode of
        "NL" ->
            "Netherlands"

        "NO" ->
            "Norway"

        "UK" ->
            "United Kingdom"

        _ ->
            "Unknown country code"


viewProfiles : Resume.Profiles -> Html Msg
viewProfiles profiles =
    div [] <| List.map viewProfile profiles


viewProfile : Resume.Profile -> Html Msg
viewProfile profile =
    let
        network =
            Maybe.withDefault "" profile.network
                |> String.toLower
    in
    case network of
        "github" ->
            viewMaybe github profile.url

        "linkedin" ->
            viewMaybe linkedin profile.url

        _ ->
            text ""



-- -----------------------------------------------
-- END Basics
-- -----------------------------------------------
-- ---------------------------
-- MAIN
-- ---------------------------


main : Program Decode.Value Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view =
            (\msg ->
                view msg
            )
                >> toUnstyled
        , subscriptions = \_ -> Sub.none
        }
