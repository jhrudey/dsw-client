module UserManagement.Index.Msgs exposing (..)

import Jwt
import UserManagement.Models exposing (User)


type Msg
    = GetUsersCompleted (Result Jwt.JwtError (List User))