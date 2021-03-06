module Helpers.DecimalField exposing (..)

import Json.Decode as Dec exposing (andThen)

type alias DecimalField =
    { value : Float
    , suffix : String
    }

fromFloat : Float -> DecimalField
fromFloat f =
    DecimalField f ""

fromString : String -> Float -> DecimalField
fromString val fallback =
    let
        f = Result.withDefault fallback (String.toFloat val)
        suffix =
            if String.endsWith "." val then
                "."
            else if String.endsWith ".0" val then
                ".0"
            else
                ""
    in
        DecimalField f suffix

display : DecimalField -> String
display field =
    toString field.value

inputValue : DecimalField -> String
inputValue d =
    (toString d.value) ++ d.suffix

toFixed : Float -> Int -> String
toFixed f decimals =
    let
        digits =
            f * (toFloat (10 ^ decimals))
            |> round
            |> toString
            |> String.padLeft decimals '0'
        frac =
            String.right decimals digits
        whole =
            String.dropRight decimals digits
        zeroPadded =
            if whole == "" then
                "0"
            else
                whole
    in
        String.join "." [zeroPadded, frac]

displayFixed : DecimalField -> Int -> String
displayFixed field decimals =
    toFixed field.value decimals

decodeDecimalField : Dec.Decoder DecimalField
decodeDecimalField =
    Dec.float
    |> andThen (\v -> Dec.succeed (fromFloat v))