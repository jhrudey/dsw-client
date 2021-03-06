module Common.View exposing (..)

import ActionResult exposing (ActionResult(..))
import Common.Html exposing (emptyNode)
import Common.View.Forms exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


pageHeader : String -> List (Html msg) -> Html msg
pageHeader title actions =
    div [ class "header" ]
        [ h2 [] [ text title ]
        , pageActions actions
        ]


pageActions : List (Html msg) -> Html msg
pageActions actions =
    div [ class "actions" ]
        actions


fullPageLoader : Html msg
fullPageLoader =
    div [ class "full-page-loader" ]
        [ i [ class "fa fa-spinner fa-spin" ] []
        , div [] [ text "Loading..." ]
        ]


defaultFullPageError : String -> Html msg
defaultFullPageError =
    fullPageMessage "fa-frown-o"


fullPageMessage : String -> String -> Html msg
fullPageMessage icon error =
    div [ class "jumbotron full-page-message" ]
        [ h1 [ class "display-3" ] [ i [ class ("fa " ++ icon) ] [] ]
        , p [ class "lead" ] [ text error ]
        ]


fullPageActionResultView : (a -> Html msg) -> ActionResult a -> Html msg
fullPageActionResultView viewContent actionResult =
    case actionResult of
        Unset ->
            emptyNode

        Loading ->
            fullPageLoader

        Error err ->
            defaultFullPageError err

        Success result ->
            viewContent result


type alias ModalConfig msg =
    { modalTitle : String
    , modalContent : List (Html msg)
    , visible : Bool
    , actionResult : ActionResult String
    , actionName : String
    , actionMsg : msg
    , cancelMsg : Maybe msg
    }


modalView : ModalConfig msg -> Html msg
modalView cfg =
    let
        content =
            formResultView cfg.actionResult :: cfg.modalContent

        cancelDisabled =
            case cfg.actionResult of
                Loading ->
                    True

                _ ->
                    False

        cancelButton =
            case cfg.cancelMsg of
                Just cancelMsg ->
                    button [ onClick cancelMsg, disabled cancelDisabled, class "btn btn-secondary" ]
                        [ text "Cancel" ]

                Nothing ->
                    emptyNode
    in
    div [ class "modal-cover", classList [ ( "visible", cfg.visible ) ] ]
        [ div [ class "modal-dialog" ]
            [ div [ class "modal-content" ]
                [ div [ class "modal-header" ]
                    [ h5 [ class "modal-title" ] [ text cfg.modalTitle ]
                    ]
                , div [ class "modal-body" ]
                    content
                , div [ class "modal-footer" ]
                    [ actionButton ( cfg.actionName, cfg.actionResult, cfg.actionMsg )
                    , cancelButton
                    ]
                ]
            ]
        ]


type alias AlertConfig msg =
    { message : String
    , visible : Bool
    , actionMsg : msg
    , actionName : String
    }


alertView : AlertConfig msg -> Html msg
alertView cfg =
    div [ class "modal-cover", classList [ ( "visible", cfg.visible ) ] ]
        [ div [ class "modal-dialog" ]
            [ div [ class "modal-content" ]
                [ div [ class "modal-body text-center" ]
                    [ p [] [ text cfg.message ]
                    , button [ onClick cfg.actionMsg, class "btn btn-primary" ] [ text cfg.actionName ]
                    ]
                ]
            ]
        ]
