# makedomainnames
makedomainnames.com

 - add words 
 - get synonyms for each word 
 - shuffle the words together
 - display a list of domain names
 - check availability
 - `domain_names_count_average = words_count * (15 * words_count)`

TODO
 - [x] find thesaurus api
 - [ ] find domain name availability api
 - [ ] draw the user interface
 - [ ] design the application in Elm
 - [ ] how to move view forward in elm? (button adds new input)
 - [ ] how to parse the json?

JSON to parse:

http://words.bighugelabs.com/apisample.php?v=2&format=json

```
{
  "noun": {
    "syn": [
      "passion",
      "beloved",
      "dear",
      "dearest",
      "honey",
      "sexual love",
      "erotic love",
      "lovemaking",
      "making love",
      "love life",
      "concupiscence",
      "emotion",
      "eros",
      "loved one",
      "lover",
      "object",
      "physical attraction",
      "score",
      "sex",
      "sex activity",
      "sexual activity",
      "sexual desire",
      "sexual practice"
    ],
    "ant": [
      "hate"
    ],
    "usr": [
      "amour"
    ]
  },
  "verb": {
    "syn": [
      "love",
      "enjoy",
      "roll in the hay",
      "make out",
      "make love",
      "sleep with",
      "get laid",
      "have sex",
      "know",
      "do it",
      "be intimate",
      "have intercourse",
      "have it away",
      "have it off",
      "screw",
      "jazz",
      "eff",
      "hump",
      "lie with",
      "bed",
      "have a go at it",
      "bang",
      "get it on",
      "bonk",
      "copulate",
      "couple",
      "like",
      "mate",
      "pair"
    ],
    "ant": [
      "hate"
    ]
  }
}
```
