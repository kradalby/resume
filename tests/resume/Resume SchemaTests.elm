module resume.Resume SchemaTests exposing (..)

-- Tests: 

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer)
import Test exposing (..)
import Json.Decode as Decode
import resume.Resume Schema exposing (..)


resumeSchemaFuzzer : Fuzzer ResumeSchema
resumeSchemaFuzzer =
    Fuzz.map10
        ResumeSchema
        (Fuzz.maybe awardsFuzzer)
        (Fuzz.maybe basicsFuzzer)
        (Fuzz.maybe educationFuzzer)
        (Fuzz.maybe interestsFuzzer)
        (Fuzz.maybe languagesFuzzer)
        (Fuzz.maybe publicationsFuzzer)
        (Fuzz.maybe referencesFuzzer)
        (Fuzz.maybe skillsFuzzer)
        (Fuzz.maybe volunteerFuzzer)
        (Fuzz.maybe workFuzzer)


encodeDecodeResumeSchemaTest : Test
encodeDecodeResumeSchemaTest =
    fuzz resumeSchemaFuzzer "can encode and decode ResumeSchema object" <|
        \resumeSchema ->
            resumeSchema
                |> encodeResumeSchema
                |> Decode.decodeValue resumeSchemaDecoder
                |> Expect.equal (Ok resumeSchema)


awardsFuzzer : Fuzzer (List Items)
awardsFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodeAwardsTest : Test
encodeDecodeAwardsTest =
    fuzz awardsFuzzer "can encode and decode Awards" <|
        \awards ->
            awards
                |> encodeItemss
                |> Decode.decodeValue awardsDecoder
                |> Expect.equal (Ok awards)


basicsFuzzer : Fuzzer Basics
basicsFuzzer =
    Fuzz.map9
        Basics
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe locationFuzzer)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe profilesFuzzer)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeBasicsTest : Test
encodeDecodeBasicsTest =
    fuzz basicsFuzzer "can encode and decode Basics object" <|
        \basics ->
            basics
                |> encodeBasics
                |> Decode.decodeValue basicsDecoder
                |> Expect.equal (Ok basics)


coursesFuzzer : Fuzzer (List String)
coursesFuzzer =
    Fuzz.list Fuzz.string


encodeDecodeCoursesTest : Test
encodeDecodeCoursesTest =
    fuzz coursesFuzzer "can encode and decode Courses" <|
        \courses ->
            courses
                |> encodeStrings
                |> Decode.decodeValue coursesDecoder
                |> Expect.equal (Ok courses)


educationFuzzer : Fuzzer (List Items)
educationFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodeEducationTest : Test
encodeDecodeEducationTest =
    fuzz educationFuzzer "can encode and decode Education" <|
        \education ->
            education
                |> encodeItemss
                |> Decode.decodeValue educationDecoder
                |> Expect.equal (Ok education)


highlightsFuzzer : Fuzzer (List String)
highlightsFuzzer =
    Fuzz.list Fuzz.string


encodeDecodeHighlightsTest : Test
encodeDecodeHighlightsTest =
    fuzz highlightsFuzzer "can encode and decode Highlights" <|
        \highlights ->
            highlights
                |> encodeStrings
                |> Decode.decodeValue highlightsDecoder
                |> Expect.equal (Ok highlights)


highlightsFuzzer : Fuzzer (List String)
highlightsFuzzer =
    Fuzz.list Fuzz.string


encodeDecodeHighlightsTest : Test
encodeDecodeHighlightsTest =
    fuzz highlightsFuzzer "can encode and decode Highlights" <|
        \highlights ->
            highlights
                |> encodeStrings
                |> Decode.decodeValue highlightsDecoder
                |> Expect.equal (Ok highlights)


interestsFuzzer : Fuzzer (List Items)
interestsFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodeInterestsTest : Test
encodeDecodeInterestsTest =
    fuzz interestsFuzzer "can encode and decode Interests" <|
        \interests ->
            interests
                |> encodeItemss
                |> Decode.decodeValue interestsDecoder
                |> Expect.equal (Ok interests)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map2
        Items
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map7
        Items
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe coursesFuzzer)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map4
        Items
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map2
        Items
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map5
        Items
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map7
        Items
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe highlightsFuzzer)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map3
        Items
        (Fuzz.maybe keywordsFuzzer)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map2
        Items
        (Fuzz.maybe keywordsFuzzer)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map7
        Items
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe highlightsFuzzer)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


