-- Does not work yet! Don't compile ;)


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as JD
import Json.Encode as JE


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\model -> Sub.none)
        }
type alias Word = 
    { word: String
    , synonyms: List String
    }

type alias Model =
    { word1 : Word
    , word2 : Word
    , word3 : Word
    }





init : ( Model, Cmd Msg )
init =
    ( Model {word="",synonyms=["1","2"]} {word="",synonyms=[]} {word="",synonyms=[]}
    , Cmd.none )


view : Model -> Html.Html Msg
view model =
    let 
        synonymItem : String -> Html Msg
        synonymItem s = 
            li [] [text s]

        styles = 
            [("margin", "20px")
            ,("font-family", "sans-serif")
            ]
    in
        div [style styles]
            [ h1 [] [ text "make domain names" ]
            , input [ placeholder "enter a word", onInput UpdateWord1 ] []
            
            , ul [] (List.map synonymItem model.word1.synonyms)

            --, input [ placeholder "enter a word", onInput UpdateWord2 ] []
            --, p [] [text (toString model.word2.synonyms)]
            --, input [ placeholder "enter a word", onInput UpdateWord3 ] []
            --, p [] [text (toString model.word3.synonyms)]
            ]

type Msg
    = FetchSynonyms
    | NewSynonyms (Result Http.Error String)
    | UpdateWord1 String
    | UpdateWord2 String
    | UpdateWord3 String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateWord1 s ->
            ( model, Cmd.none )

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
        apikey = 
            ""

        --TODO refactor this
        url =
            "http://words.bighugelabs.com/api/2/" ++ (apikey ++ ("/" ++ (word ++ "/json")))

        request =
            Http.get url decodeWordsUrl
    in
        Http.send NewSynonyms request


decodeWordsUrl : JD.Decoder String
decodeWordsUrl =
    JD.at [ "noun", "syn" ] JD.string
