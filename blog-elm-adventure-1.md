# Elm adventure - vol I

So, spurred on by @krisajenkins I decided to learn how to Elm, but being a bit of a #MicroServices fan I had to make it work in Docker. Because I'm a Moron | Masochist | DevOperator...

So, first I search dockerhub, and it turns out that Evan Czaplicki obviously isn't a big #Docker fan, so I build my own Dockerfile, like [so](Dockerfile). This is basically standard stuff, so I won't elaborate much here. L2Docker, n00b! The only thing worth mentioning is the Locale stuff, which was needed to fix a previous long-standing [bug](https://github.com/elm-lang/elm-make/issues/33) in elm-make. I'm not certain that this is still required, but haven't gotton around to removing it.

The [Makefile](Makefile) is also pretty normal, and really just a shortcut to avoid typing a lot of docker commands. 

I initially started working through the copy that I have of Bruce Tate's 'Seven More Languages in Seven Weeks', but rapidly discovered that there's been a lot of change in Elm since 0.12 when the book was written (currently on 0.17.1 as I write this). 

So instead I've been working through the Elm-lang.org docs ['An introduction to Elm'](http://guide.elm-lang.org/)

## The Elm architecture - User input
### Buttons - exercise: implement reset

This seemed pretty straightforward, add a new message type:

	type Msg = Increment | Decrement | Reset

Implement the update handling of the message:

	update msg model =
	  case msg of
	    ...
	    Reset ->
	      0

And finally implement the view to include an extra button:

	view model =
	  div []
	    ...
	    , button [ onClick Reset ] [ text "reset" ] 

I thought this looked a little unbalenced, and wanted to insert a <BR/> so that the 'reset' button could be on the line below the '+' button, but simply adding a new line function called 'br' to the div array gave me a compiler error.

	Detected errors in 1 module.
	-- NAMING ERROR --------------------
	Cannot find variable `br` 
	45|     , br
		      ^^
	Maybe you want one of the following?
    Html.br
	Html.b
	Html.hr
	Html.tr

How very helpful of you Elm! This is because my import on line 1 didn't specify the `br` function explicity, like so:

	import Html exposing (Html, button, div, text, br)

Obviously, duh! Now that we've imported the line break function the compiler still errors. Grrrr!

	Detected errors in 1 module.
	-- TYPE MISMATCH -------------------------------------- 
	The 3rd and 4th elements are different types of values.
	The 3rd element has this type:     VirtualDom.Node Msg 
	But the 4th is:     List (Html.Attribute a) -> List (Html a) -> Html a 
	Hint: All elements should be the same type of value so that we can iterate through the list without running into unexpected values.

This is because the type signature of the HTML functions in the 'Html' library is `br : List (Html.Attribute a) -> List (Html.Html a) -> Html.Html a` - a function that takes two lists. If we change line 45 to:

	, br [] []
	
then it all works as expected.

In the end I decided to put all three buttons in a line below the counter, and so didn't actually need the br at all, so the view ended up just looking like:

	view model =
	  div []
	    [ div [] [ text (toString model) ]
	    , button [ onClick Decrement ] [ text "-" ]
	    , button [ onClick Increment ] [ text "+" ]
	    , button [ onClick Reset ] [ text "reset" ]
	    ]

## Forms

Initially for the first stuff I just used the 'try online' link which opens up the code in an [online repl](http://elm-lang.org/try). This worked fine, and emboldened I decided to see just what would be required to get code working on my machine using the Docker instance I'd put together. Cloning the [repo](https://github.com/evancz/elm-architecture-tutorial/) and cd-ing into the folder and then just running `make -f ../Makefile reactor` started up elm-reactor and Firefox played along quite nicely. A simple Ctrl-r and my changes were built and reflected in the browser in mere moments - Win!



### Text fields/forms - exercise: augment viewValidation

* Check that the password is longer than 8 characters.
* Make sure the password contains upper case, lower case, and numeric characters.
* Add an additional field for age and check that it is a number.
* Add a "Submit" button. Only show errors after it has been pressed.



