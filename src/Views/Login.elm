module Views.Login exposing (view)

import Msg exposing (..)
import Pages.Login exposing (Model)

import Html exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Html.Attributes exposing (attribute, class, href, name, type_, value, placeholder)

view : Model -> Html Msg
view model =
  div []
    [ h1 []
      [ text "Login Page" ]
    , showErrors model
    , div [ class "uk-child-width-1-3@s" ]
      [ div [ class "uk-margin" ]
        [ input
          [ class "uk-input"
          , name "email"
          , type_ "input"
          , value model.email
          , placeholder "Email"
          , onInput (LoginMsg << Pages.Login.SetEmail)
          ] []
        ]
      , div [ class "uk-margin" ]
        [ input
          [ class "uk-input"
          , name "password"
          , type_ "password"
          , value model.password
          , placeholder "Password"
          , onInput (LoginMsg << Pages.Login.SetPassword)
          ] []
        ]
      , div [ class "uk-margin" ]
        [ button
          [ class "uk-button uk-button-primary"
          , type_ "button"
          , onClick (LoginMsg Pages.Login.Submit)
          ]
          [ text "Login" ]
        ]
      ]
    ]

showErrors : Model -> Html Msg
showErrors model =
  div []
    [ div []
      [ text "Error: "
      , text model.errorMsg
      ]
    , div []
      [ text "Token: "
      , text model.session.token
      ]
    , div []
      [ text "Exp: "
      , text model.session.exp
      ]
    ]
