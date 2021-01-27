# Changelog

This is the changelog for Pwned by Core Theory.

## 1.2.2 (2021-01-26)

### Enhancements

- Add `CHANGELOG.md` file.

## 1.2.1 (2021-01-26)

### Bug fixes

- Update application name to match `:pwned_coretheory`. Previous application name mismatch was causing `Pwned.check_email(email)` to return `{:error, "unauthorized api key"}` with valid key.