module Resume exposing (..)

--

import Json.Decode as Decode
    exposing
        ( Decoder
        , andThen
        , at
        , fail
        , field
        , index
        , map
        , maybe
        , nullable
        , oneOf
        , succeed
        )
import Json.Decode.Pipeline
    exposing
        ( custom
        , optional
        , required
        )
import Json.Encode as Encode
    exposing
        ( Value
        , list
        , object
        )
import ResumeUtils
    exposing
        ( encodeNestedOptional
        , encodeNestedRequired
        , encodeOptional
        , encodeRequired
        )


type alias Resume =
    { awards : Maybe Awards
    , basics : Maybe Basics
    , education : Maybe Educations
    , interests : Maybe Interests
    , languages : Maybe Languages
    , publications : Maybe Publications
    , references : Maybe References
    , skills : Maybe Skills
    , volunteer : Maybe Volunteer
    , work : Maybe Work
    }


type alias Basics =
    { email : Maybe String
    , label : Maybe String
    , location : Maybe Location
    , name : Maybe String
    , phone : Maybe String
    , picture : Maybe String
    , profiles : Maybe Profiles
    , summary : Maybe String
    , website : Maybe Url
    }


type alias Url =
    String


type alias Highlights =
    List String


type alias Courses =
    List String


type alias Keywords =
    List String


type alias References =
    List Reference


type alias Reference =
    { name : Maybe String
    , reference : Maybe String
    }


type alias Educations =
    List Education


type alias Education =
    { area : Maybe String
    , courses : Maybe Courses
    , endDate : Maybe String
    , gpa : Maybe String
    , institution : Maybe String
    , startDate : Maybe String
    , studyType : Maybe String
    }


type alias Awards =
    List Award


type alias Award =
    { awarder : Maybe String
    , date : Maybe String
    , summary : Maybe String
    , title : Maybe String
    }


type alias Languages =
    List Language


type alias Language =
    { fluency : Maybe String
    , language : Maybe String
    }


type alias Publications =
    List Publication


type alias Publication =
    { name : Maybe String
    , publisher : Maybe String
    , releaseDate : Maybe String
    , summary : Maybe String
    , website : Maybe Url
    }


type alias Volunteer =
    List Volunteering


type alias Volunteering =
    { endDate : Maybe String
    , highlights : Maybe Highlights
    , organization : Maybe String
    , position : Maybe String
    , startDate : Maybe String
    , summary : Maybe String
    , website : Maybe Url
    }


type alias Skills =
    List Skill


type alias Skill =
    { keywords : Maybe Keywords
    , level : Maybe String
    , name : Maybe String
    }


type alias Interests =
    List Interest


type alias Interest =
    { keywords : Maybe Keywords
    , name : Maybe String
    }


type alias Work =
    List Job


type alias Job =
    { company : Maybe String
    , endDate : Maybe String
    , highlights : Maybe Highlights
    , position : Maybe String
    , startDate : Maybe String
    , summary : Maybe String
    , website : Maybe Url
    }


type alias Profiles =
    List Profile


type alias Profile =
    { network : Maybe String
    , url : Maybe String
    , username : Maybe String
    }


type alias Location =
    { address : Maybe String
    , city : Maybe String
    , countryCode : Maybe String
    , postalCode : Maybe String
    , region : Maybe String
    }


decoder : Decoder Resume
decoder =
    succeed Resume
        |> optional "awards" (nullable awardsDecoder) Nothing
        |> optional "basics" (nullable basicsDecoder) Nothing
        |> optional "education" (nullable educationsDecoder) Nothing
        |> optional "interests" (nullable interestsDecoder) Nothing
        |> optional "languages" (nullable languagesDecoder) Nothing
        |> optional "publications" (nullable publicationsDecoder) Nothing
        |> optional "references" (nullable referencesDecoder) Nothing
        |> optional "skills" (nullable skillsDecoder) Nothing
        |> optional "volunteer" (nullable volunteerDecoder) Nothing
        |> optional "work" (nullable workDecoder) Nothing


awardsDecoder : Decoder Awards
awardsDecoder =
    Decode.list awardDecoder


basicsDecoder : Decoder Basics
basicsDecoder =
    succeed Basics
        |> optional "email" (nullable Decode.string) Nothing
        |> optional "label" (nullable Decode.string) Nothing
        |> optional "location" (nullable locationDecoder) Nothing
        |> optional "name" (nullable Decode.string) Nothing
        |> optional "phone" (nullable Decode.string) Nothing
        |> optional "picture" (nullable Decode.string) Nothing
        |> optional "profiles" (nullable profilesDecoder) Nothing
        |> optional "summary" (nullable Decode.string) Nothing
        |> optional "website" (nullable Decode.string) Nothing


coursesDecoder : Decoder Courses
coursesDecoder =
    Decode.list Decode.string


