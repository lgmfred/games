# Games

My junky solution to the [DockYard Academy](https://github.com/DockYard-Academy/curriculum) Games project.

It includes a Games Escript with a Guessing Game, Rock Paper Scissors, and Wordle.

## Getting Started

Install Elixir by following the [Elixir Installation Guide](https://elixir-lang.org/install.html).

Clone the repository.

```
$ git clone https://github.com/lgmfred/games.git
```

Install dependencies.

```
$ mix deps.get
```

Run tests and ensure they all pass.

```shell
$ mix test
```
Generate docs (if you like).

```shell
$ mix docs
```

Then you can either start the project in the IEx shell.

```shell
$ iex -S mix
iex> Games.Menu.display()
```

Or build the project as an escript executable.

```shell
$ mix escript.build
$ ./games
```

## Concepts learned

- Basic Elixir syntax
- Elixir Build Tooling(Mix)
- Testing and TDD (ExUnit With Mix Projects)
- Documentation and Static Analysis (Doctests, Typespecs, ExDoc and Credo)
- Executables