##Morsel

Morsel is a Sintra-like micro framework for declaring routes and handling requests.
It is built on top of [HttpServer.jl](https://github.com/hackerschool/HttpServer.jl)
and [Meddle.jl](https://github.com/hackerschool/Meddle.jl).

## Installation

Morsel is a Julia package, so just run `Pkg.add("Morsel")` in the repl.
You will also need to install Joyent's HTTP parsing library;
see [HttpParser's README](https://github.com/hackerschool/HttpParser.jl).

## Example

Here is a brief example that will return a few different messages for different routes,
if you run this and open `localhost:8000` you will see "This is the root" for GET, POST or PUT requests.
The line `get(app, "/about") do ...` is shorthand for only serving GET requests through that route.

```.jl
using Morsel

app = Morsel.app()

route(app, GET | POST | PUT, "/") do req, res
    "This is the root"
end

get(app, "/about") do req, res
    "This app is running on Morsel"
end

start(app, 8000)
```

~~~~
:::::::::::::
::         ::
:: Made at ::
::         ::
:::::::::::::
     ::
Hacker School
:::::::::::::
~~~~
