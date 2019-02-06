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
                        [ viewMaybe viewBasics resume.basics
                        , viewMaybe viewAwards resume.awards
                        , viewMaybe viewEducations resume.education
                        , viewMaybe viewInterests resume.interests
                        , viewMaybe viewLanguages resume.languages
                        , viewMaybe viewPublications resume.publications
                        , viewMaybe viewReferences resume.references
                        , viewMaybe viewSkills resume.skills
                        , viewMaybe viewVolunteer resume.volunteer
                        , viewMaybe viewWork resume.work
                        ]
                    ]
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
    div [] <| List.map viewVolunteering volunteer


viewVolunteering : Resume.Volunteering -> Html Msg
viewVolunteering volunteer =
    div []
        [ viewMaybe viewString volunteer.startDate
        , viewMaybe viewString volunteer.endDate
        , viewMaybe viewHighlights volunteer.highlights
        , viewMaybe viewString volunteer.organization
        , viewMaybe viewString volunteer.position
        , viewMaybe viewString volunteer.summary
        , viewMaybe viewString volunteer.website
        ]



-- -----------------------------------------------
-- END Volunteer
-- -----------------------------------------------
-- -----------------------------------------------
--  Work
-- -----------------------------------------------


viewWork : Resume.Work -> Html Msg
viewWork jobs =
    div [] <| List.map viewJob jobs


viewJob : Resume.Job -> Html Msg
viewJob job =
    div []
        [ viewMaybe viewString job.company
        , viewMaybe viewString job.startDate
        , viewMaybe viewString job.endDate
        , viewMaybe viewString job.position
        , viewMaybe viewString job.summary
        , viewMaybe viewString job.website
        , viewMaybe viewHighlights job.highlights
        ]



-- -----------------------------------------------
-- END Work
-- -----------------------------------------------
-- -----------------------------------------------
--  Basics
-- -----------------------------------------------


viewBasics : Resume.Basics -> Html Msg
viewBasics basics =
    div []
        [ viewMaybe viewString basics.email
        , viewMaybe viewString basics.label
        , viewMaybe viewString basics.name
        , viewMaybe viewString basics.phone
        , viewMaybe viewString basics.picture
        , viewMaybe viewString basics.summary
        , viewMaybe viewString basics.website
        , viewMaybe viewLocation basics.location
        , viewMaybe viewProfiles basics.profiles
        ]


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
            \msg ->
                view msg
        , subscriptions = \_ -> Sub.none
        }
