# Putting an Elm in your Phoenixes

Alan gave [a talk at ElixirConf 2015](http://confreaks.tv/videos/elixirconf2015-phoenix-with-elm) on combining the [Phoenix web framework](http://www.phoenixframework.org/) with the [Elm programming language](http://elm-lang.org). This repo is the result of going through the related tutorials on [cultivatehq.com](http://cultivatehq.com/posts).

## Tutorials

Each of the steps below has an associated commit (unless noted) so that you can just look at the diffs if you rather not read through each of the steps.

See below for gotchas.

[1. Setup](http://www.cultivatehq.com/posts/phoenix-elm-1)

[2. Getting Elm and Phoenix to play together](http://www.cultivatehq.com/posts/phoenix-elm-2)

[3. Adding a simple View](http://www.cultivatehq.com/posts/phoenix-elm-3)

[4. Adding a Model and enhancing the View](http://www.cultivatehq.com/posts/phoenix-elm-4)

[5. Type annotations](http://www.cultivatehq.com/posts/phoenix-elm-5)

[6. Adding an Update](http://www.cultivatehq.com/posts/phoenix-elm-6)

[7. Signals](http://www.cultivatehq.com/posts/phoenix-elm-7) (No related commit)

[8. Introducing Effects](http://www.cultivatehq.com/posts/phoenix-elm-8)

[9. Fetching seats with an HTTP request](http://www.cultivatehq.com/posts/phoenix-elm-9) (on a separate branch `http`)

[10. Upgrading to Elm 0.16.0](http://www.cultivatehq.com/posts/phoenix-elm-10) (No related commit. You can skip this step if you're already on Elm 0.16.0 or greater.)

[11. Introducing Phoenix channels](http://www.cultivatehq.com/posts/phoenix-elm-11)

[12. Upgrade to Elixir 1.2 and Phoenix 1.1.3](http://www.cultivatehq.com/posts/phoenix-elm-12) (No related commit. You can skip this step if you're already on Elixir 1.2.3 and Phoenix 1.1.4 or greater.)

[13. Booking a seat](http://www.cultivatehq.com/posts/phoenix-elm-13)


## Running the app without going through the tutorials

Maybe you'd like to just clone this repo and see it in action without going through the tutorials. In that case, check out the [Setup post](http://www.cultivatehq.com/posts/phoenix-elm-1) to install the requirements and then do the following:

```shell
git clone git@github.com:cultivatehq/seat_saver.git
cd seat_saver
mix deps.get
npm install

# if running on Windows you should ensure that psql is on the PATH
# before trying these commands (see the Setup post mentioned above)
# also remember to use \ instead of / in file paths
mix ecto.create && mix ecto.migrate && mix run priv/repo/seeds.exs

# if running on Windows you will also need to ...
npm install -g elm
cd web/elm
elm package install -y
cd ../..

# once everything is setup, start a local server with
iex -S mix phoenix.server
```


### Gotchas

##### [Windows] Uncaught ReferenceError: Elm is not defined (submitted by @ramstein74)

Have a look at [this issue](https://github.com/CultivateHQ/seat_saver/issues/9).

TL;DR - in your *brunch-config.json* file change any file paths in the `elmBrunch` plugin config to use `\/` instead of `/` as path separators.

##### Help! My Elm file won't stop compiling! (Hat tip to @scrogson)

If you put your *elm* folder in the *web/static* folder it can cause a cascade compile when you run the Phoenix server (i.e. the first compile will trigger another compile, which will trigger another compile etc.). This is because the *web/static* folder is watched by Brunch by default (although you can change this if you want to). Sticking to using the *web* folder (i.e. *web/elm*) as we do in the tutorial for an easy life. See [part 2](http://www.cultivatehq.com/posts/phoenix-elm-2) for more info.

##### OSX El-Captian Phoenix 0.17 upgrade to 1.0.3 Postgres-ecto-create issue (submitted by @yeongsheng-tan)
Thought this might be useful for people following the tutorial attempting to get Phoenix 1.0.3 Postgresql 9.x up and running on OSX El-Captian hitting postgres-ecto-create permission related warnings/errors when upgrading from an existing Phoenix 0.17 install.

http://blog.jasonkim.ca/blog/2015/09/01/setting-up-phoenix-1-dot-0-on-mac-os-x-yosemite/

e.g.
* (Mix) The database for SeatSaver.Repo couldn't be created, reason given: psql: FATAL:  role "postgres" does not exist
* (Mix) The database for SeatSaver.Repo couldn't be created, reason given: psql: FATAL:  role "postgres" is not permitted to log in

##### 'permission denied' when attempting to install elm core packages on El Capitan (submitted by @yeongsheng-tan)

@yeongsheng-tan was getting a 'permission denied' issue when attempting to install elm core packages in [embedding elm into phoenix steps](https://github.com/CultivateHQ/seat_saver/wiki/2.-Adding-Elm#embedding-elm-into-phoenix)
```shell
elm package install -y
elm-package: /usr/bin/git: fileAccess: permission denied (Operation not permitted)
```
Solution is provided [here](https://github.com/elm-lang/elm-package/issues/109)

* Updated OSX El-Capitan [Elm installer required](http://install.elm-lang.org/Elm-Platform-0.15.1-el-capitan.pkg)


## Feedback

Any feedback, questions, complaints, bribes etc. are appreciated (well the first two anyway). Please submit as [issues](https://github.com/CultivateHQ/seat_saver/issues).
