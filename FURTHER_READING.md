# Further Reading

Additional notes on working with this package and the HaveIBeenPwned? API.

## Rate Limiting

The HaveIBeenPwned? API v3 features rate limiting per Troy Hunt's [explanation](https://haveibeenpwned.com/API/v3#RateLimiting). The service is rate limited at `1500 milliseconds`, meaning that any purchased `hibp-api-key` may make one request per 1500 milliseconds.

For this reason, it is best to set a `:debounce` option on your request with at least `100 milliseconds` added to the base rate limit. In a Phoenix application using Live View, with `200 milliseconds` added to the base rate, this might look like:

```elixir
#In your application's file.html.leex
<%= f = form_for @changeset, "#", [phx_change: :validate, phx_submit: :save] %>
  <%= email_input f, :email, phx_debounce: "1700", required: true %>
</form>
```

## Additional resources

We recommend reading through the [HaveIBeenPwned?](https://haveibeenpwned.com/API/v3) API documentation if you are curious to learn more.