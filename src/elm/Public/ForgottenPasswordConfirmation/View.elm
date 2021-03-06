module Public.ForgottenPasswordConfirmation.View exposing (..)

import ActionResult exposing (ActionResult(..))
import Common.Form exposing (CustomFormError)
import Common.Html exposing (emptyNode, linkTo)
import Common.View.Forms exposing (errorView, formText, passwordGroup, submitButton)
import Form exposing (Form)
import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs
import Public.Common.View exposing (publicForm)
import Public.ForgottenPasswordConfirmation.Models exposing (..)
import Public.ForgottenPasswordConfirmation.Msgs exposing (Msg(FormMsg))
import Public.Routing exposing (Route(Login))
import Routing


view : (Msg -> Msgs.Msg) -> Model -> Html Msgs.Msg
view wrapMsg model =
    let
        content =
            case model.submitting of
                Success _ ->
                    successView

                _ ->
                    signupForm wrapMsg model
    in
    div [ class "row justify-content-center" ]
        [ content ]


signupForm : (Msg -> Msgs.Msg) -> Model -> Html Msgs.Msg
signupForm wrapMsg model =
    let
        formConfig =
            { title = "Password Recovery"
            , submitMsg = wrapMsg <| FormMsg Form.Submit
            , actionResult = model.submitting
            , submitLabel = "Save"
            , formContent = formView model.form |> Html.map (wrapMsg << FormMsg)
            , link = Nothing
            }
    in
    publicForm formConfig


formView : Form CustomFormError PasswordForm -> Html Form.Msg
formView form =
    div []
        [ formText "Enter a new password you want to use to log in."
        , passwordGroup form "password" "New password"
        , passwordGroup form "passwordConfirmation" "New password again"
        ]


successView : Html Msgs.Msg
successView =
    div [ class "jumbotron full-page-error" ]
        [ h1 [ class "display-3" ] [ i [ class "fa fa-check" ] [] ]
        , p [ class "lead" ]
            [ text "Your password was has been changed. You can now "
            , linkTo (Routing.Public Login) [] [ text "log in" ]
            , text "."
            ]
        ]
