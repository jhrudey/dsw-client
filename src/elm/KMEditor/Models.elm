module KMEditor.Models exposing (..)

import KMEditor.Create.Models
import KMEditor.Editor.Models
import KMEditor.Index.Models
import KMEditor.Migration.Models
import KMEditor.Publish.Models
import KMEditor.Routing exposing (Route(..))


type alias Model =
    { createModel : KMEditor.Create.Models.Model
    , editor2Model : KMEditor.Editor.Models.Model
    , indexModel : KMEditor.Index.Models.Model
    , migrationModel : KMEditor.Migration.Models.Model
    , publishModel : KMEditor.Publish.Models.Model
    }


initialModel : Model
initialModel =
    { createModel = KMEditor.Create.Models.initialModel Nothing
    , editor2Model = KMEditor.Editor.Models.initialModel ""
    , indexModel = KMEditor.Index.Models.initialModel
    , migrationModel = KMEditor.Migration.Models.initialModel ""
    , publishModel = KMEditor.Publish.Models.initialModel
    }


initLocalModel : Route -> Model -> Model
initLocalModel route model =
    case route of
        Create selectedPackage ->
            { model | createModel = KMEditor.Create.Models.initialModel selectedPackage }

        Editor uuid ->
            { model | editor2Model = KMEditor.Editor.Models.initialModel uuid }

        Index ->
            { model | indexModel = KMEditor.Index.Models.initialModel }

        Migration uuid ->
            { model | migrationModel = KMEditor.Migration.Models.initialModel uuid }

        Publish uuid ->
            { model | publishModel = KMEditor.Publish.Models.initialModel }
