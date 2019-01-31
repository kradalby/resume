module resume.Resume Schema exposing (..)

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
import resume.Utils
    exposing
        ( encodeNestedOptional
        , encodeNestedRequired
        , encodeOptional
        , encodeRequired
        )


type alias ResumeSchema =
    { awards : Maybe Awards
    , basics : Maybe Basics
    , education : Maybe Education
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
    , website : Maybe String
    }


type alias Items =
    { name : Maybe String
    , reference : Maybe String
    }


type alias Items =
    { area : Maybe String
    , courses : Maybe Courses
    , endDate : Maybe String
    , gpa : Maybe String
    , institution : Maybe String
    , startDate : Maybe String
    , studyType : Maybe String
    }


type alias Items =
    { awarder : Maybe String
    , date : Maybe String
    , summary : Maybe String
    , title : Maybe String
    }


type alias Items =
    { fluency : Maybe String
    , language : Maybe String
    }


type alias Items =
    { name : Maybe String
    , publisher : Maybe String
    , releaseDate : Maybe String
    , summary : Maybe String
    , website : Maybe String
    }


type alias Items =
    { endDate : Maybe String
    , highlights : Maybe Highlights
    , organization : Maybe String
    , position : Maybe String
    , startDate : Maybe String
    , summary : Maybe String
    , website : Maybe String
    }


type alias Items =
    { keywords : Maybe Keywords
    , level : Maybe String
    , name : Maybe String
    }


type alias Items =
    { keywords : Maybe Keywords
    , name : Maybe String
    }


type alias Items =
    { company : Maybe String
    , endDate : Maybe String
    , highlights : Maybe Highlights
    , position : Maybe String
    , startDate : Maybe String
    , summary : Maybe String
    , website : Maybe String
    }


type alias Items =
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


resumeSchemaDecoder : Decoder ResumeSchema
resumeSchemaDecoder =
    succeed ResumeSchema
        |> optional "awards" (nullable awardsDecoder) Nothing
        |> optional "basics" (nullable basicsDecoder) Nothing
        |> optional "education" (nullable educationDecoder) Nothing
        |> optional "interests" (nullable interestsDecoder) Nothing
        |> optional "languages" (nullable languagesDecoder) Nothing
        |> optional "publications" (nullable publicationsDecoder) Nothing
        |> optional "references" (nullable referencesDecoder) Nothing
        |> optional "skills" (nullable skillsDecoder) Nothing
        |> optional "volunteer" (nullable volunteerDecoder) Nothing
        |> optional "work" (nullable workDecoder) Nothing


awardsDecoder : Decoder (List Items)
awardsDecoder =
    Decode.list itemsDecoder


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


coursesDecoder : Decoder (List String)
coursesDecoder =
    Decode.list Decode.string


educationDecoder : Decoder (List Items)
educationDecoder =
    Decode.list itemsDecoder


highlightsDecoder : Decoder (List String)
highlightsDecoder =
    Decode.list Decode.string


highlightsDecoder : Decoder (List String)
highlightsDecoder =
    Decode.list Decode.string


interestsDecoder : Decoder (List Items)
interestsDecoder =
    Decode.list itemsDecoder


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "name" (nullable Decode.string) Nothing
        |> optional "reference" (nullable Decode.string) Nothing


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "area" (nullable Decode.string) Nothing
        |> optional "courses" (nullable coursesDecoder) Nothing
        |> optional "endDate" (nullable Decode.string) Nothing
        |> optional "gpa" (nullable Decode.string) Nothing
        |> optional "institution" (nullable Decode.string) Nothing
        |> optional "startDate" (nullable Decode.string) Nothing
        |> optional "studyType" (nullable Decode.string) Nothing


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "awarder" (nullable Decode.string) Nothing
        |> optional "date" (nullable Decode.string) Nothing
        |> optional "summary" (nullable Decode.string) Nothing
        |> optional "title" (nullable Decode.string) Nothing


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "fluency" (nullable Decode.string) Nothing
        |> optional "language" (nullable Decode.string) Nothing


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "name" (nullable Decode.string) Nothing
        |> optional "publisher" (nullable Decode.string) Nothing
        |> optional "releaseDate" (nullable Decode.string) Nothing
        |> optional "summary" (nullable Decode.string) Nothing
        |> optional "website" (nullable Decode.string) Nothing


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "endDate" (nullable Decode.string) Nothing
        |> optional "highlights" (nullable highlightsDecoder) Nothing
        |> optional "organization" (nullable Decode.string) Nothing
        |> optional "position" (nullable Decode.string) Nothing
        |> optional "startDate" (nullable Decode.string) Nothing
        |> optional "summary" (nullable Decode.string) Nothing
        |> optional "website" (nullable Decode.string) Nothing


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "keywords" (nullable keywordsDecoder) Nothing
        |> optional "level" (nullable Decode.string) Nothing
        |> optional "name" (nullable Decode.string) Nothing


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "keywords" (nullable keywordsDecoder) Nothing
        |> optional "name" (nullable Decode.string) Nothing


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "company" (nullable Decode.string) Nothing
        |> optional "endDate" (nullable Decode.string) Nothing
        |> optional "highlights" (nullable highlightsDecoder) Nothing
        |> optional "position" (nullable Decode.string) Nothing
        |> optional "startDate" (nullable Decode.string) Nothing
        |> optional "summary" (nullable Decode.string) Nothing
        |> optional "website" (nullable Decode.string) Nothing


