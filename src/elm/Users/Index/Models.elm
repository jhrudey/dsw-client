module Users.Index.Models exposing (..)

import Common.Types exposing (ActionResult(..))
import Users.Common.Models exposing (User)


type alias Model =
    { users : ActionResult (List User)
    , userToBeDeleted : Maybe User
    , deletingUser : ActionResult String
    }


initialModel : Model
initialModel =
    { users = Loading
    , userToBeDeleted = Nothing
    , deletingUser = Unset
    }