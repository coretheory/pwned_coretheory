<img src="assets/static/images/CT_Logo_Color.png" width="100" height="100">

# Pwned by Core Theory

[![Hex.pm](https://img.shields.io/hexpm/v/pwned.svg)](https://hex.pm/packages/pwned_coretheory)
[![Docs](https://img.shields.io/badge/hex-docs-green.svg)](https://hexdocs.pm/pwned_coretheory/readme.html)

A simple application to check if an email or password has been pwned using the HaveIbeenPwned? API v3.

### Emails

This library currently implements simple email checking against data breaches with the HaveIBeenPwned? API v3. It requires a [purchased api-key](https://haveibeenpwned.com/API/Key) in order to work.

The `Pwned.check_email/1` function returns the total number of times an email address has appeared in known data breaches, or an `"email not pwned"` message.

### Passwords

This library uses [HaveIBeenPwned?](https://haveibeenpwned.com) to verify if a password has appeared in a data breach. 

In order to protect the value of the source password being searched, the value is not sent through the network. Instead it uses a [k-Anonymity](https://en.wikipedia.org/wiki/K-anonymity) model that allows a [password to be searched for by partial hash](https://haveibeenpwned.com/API/v2#SearchingPwnedPasswordsByRange). This allows the first 5 characters of a SHA-1 password hash to be passed to the API. Then, it searches the results of the response for the presence of the source hash. If the source hash is not found, then the password does not exist in the data set.

Additionally, we implement padding to further protect the privacy of the password source hash in accordance with [password padding](https://haveibeenpwned.com/API/v3#PwnedPasswordsPadding) in API v3.

## Table of Contents

-   [Install](#install)
-   [Usage](#usage)
-   [Contributing](#contributing)
-   [License](#license)
-   [Notice](#notice)
-   [Special Thanks](#special_thanks)

## Install

This package can be installed by adding `ct_pwned` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pwned_coretheory, "~> 1.0.2"}
  ]
end
```

## Usage

Usage is incredible simple and straightforward. You can check if an
email or password has been pwned with calls to their respective
functions.

In the case of checking for an email, you will need to have purchased
a [hibp-api-key](https://haveibeenpwned.com/API/Key).

You can use this library for password checking without the need for an
API key. However, if this is the case, then keep in mind that not all
tests will pass. If you do not need email checking, then we encourage
you to use the [pwned](https://github.com/thiamsantos/pwned) library
by [Thiago Santos](https://github.com/thiamsantos).

### Check for pwned passwords

To check whether a password has been pwned you can make a simple call to the `Pwned.check_password/1` function:

```elixir
iex> Pwned.check_password("P@ssw0rd")
      {:ok, 47205}

iex> Pwned.check_password("Z76okiy2X1m5PFud8iPUQGqusShCJhg")
      {:ok, false}
```

When implementing in an application, we can use a straightforward `case` statement like this:

```elixir
case Pwned.check_password("somepassword") do
  {:ok, false} ->
    IO.puts("Good news — no pwnage found!")

  {:ok, count} ->
    IO.puts("Oh, no! This password appeared #{count} times in data breaches.")

  :error ->
    IO.puts("Something went wrong.")
end
```

### Check for pwned emails

To check whether an email has been pwned you can make a simple call to the `Pwned.check_email/1` function:

```elixir
iex> Pwned.check_email("test123@example.com")
    {:pwned_email, 4893554722}

iex> Pwned.check_email("Z76okiy2X1m5PFud8iPUQGqusShCJhg@example.com")
    {:safe_email, "email not pwned"}
```

When implementing in an application, we can use a straightforward `case` statement like this:

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

## Notice

This is a modified version of the [pwned](https://github.com/thiamsantos/pwned) package © [@thiamsantos](https://github.com/thiamsantos).

## Special thanks

This extension was built from the simple and wonderful package, [pwned](https://github.com/thiamsantos/pwned), by [Thiago Santos](https://github.com/thiamsantos). ♥