itemsDecoder : Decoder Items
itemsDecoder =
    succeed Items
        |> optional "network" (nullable Decode.string) Nothing
        |> optional "url" (nullable Decode.string) Nothing
        |> optional "username" (nullable Decode.string) Nothing


keywordsDecoder : Decoder (List String)
keywordsDecoder =
    Decode.list Decode.string


keywordsDecoder : Decoder (List String)
keywordsDecoder =
    Decode.list Decode.string


languagesDecoder : Decoder (List Items)
languagesDecoder =
    Decode.list itemsDecoder


locationDecoder : Decoder Location
locationDecoder =
    succeed Location
        |> optional "address" (nullable Decode.string) Nothing
        |> optional "city" (nullable Decode.string) Nothing
        |> optional "countryCode" (nullable Decode.string) Nothing
        |> optional "postalCode" (nullable Decode.string) Nothing
        |> optional "region" (nullable Decode.string) Nothing


profilesDecoder : Decoder (List Items)
profilesDecoder =
    Decode.list itemsDecoder


publicationsDecoder : Decoder (List Items)
publicationsDecoder =
    Decode.list itemsDecoder


referencesDecoder : Decoder (List Items)
referencesDecoder =
    Decode.list itemsDecoder


skillsDecoder : Decoder (List Items)
skillsDecoder =
    Decode.list itemsDecoder


volunteerDecoder : Decoder (List Items)
volunteerDecoder =
    Decode.list itemsDecoder


workDecoder : Decoder (List Items)
workDecoder =
    Decode.list itemsDecoder


encodeResumeSchema : ResumeSchema -> Value
encodeResumeSchema resumeSchema =
    []
        |> encodeOptional "awards" resumeSchema.awards encodeAwards
        |> encodeOptional "basics" resumeSchema.basics encodeBasics
        |> encodeOptional "education" resumeSchema.education encodeEducation
        |> encodeOptional "interests" resumeSchema.interests encodeInterests
        |> encodeOptional "languages" resumeSchema.languages encodeLanguages
        |> encodeOptional "publications" resumeSchema.publications encodePublications
        |> encodeOptional "references" resumeSchema.references encodeReferences
        |> encodeOptional "skills" resumeSchema.skills encodeSkills
        |> encodeOptional "volunteer" resumeSchema.volunteer encodeVolunteer
        |> encodeOptional "work" resumeSchema.work encodeWork
        |> Encode.object


encodeItemss : List Items -> Value
encodeItemss awards =
    awards
        |> List.map encodeItems
        |> Encode.list


encodeBasics : Basics -> Value
encodeBasics basics =
    []
        |> encodeOptional "email" basics.email Encode.string
        |> encodeOptional "label" basics.label Encode.string
        |> encodeOptional "location" basics.location encodeLocation
        |> encodeOptional "name" basics.name Encode.string
        |> encodeOptional "phone" basics.phone Encode.string
        |> encodeOptional "picture" basics.picture Encode.string
        |> encodeOptional "profiles" basics.profiles encodeProfiles
        |> encodeOptional "summary" basics.summary Encode.string
        |> encodeOptional "website" basics.website Encode.string
        |> Encode.object


encodeStrings : List String -> Value
encodeStrings courses =
    courses
        |> List.map Encode.string
        |> Encode.list


encodeItemss : List Items -> Value
encodeItemss education =
    education
        |> List.map encodeItems
        |> Encode.list