itemsFuzzer : Fuzzer Items
itemsFuzzer =
    Fuzz.map3
        Items
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeItemsTest : Test
encodeDecodeItemsTest =
    fuzz itemsFuzzer "can encode and decode Items object" <|
        \items ->
            items
                |> encodeItems
                |> Decode.decodeValue itemsDecoder
                |> Expect.equal (Ok items)


keywordsFuzzer : Fuzzer (List String)
keywordsFuzzer =
    Fuzz.list Fuzz.string


encodeDecodeKeywordsTest : Test
encodeDecodeKeywordsTest =
    fuzz keywordsFuzzer "can encode and decode Keywords" <|
        \keywords ->
            keywords
                |> encodeStrings
                |> Decode.decodeValue keywordsDecoder
                |> Expect.equal (Ok keywords)


keywordsFuzzer : Fuzzer (List String)
keywordsFuzzer =
    Fuzz.list Fuzz.string


encodeDecodeKeywordsTest : Test
encodeDecodeKeywordsTest =
    fuzz keywordsFuzzer "can encode and decode Keywords" <|
        \keywords ->
            keywords
                |> encodeStrings
                |> Decode.decodeValue keywordsDecoder
                |> Expect.equal (Ok keywords)


languagesFuzzer : Fuzzer (List Items)
languagesFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodeLanguagesTest : Test
encodeDecodeLanguagesTest =
    fuzz languagesFuzzer "can encode and decode Languages" <|
        \languages ->
            languages
                |> encodeItemss
                |> Decode.decodeValue languagesDecoder
                |> Expect.equal (Ok languages)


locationFuzzer : Fuzzer Location
locationFuzzer =
    Fuzz.map5
        Location
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)
        (Fuzz.maybe Fuzz.string)


encodeDecodeLocationTest : Test
encodeDecodeLocationTest =
    fuzz locationFuzzer "can encode and decode Location object" <|
        \location ->
            location
                |> encodeLocation
                |> Decode.decodeValue locationDecoder
                |> Expect.equal (Ok location)


profilesFuzzer : Fuzzer (List Items)
profilesFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodeProfilesTest : Test
encodeDecodeProfilesTest =
    fuzz profilesFuzzer "can encode and decode Profiles" <|
        \profiles ->
            profiles
                |> encodeItemss
                |> Decode.decodeValue profilesDecoder
                |> Expect.equal (Ok profiles)


publicationsFuzzer : Fuzzer (List Items)
publicationsFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodePublicationsTest : Test
encodeDecodePublicationsTest =
    fuzz publicationsFuzzer "can encode and decode Publications" <|
        \publications ->
            publications
                |> encodeItemss
                |> Decode.decodeValue publicationsDecoder
                |> Expect.equal (Ok publications)


referencesFuzzer : Fuzzer (List Items)
referencesFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodeReferencesTest : Test
encodeDecodeReferencesTest =
    fuzz referencesFuzzer "can encode and decode References" <|
        \references ->
            references
                |> encodeItemss
                |> Decode.decodeValue referencesDecoder
                |> Expect.equal (Ok references)


skillsFuzzer : Fuzzer (List Items)
skillsFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodeSkillsTest : Test
encodeDecodeSkillsTest =
    fuzz skillsFuzzer "can encode and decode Skills" <|
        \skills ->
            skills
                |> encodeItemss
                |> Decode.decodeValue skillsDecoder
                |> Expect.equal (Ok skills)


volunteerFuzzer : Fuzzer (List Items)
volunteerFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodeVolunteerTest : Test
encodeDecodeVolunteerTest =
    fuzz volunteerFuzzer "can encode and decode Volunteer" <|
        \volunteer ->
            volunteer
                |> encodeItemss
                |> Decode.decodeValue volunteerDecoder
                |> Expect.equal (Ok volunteer)


workFuzzer : Fuzzer (List Items)
workFuzzer =
    Fuzz.list itemsFuzzer


encodeDecodeWorkTest : Test
encodeDecodeWorkTest =
    fuzz workFuzzer "can encode and decode Work" <|
        \work ->
            work
                |> encodeItemss
                |> Decode.decodeValue workDecoder
                |> Expect.equal (Ok work)
