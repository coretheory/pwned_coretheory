<img src="assets/static/images/CT_Logo_Color.png" width="100" height="100">

> This is a fork and modified version of [@thiamsantos](https://github.com/thiamsantos) [pwned](https://github.com/thiamsantos/pwned) library.

## Update for email checking
Added functionality to check people's emails against known breaches from [haveibeenpwned](https://haveibeenpwned.com) and to include support for API V3.

_To use the email checking feature, you will need to purchase an API Key from HaveIbeenPwned._
***

# Pwned

[![Travis](https://img.shields.io/travis/thiamsantos/pwned.svg)](https://travis-ci.org/thiamsantos/pwned)
[![Hex.pm](https://img.shields.io/hexpm/v/pwned.svg)](https://hex.pm/packages/pwned)
[![Docs](https://img.shields.io/badge/hex-docs-green.svg)](https://hexdocs.pm/pwned)

> Check if your password has been pwned

It uses [have i been pwned?](https://haveibeenpwned.com) to verify if a password has appeared in a data breach. In order to protect the value of the source password being searched the value is not sended through the network. Instead it uses a [k-Anonymity](https://en.wikipedia.org/wiki/K-anonymity) model that allows a [password to be searched for by partial hash](https://haveibeenpwned.com/API/v2#SearchingPwnedPasswordsByRange). This allows the first 5 characters of a SHA-1 password hash to be passed to the API. Then search the results of the response for the presence of their source hash and if not found, the password does not exist in the data set.

## Table of Contents

-   [Install](#install)
-   [Usage](#usage)
-   [Contributing](#contributing)
-   [License](#license)

## Install

The package can be installed by adding `pwned` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ct_pwned, github: "coretheory/ct_pwned"}
  ]
end
```

## Usage

```elixir
case Pwned.check_password("somepassword") do
  {:ok, false} ->
    IO.puts("Good news — no pwnage found! This password wasn't found in any of the Pwned Passwords loaded into Have I been pwned.")

  {:ok, count} ->
    IO.puts("Ohh, sorry! This password has appeared #{count} time on data breaches.")

  :error ->
    IO.puts("Something went wrong.")
end
```

```elixir
case Pwned.check_email("test123@exmaple.com") do
  {:safe_email, message} ->
    IO.puts(message)

  {:pwned_email, pwned_count} ->
    IO.puts("Ohh, sorry! This email has appeared #{pwned_count} times in data breaches.")

  {:error, message} ->
    IO.puts("An error occurred: " <> message)
  
  :error ->
    IO.puts("Something went wrong.")
end
```

## Contributing

See the [contributing file](CONTRIBUTING.md).

## License

[Apache License, Version 2.0](LICENSE.md) © [Core Theory](https://github.com/coretheory)

## Special thanks

This extension was built from the simple and wonderful library, [pwned](https://github.com/thiamsantos/pwned), by [Thiago Santos](https://github.com/thiamsantos).
