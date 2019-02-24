module Theme exposing (bBox, email, entry, font, fontAwesomeIcon, github, globe, h, h1l, h1r, h1s, h2l, h2r, h2s, h3l, h3r, h3s, h5s, h5sWithFontAwesome, header, hs, iconPadding, leftWidth, linkedin, phone, rightWidth, telegram, theme, twitter, w, whatsapp)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, src)
import Html.Styled.Events exposing (onClick)
import List.Extra exposing (splitAt)



-- Height of sheet


h : Float
h =
    296



-- Width of sheet


w : Float
w =
    210


leftWidth : Float
leftWidth =
    w * 0.35


rightWidth : Float
rightWidth =
    w * 0.65



-- https://www.colourlovers.com/palette/1720852/Resume_Pallete_9


theme : { secondary : Color, primary : Color, text : Color }
theme =
    { primary = hex "D5EBED"
    , secondary = hex "FFFFFF"
    , text = hex "404040"
    }


font : Float -> FontWeight a -> Style
font size weight =
    Css.batch
        [ fontFamilies [ "Open Sans", "sans-serif" ]
        , color theme.text
        , fontSize (pt size)
        , fontWeight weight
        ]


header : Style
header =
    font 18 (int 600)


bBox : Style
bBox =
    Css.batch
        [ display inlineBlock
        , boxSizing borderBox
        ]


hs :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> String
    -> Style
    -> Color
    -> Float
    -> FontWeight a
    -> Html msg
hs hNode title style borderCol size weight =
    let
        underlineCount =
            4

        ( s, e ) =
            splitAt underlineCount (String.split "" title)

        start =
            String.concat s

        end =
            String.concat e
    in
    hNode
        [ css
            [ font size weight
            , style
            , bBox
            ]
        ]
        [ span
            [ css
                [ borderBottomStyle solid
                , borderColor borderCol
                , borderBottomWidth (pt 2)
                ]
            ]
            [ text start ]
        , text end
        ]


h1s : String -> Color -> Html msg
h1s title borderColor =
    let
        style =
            Css.batch
                [ paddingBottom (mm 5)
                ]
    in
    hs h1 title style borderColor 20 (int 600)


h2s : String -> Color -> Html msg
h2s title borderColor =
    let
        style =
            Css.batch
                [ paddingBottom (mm 6)
                ]
    in
    hs h2 title style borderColor 16 (int 600)


h3s : String -> Color -> Html msg
h3s title borderColor =
    let
        style =
            Css.batch
                [ paddingBottom (mm 3)
                ]
    in
    hs h3 title style borderColor 12 (int 500)


h1r : String -> Html msg
h1r title =
    h1s title theme.primary


h2r : String -> Html msg
h2r title =
    h2s title theme.primary


h3r : String -> Html msg
h3r title =
    h3s title theme.primary


h1l : String -> Html msg
h1l title =
    h1s title theme.text


h2l : String -> Html msg
h2l title =
    h2s title theme.text


h3l : String -> Html msg
h3l title =
    h3s title theme.text


entry : String -> String -> String -> String -> String -> String -> Html msg
entry title desc url company from to =
    let
        spacing =
            Css.batch
                [ paddingRight (mm 1.5)
                ]

        dateStyle =
            Css.batch
                [ font 11 (int 400)
                , fontStyle italic
                , bBox
                , float right
                ]

        companyStyle =
            Css.batch
                [ font 11 (int 400)
                , bBox
                , float left
                ]
    in
    div [ css [ marginBottom (mm 10) ] ]
        [ h3r title
        , h5 [ css [ dateStyle ] ]
            [ span [ css [ spacing ] ] [ text from ]
            , span [ css [ spacing ] ] [ text "-" ]
            , span [ css [ spacing ] ] [ text to ]
            ]
        , h5 [ css [ companyStyle ] ]
            [ a
                [ href url
                , css
                    [ textDecoration none
                    , color theme.text
                    ]
                ]
                [ text company ]
            ]
        ]


iconPadding : Style
iconPadding =
    Css.batch [ paddingRight (mm 1.1) ]


h5s : String -> Html msg
h5s title =
    h5
        [ css
            [ font 11 (int 400)
            , bBox
            , paddingBottom (mm 2)
            ]
        ]
        [ text
            title
        ]


fontAwesomeIcon : String -> Html msg
fontAwesomeIcon faIcon =
    i [ class faIcon, css [ iconPadding ] ] []


h5sWithFontAwesome : String -> String -> Html msg
h5sWithFontAwesome title faIcon =
    span [ css [ bBox ] ]
        [ fontAwesomeIcon faIcon
        , h5s title
        ]


faSolid : String -> String
faSolid icon =
    "fas fa-" ++ icon


faBrand : String -> String
faBrand icon =
    "fab fa-" ++ icon


email : String -> Html msg
email address =
    let
        safe =
            String.replace "@" " at " address
    in
    h5sWithFontAwesome safe (faSolid "envelope")


globe : String -> Html msg
globe num =
    h5sWithFontAwesome num (faSolid "globe")


phone : String -> Html msg
phone num =
    h5sWithFontAwesome num (faSolid "phone")


github : String -> Html msg
github url =
    h5sWithFontAwesome url (faBrand "github")


linkedin : String -> Html msg
linkedin url =
    h5sWithFontAwesome url (faBrand "linkedin")


twitter : String -> Html msg
twitter url =
    h5sWithFontAwesome url (faBrand "twitter")


whatsapp : String -> Html msg
whatsapp num =
    h5sWithFontAwesome num (faBrand "whatsapp")


telegram : String -> Html msg
telegram num =
    h5sWithFontAwesome num (faBrand "telegram")
