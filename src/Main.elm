module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, src)
import Html.Styled.Events exposing (onClick)
import Json.Decode as Decode
import Resume
import Theme exposing (..)



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
                [ div [ class "sheet" ]
                    [ viewLeft resume
                    , viewRight resume
                    ]

                -- [ article []
                --     [
                --     , viewMaybe viewAwards resume.awards
                --     , viewMaybe viewEducations resume.education
                --     , viewMaybe viewInterests resume.interests
                --     , viewMaybe viewLanguages resume.languages
                --     , viewMaybe viewPublications resume.publications
                --     , viewMaybe viewReferences resume.references
                --     , viewMaybe viewSkills resume.skills
                --     , viewMaybe viewWork resume.work
                --     ]
                -- ]
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
        [ viewMaybe viewBasics resume.basics ]


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
        , viewMaybe viewVolunteer resume.volunteer
        ]


viewMaybe : (msg -> Html Msg) -> Maybe msg -> Html Msg
viewMaybe viewFunc data =
    case data of
        Nothing ->
            text ""

        Just d ->
            viewFunc d


viewKeywords : Resume.Keywords -> Html Msg
viewKeywords courses =
    div [] <| List.map viewString courses


viewHighlights : Resume.Highlights -> Html Msg
viewHighlights courses =
    div [] <| List.map viewString courses



-- -----------------------------------------------
--  Awards
-- -----------------------------------------------


viewAwards : Resume.Awards -> Html Msg
viewAwards awards =
    div [] <| List.map viewAward awards


viewAward : Resume.Award -> Html Msg
viewAward award =
    div []
        [ viewMaybe viewString award.awarder
        , viewMaybe viewString award.date
        , viewMaybe viewString award.summary
        , viewMaybe viewString award.title
        ]



-- -----------------------------------------------
-- END Awards
-- -----------------------------------------------
-- -----------------------------------------------
--  Educations
-- -----------------------------------------------


viewEducations : Resume.Educations -> Html Msg
viewEducations educations =
    div [] <| List.map viewEducation educations


viewEducation : Resume.Education -> Html Msg
viewEducation education =
    div []
        [ viewMaybe viewString education.area
        , viewMaybe viewString education.startDate
        , viewMaybe viewString education.endDate
        , viewMaybe viewString education.gpa
        , viewMaybe viewString education.institution
        , viewMaybe viewString education.studyType
        , viewMaybe viewCourses education.courses
        ]


viewCourses : Resume.Courses -> Html Msg
viewCourses courses =
    div [] <| List.map viewString courses



-- -----------------------------------------------
-- END Educations
-- -----------------------------------------------
-- -----------------------------------------------
--  Interests
-- -----------------------------------------------


viewInterests : Resume.Interests -> Html Msg
viewInterests interests =
    div [] <| List.map viewInterest interests


viewInterest : Resume.Interest -> Html Msg
viewInterest interest =
    div []
        [ viewMaybe viewString interest.name
        , viewMaybe viewKeywords interest.keywords
        ]



-- -----------------------------------------------
-- END Interests
-- -----------------------------------------------
-- -----------------------------------------------
--  Languages
-- -----------------------------------------------


viewLanguages : Resume.Languages -> Html Msg
viewLanguages languages =
    div [] <| List.map viewLanguage languages


viewLanguage : Resume.Language -> Html Msg
viewLanguage language =
    div []
        [ viewMaybe viewString language.fluency
        , viewMaybe viewString language.language
        ]



-- -----------------------------------------------
-- END Languages
-- -----------------------------------------------
-- -----------------------------------------------
--  Publications
-- -----------------------------------------------


viewPublications : Resume.Publications -> Html Msg
viewPublications publications =
    div [] <| List.map viewPublication publications


viewPublication : Resume.Publication -> Html Msg
viewPublication publication =
    div []
        [ viewMaybe viewString publication.name
        , viewMaybe viewString publication.publisher
        , viewMaybe viewString publication.releaseDate
        , viewMaybe viewString publication.summary
        , viewMaybe viewString publication.website
        ]



-- -----------------------------------------------
-- END Publications
-- -----------------------------------------------
-- -----------------------------------------------
--  References
-- -----------------------------------------------


viewReferences : Resume.References -> Html Msg
viewReferences references =
    div [] <| List.map viewReference references


viewReference : Resume.Reference -> Html Msg
viewReference reference =
    div []
        [ viewMaybe viewString reference.name
        , viewMaybe viewString reference.reference
        ]



-- -----------------------------------------------
-- END References
-- -----------------------------------------------
-- -----------------------------------------------
--  Skills
-- -----------------------------------------------


viewSkills : Resume.Skills -> Html Msg
viewSkills skills =
    div [] <| List.map viewSkill skills


viewSkill : Resume.Skill -> Html Msg
viewSkill skill =
    div []
        [ viewMaybe viewString skill.name
        , viewMaybe viewString skill.level
        , viewMaybe viewKeywords skill.keywords
        ]



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
        [ css [ paddingBottom (mm 7) ]
        ]
    <|
        [ h2s "Volunteering"
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
        [ css [ paddingBottom (mm 7) ]
        ]
    <|
        [ h2s "Work"
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



-- div []
--     [ viewMaybe viewString job.company
--     , viewMaybe viewString job.startDate
--     , viewMaybe viewString job.endDate
--     , viewMaybe viewString job.position
--     , viewMaybe viewString job.summary
--     , viewMaybe viewString job.website
--     , viewMaybe viewHighlights job.highlights
--     ]
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
        [ viewMaybe viewName basics.name ]



-- [ viewMaybe viewString basics.email
-- , viewMaybe viewString basics.label
-- ,
-- , viewMaybe viewString basics.phone
-- , viewMaybe viewString basics.picture
-- , viewMaybe viewString basics.summary
-- , viewMaybe viewString basics.website
-- , viewMaybe viewLocation basics.location
-- , viewMaybe viewProfiles basics.profiles
-- ]


viewName : String -> Html Msg
viewName name =
    h1s name


viewString : String -> Html Msg
viewString str =
    p [] [ text str ]


viewLocation : Resume.Location -> Html Msg
viewLocation location =
    div []
        [ viewMaybe viewString location.address
        , viewMaybe viewString location.city
        , viewMaybe viewString location.countryCode
        , viewMaybe viewString location.postalCode
        , viewMaybe viewString location.region
        ]


viewProfiles : Resume.Profiles -> Html Msg
viewProfiles profiles =
    div [] <| List.map viewProfile profiles


viewProfile : Resume.Profile -> Html Msg
viewProfile profile =
    div []
        [ viewMaybe viewString profile.network
        , viewMaybe viewString profile.url
        , viewMaybe viewString profile.username
        ]



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
