# Changelog

This is the changelog for Pwned by Core Theory.

## 1.5.0 (2021-01-27)

## Enhancements

- Replace unsafe runtime environment call with compile time call in `api_client.ex`.
- Refactor `api_client.ex` for clarity, performance, and maintainability.

## 1.2.4 (2021-01-26)

### Enhancements

- Add `hibp-api-key` to CI to enable checking email and password tests.

## 1.2.3 (2021-01-26)

### Enhancements

- Add default for application environment `:user_agent` and ability to override in 3rd party application config files.
- Add usage explanation for setting the `:user_agent` in 3rd party applications.
- Add `@moduledoc` to `Pwned.APIClient`.

## 1.2.2 (2021-01-26)

### Enhancements

- Add `CHANGELOG.md` file.

## 1.2.1 (2021-01-26)

### Bug fixes

- Update application name to match `:pwned_coretheory`. Previous application name mismatch was causing `Pwned.check_email(email)` to return `{:error, "unauthorized api key"}` with valid key.