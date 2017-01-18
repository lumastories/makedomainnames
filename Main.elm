-- Does not work yet! Don't compile ;)


module Main exposing (..)

import Html exposing (div, img, h1, button, text, input, br)
import Html.Attributes exposing (src, placeholder)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\model -> Sub.none)
        }


type alias Word =
    { word : String
    , nounSynonyms : List String
    , verbSynonyms : List String
    }


type alias Model =
    { words : List Word
    , word : Word
    }


type Msg
    = FetchSynonyms
    | NewSynonyms (Result Http.Error String)
    | UpdateWords String


init : ( Model, Cmd Msg )
init =
    ( Model [] { word = "", nounSynonyms = [], verbSynonyms = [] }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    div []
        [ h1 [] [ text "make domain names" ]
        , input [ placeholder "enter a word", onInput UpdateWords ] []
        , button [] [ text "add another word" ]
        , button [ onClick FetchSynonyms ] [ text "Get Synonyms" ]
        , br [] []
        , br [] []
        , ul [] [ li [] [ text "synonyms here" ] ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchSynonyms ->
            ( model, getSynonyms model.word )

        _ ->
            ( model, Cmd.none )



--NewSynonyms (Ok newData) ->
--    ( { model | words = newData }, Cmd.none )
--NewSynonyms (Err _) ->
--    ( model, Cmd.none )
--UpdateWords newTopic ->
--    ( { model | word = newTopic }, Cmd.none )
--JD.list decodeWord |> JD.at [ "noun", "syn" ]
--JD.map2 Word
--    (JD.field "username" JD.string)
--    (JD.field "username" JD.string)


getSynonyms : String -> Cmd Msg
getSynonyms word =
    let
        url =
            "http://words.bighugelabs.com/api/2/apikey/" ++ (word ++ "/json")

        request =
            Http.get url decodeWordsUrl
    in
        Http.send NewSynonyms request


decodeWordsUrl : Decoder String
decodeWordsUrl =
    at [ "noun", "syn" ] string
