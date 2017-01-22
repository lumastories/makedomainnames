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
    , error : String
    }





init : ( Model, Cmd Msg )
init =
    ( Model {word="",synonyms=["1","2"]} {word="",synonyms=[]} {word="",synonyms=[]} ""
    , Cmd.none )


view : Model -> Html.Html Msg
view model =
    let 
        synonymItem : String -> Html Msg
        synonymItem s = 
            li [] [text s]

        styles : List (String, String)
        styles = 
            [("margin", "20px")
            ,("font-family", "sans-serif")
            ]
    in
        div [style styles]
            [ h1 [] [ text "make domain names" ]
            , input [ placeholder "enter a word", onInput UpdateWord1 ] []
            , ul [] (List.map synonymItem model.word1.synonyms)
            , button [onClick FetchSynonyms] [text "Load synonyms"]
            , p [] [text model.error]
            --, input [ placeholder "enter a word", onInput UpdateWord2 ] []
            --, p [] [text (toString model.word2.synonyms)]
            --, input [ placeholder "enter a word", onInput UpdateWord3 ] []
            --, p [] [text (toString model.word3.synonyms)]
            ]

type Msg
    = FetchSynonyms
    | NewSynonyms (Result Http.Error (List String))
    | UpdateWord1 String
    | UpdateWord2 String
    | UpdateWord3 String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateWord1 s ->
            ( { model | word1 = { word = s, synonyms = [] } }, Cmd.none )

        FetchSynonyms ->
            (model, getSynonyms model.word1.word)
        
        NewSynonyms (Ok newData) ->
            ({model | word1 = {word = model.word1.word, synonyms = newData} }, Cmd.none)

        NewSynonyms (Err s) ->
            ( {model | error = (toString s) }, Cmd.none )

        _ ->
            ( model, Cmd.none )


getSynonyms : String -> Cmd Msg 
getSynonyms word =
    let
        
        apikey = 
            "c39392015eab9b931d9cea42724c20f2"
        
        
        url =
            "http://words.bighugelabs.com/api/2/" ++ (apikey ++ ("/" ++ (word ++ "/json")))

        -- Http.get takes a string and a decoder 
        -- and returns a request object
        request =
            Http.get url decodeWordsUrl
    in
        Http.send NewSynonyms request


decodeWordsUrl : JD.Decoder (List String)
decodeWordsUrl =
    JD.at [ "noun", "syn" ] (JD.list JD.string)
