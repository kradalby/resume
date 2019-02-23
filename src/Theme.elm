module Theme exposing (entry, font, h, h1s, h2s, h3s, header, hs, leftWidth, rightWidth, theme, w)

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
    -> Float
    -> FontWeight a
    -> Html msg
hs hNode title size weight =
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
            , paddingBottom (mm 5)
            , bBox
            ]
        ]
        [ span
            [ css
                [ borderBottomStyle solid
                , borderColor theme.primary
                , borderBottomWidth (pt 2)
                ]
            ]
            [ text start ]
        , text end
        ]


h1s : String -> Html msg
h1s title =
    hs h1 title 18 (int 600)


h2s : String -> Html msg
h2s title =
    hs h2 title 16 (int 600)


h3s : String -> Html msg
h3s title =
    hs h3 title 12 (int 500)


entry : String -> String -> String -> String -> String -> Html msg
entry title desc url from to =
    let
        spacing =
            Css.batch
                [ paddingRight (mm 1.5)
                ]

        dateStyle =
            Css.batch
                [ font 12 (int 400)
                , fontStyle italic
                , bBox
                , float right
                ]
    in
    div []
        [ h3s title
        , h5 [ css [ dateStyle ] ]
            [ span [ css [ spacing ] ] [ text from ]
            , span [ css [ spacing ] ] [ text "-" ]
            , span [ css [ spacing ] ] [ text to ]
            ]
        ]