encodeStrings : List String -> Value
encodeStrings highlights =
    highlights
        |> List.map Encode.string
        |> Encode.list


encodeStrings : List String -> Value
encodeStrings highlights =
    highlights
        |> List.map Encode.string
        |> Encode.list


encodeItemss : List Items -> Value
encodeItemss interests =
    interests
        |> List.map encodeItems
        |> Encode.list


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "name" items.name Encode.string
        |> encodeOptional "reference" items.reference Encode.string
        |> Encode.object


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "area" items.area Encode.string
        |> encodeOptional "courses" items.courses encodeCourses
        |> encodeOptional "endDate" items.endDate Encode.string
        |> encodeOptional "gpa" items.gpa Encode.string
        |> encodeOptional "institution" items.institution Encode.string
        |> encodeOptional "startDate" items.startDate Encode.string
        |> encodeOptional "studyType" items.studyType Encode.string
        |> Encode.object


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "awarder" items.awarder Encode.string
        |> encodeOptional "date" items.date Encode.string
        |> encodeOptional "summary" items.summary Encode.string
        |> encodeOptional "title" items.title Encode.string
        |> Encode.object


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "fluency" items.fluency Encode.string
        |> encodeOptional "language" items.language Encode.string
        |> Encode.object


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "name" items.name Encode.string
        |> encodeOptional "publisher" items.publisher Encode.string
        |> encodeOptional "releaseDate" items.releaseDate Encode.string
        |> encodeOptional "summary" items.summary Encode.string
        |> encodeOptional "website" items.website Encode.string
        |> Encode.object


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "endDate" items.endDate Encode.string
        |> encodeOptional "highlights" items.highlights encodeHighlights
        |> encodeOptional "organization" items.organization Encode.string
        |> encodeOptional "position" items.position Encode.string
        |> encodeOptional "startDate" items.startDate Encode.string
        |> encodeOptional "summary" items.summary Encode.string
        |> encodeOptional "website" items.website Encode.string
        |> Encode.object


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "keywords" items.keywords encodeKeywords
        |> encodeOptional "level" items.level Encode.string
        |> encodeOptional "name" items.name Encode.string
        |> Encode.object


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "keywords" items.keywords encodeKeywords
        |> encodeOptional "name" items.name Encode.string
        |> Encode.object


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "company" items.company Encode.string
        |> encodeOptional "endDate" items.endDate Encode.string
        |> encodeOptional "highlights" items.highlights encodeHighlights
        |> encodeOptional "position" items.position Encode.string
        |> encodeOptional "startDate" items.startDate Encode.string
        |> encodeOptional "summary" items.summary Encode.string
        |> encodeOptional "website" items.website Encode.string
        |> Encode.object


encodeItems : Items -> Value
encodeItems items =
    []
        |> encodeOptional "network" items.network Encode.string
        |> encodeOptional "url" items.url Encode.string
        |> encodeOptional "username" items.username Encode.string
        |> Encode.object


encodeStrings : List String -> Value
encodeStrings keywords =
    keywords
        |> List.map Encode.string
        |> Encode.list


encodeStrings : List String -> Value
encodeStrings keywords =
    keywords
        |> List.map Encode.string
        |> Encode.list


encodeItemss : List Items -> Value
encodeItemss languages =
    languages
        |> List.map encodeItems
        |> Encode.list


encodeLocation : Location -> Value
encodeLocation location =
    []
        |> encodeOptional "address" location.address Encode.string
        |> encodeOptional "city" location.city Encode.string
        |> encodeOptional "countryCode" location.countryCode Encode.string
        |> encodeOptional "postalCode" location.postalCode Encode.string
        |> encodeOptional "region" location.region Encode.string
        |> Encode.object


encodeItemss : List Items -> Value
encodeItemss profiles =
    profiles
        |> List.map encodeItems
        |> Encode.list


encodeItemss : List Items -> Value
encodeItemss publications =
    publications
        |> List.map encodeItems
        |> Encode.list


encodeItemss : List Items -> Value
encodeItemss references =
    references
        |> List.map encodeItems
        |> Encode.list


encodeItemss : List Items -> Value
encodeItemss skills =
    skills
        |> List.map encodeItems
        |> Encode.list


encodeItemss : List Items -> Value
encodeItemss volunteer =
    volunteer
        |> List.map encodeItems
        |> Encode.list


encodeItemss : List Items -> Value
encodeItemss work =
    work
        |> List.map encodeItems
        |> Encode.list