educationsDecoder : Decoder Educations
educationsDecoder =
    Decode.list educationDecoder


highlightsDecoder : Decoder Highlights
highlightsDecoder =
    Decode.list Decode.string


interestsDecoder : Decoder Interests
interestsDecoder =
    Decode.list interestDecoder


referenceDecoder : Decoder Reference
referenceDecoder =
    succeed Reference
        |> optional "name" (nullable Decode.string) Nothing
        |> optional "reference" (nullable Decode.string) Nothing


educationDecoder : Decoder Education
educationDecoder =
    succeed Education
        |> optional "area" (nullable Decode.string) Nothing
        |> optional "courses" (nullable coursesDecoder) Nothing
        |> optional "endDate" (nullable Decode.string) Nothing
        |> optional "gpa" (nullable Decode.string) Nothing
        |> optional "institution" (nullable Decode.string) Nothing
        |> optional "startDate" (nullable Decode.string) Nothing
        |> optional "studyType" (nullable Decode.string) Nothing


awardDecoder : Decoder Award
awardDecoder =
    succeed Award
        |> optional "awarder" (nullable Decode.string) Nothing
        |> optional "date" (nullable Decode.string) Nothing
        |> optional "summary" (nullable Decode.string) Nothing
        |> optional "title" (nullable Decode.string) Nothing


languageDecoder : Decoder Language
languageDecoder =
    succeed Language
        |> optional "fluency" (nullable Decode.string) Nothing
        |> optional "language" (nullable Decode.string) Nothing


publicationDecoder : Decoder Publication
publicationDecoder =
    succeed Publication
        |> optional "name" (nullable Decode.string) Nothing
        |> optional "publisher" (nullable Decode.string) Nothing
        |> optional "releaseDate" (nullable Decode.string) Nothing
        |> optional "summary" (nullable Decode.string) Nothing
        |> optional "website" (nullable Decode.string) Nothing


volunteeringDecoder : Decoder Volunteering
volunteeringDecoder =
    succeed Volunteering
        |> optional "endDate" (nullable Decode.string) Nothing
        |> optional "highlights" (nullable highlightsDecoder) Nothing
        |> optional "organization" (nullable Decode.string) Nothing
        |> optional "position" (nullable Decode.string) Nothing
        |> optional "startDate" (nullable Decode.string) Nothing
        |> optional "summary" (nullable Decode.string) Nothing
        |> optional "website" (nullable Decode.string) Nothing


skillDecoder : Decoder Skill
skillDecoder =
    succeed Skill
        |> optional "keywords" (nullable keywordsDecoder) Nothing
        |> optional "level" (nullable Decode.string) Nothing
        |> optional "name" (nullable Decode.string) Nothing


interestDecoder : Decoder Interest
interestDecoder =
    succeed Interest
        |> optional "keywords" (nullable keywordsDecoder) Nothing
        |> optional "name" (nullable Decode.string) Nothing


jobDecoder : Decoder Job
jobDecoder =
    succeed Job
        |> optional "company" (nullable Decode.string) Nothing
        |> optional "endDate" (nullable Decode.string) Nothing
        |> optional "highlights" (nullable highlightsDecoder) Nothing
        |> optional "position" (nullable Decode.string) Nothing
        |> optional "startDate" (nullable Decode.string) Nothing
        |> optional "summary" (nullable Decode.string) Nothing
        |> optional "website" (nullable Decode.string) Nothing


profileDecoder : Decoder Profile
profileDecoder =
    succeed Profile
        |> optional "network" (nullable Decode.string) Nothing
        |> optional "url" (nullable Decode.string) Nothing
        |> optional "username" (nullable Decode.string) Nothing


keywordsDecoder : Decoder Keywords
keywordsDecoder =
    Decode.list Decode.string


languagesDecoder : Decoder Languages
languagesDecoder =
    Decode.list languageDecoder


locationDecoder : Decoder Location
locationDecoder =
    succeed Location
        |> optional "address" (nullable Decode.string) Nothing
        |> optional "city" (nullable Decode.string) Nothing
        |> optional "countryCode" (nullable Decode.string) Nothing
        |> optional "postalCode" (nullable Decode.string) Nothing
        |> optional "region" (nullable Decode.string) Nothing


profilesDecoder : Decoder Profiles
profilesDecoder =
    Decode.list profileDecoder


publicationsDecoder : Decoder Publications
publicationsDecoder =
    Decode.list publicationDecoder


referencesDecoder : Decoder References
referencesDecoder =
    Decode.list referenceDecoder


skillsDecoder : Decoder Skills
skillsDecoder =
    Decode.list skillDecoder


volunteerDecoder : Decoder Volunteer
volunteerDecoder =
    Decode.list volunteeringDecoder


workDecoder : Decoder Work
workDecoder =
    Decode.list jobDecoder
