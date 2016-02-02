## The Turing Posse Cup

For generations, students at the Turing School of Software and Design have
striven against their peers in a ceaseless battle of wits, strength, and nerves.
Its very name, whispered in the catacombs of Blake St., brings wistful looks to the
eyes of seasoned veterans, and sets the teeth of novices to chattering.
The character of the strong will be revealed, the resolve of the weak shaken, for among
the field of mighty contenders, their can only be one... __POSSE CUP CHAMPION__.

### How it works

Cup points are awarded for arbitrary reasons and in arbitrary amounts at the discretion of
Turing staff members. Points will be awarded by staff members via slack using the message
format `#PC <num points> to <posse name>`, e.g., `#PC 30 points to Pizza`. Point awards
will be tallied by the Posse Cup application, and displayed on the leaderboard.

### Current Standings

[https://possecup.herokuapp.com/](https://possecup.herokuapp.com/)

### What can you win?

Inestimable honor! Undying Glory! Exemption from posse cleaning duty! It's impossible
to truly assess the privileges accorded to the winners of the posse cup. After all, who can put a price on __victory__!?

### Feature Wishlist

* Attribution of point awards by instructor (probably based on UID -> name map in Commands::Base)
* Attribution of point awards by reason using optional "for" syntax, e.g. `30 points to Staff for exceptional brafery and good looks`. But non-attributed still needs to work
* ~~HTML "leaderboard" endpoint to allow viewing of current standings~~
* HTML "log" for viewing history of attributions by posse (maybe also global log?)
* Display list of posses via command, or in response to invalid posse name errors
* HTML UI for showing leaderboard directly from browser
* positive/negative input parsing (`30 points from Posse`) instead of `-30`

### Usage - commands

Commands are sent via slack by prefixing a message with `#pc`.

* list standings - `#pc standings` - list current standings into the channel
* point awards - awards points to a posse: `#pc <number of points> points to <posse or student>`.
e.g `#pc 10 points to Weirich` or `#pc 10 points to @dj`. Optionally takes a "for" option
to indicate what the award is for: `#pc 10 points to @dj for straight trollin`
* add student - adds a new student record to a posse. `#pc add student Horace Williams (@horace) to James Golick`

### Data Import

Import new posse members using:

`rake posses:import`

(Requires `SLACK_ADMIN_TOKEN` ENV variable to be set with a valid slack api token).
