module KMEditor.Publish.Models exposing (..)

import ActionResult exposing (ActionResult(..))
import Common.Form exposing (CustomFormError)
import Form exposing (Form)
import Form.Validate as Validate exposing (..)
import Json.Encode as Encode exposing (..)
import KMEditor.Common.Models exposing (..)


type alias Model =
    { knowledgeModel : ActionResult KnowledgeModel
    , publishingKnowledgeModel : ActionResult String
    , form : Form CustomFormError KnowledgeModelPublishForm
    }


initialModel : Model
initialModel =
    { knowledgeModel = Loading
    , publishingKnowledgeModel = Unset
    , form = initKnowledgeModelPublishForm
    }


type alias KnowledgeModelPublishForm =
    { major : Int
    , minor : Int
    , patch : Int
    , description : String
    }


initKnowledgeModelPublishForm : Form CustomFormError KnowledgeModelPublishForm
initKnowledgeModelPublishForm =
    Form.initial [] knowledgeModelPublishFormValidation


knowledgeModelPublishFormValidation : Validation CustomFormError KnowledgeModelPublishForm
knowledgeModelPublishFormValidation =
    Validate.map4 KnowledgeModelPublishForm
        (Validate.field "major" (Validate.int |> Validate.andThen (Validate.minInt 0)))
        (Validate.field "minor" (Validate.int |> Validate.andThen (Validate.minInt 0)))
        (Validate.field "patch" (Validate.int |> Validate.andThen (Validate.minInt 0)))
        (Validate.field "description" Validate.string)


encodeKnowledgeModelPublishForm : KnowledgeModelPublishForm -> ( String, Encode.Value )
encodeKnowledgeModelPublishForm form =
    let
        version =
            String.join "." <| List.map toString [ form.major, form.minor, form.patch ]

        object =
            Encode.object [ ( "description", Encode.string form.description ) ]
    in
    ( version, object )
