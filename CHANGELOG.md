# Changelog

This is the changelog for Pwned by Core Theory.

## 1.5.3 (2022-10-17)

### Fixes

- Add proper Have I Been Pwned? test emails per their API documentation.
- Switch `@hibp_api_key` to come from the application config and default to the environment variable. This is to support setting the application configuration at runtime for production environments.

## 1.5.2 (2021-01-30)

### Enhancements

- Add clearer test coverage for both `master` and `staging` branches to `README.md`.
- Refactor GitHub Actions workflow.
- Improve function docs clarity for `EmailFlattener.flatten/1` and `EmailReducer.reduce_email_list/1`.
- Add a security policy.

## 1.5.1 (2021-01-27)

### Enhancements

- Format changelog.
- Add further reading section with notes on rate limiting and additional resources.

## 1.5.0 (2021-01-27)

### Enhancements

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