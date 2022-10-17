defmodule Pwned.EmailTest do
  @moduledoc """
  Tests that the check_email/1 function returns the correct
  tuple using the HaveIBeenPwned? API v3.

  This requires a purchased hibp-api-key. You can purchase one
  here: https://haveibeenpwned.com/API/Key.
  """
  use ExUnit.Case, async: true
  alias Pwned

  @test_pwned_email "multiple-breaches@hibp-integration-tests.com"
  @test_safe_email "not-active-breach@hibp-integration-tests.com"

  describe "verify check_email/1" do
    test "check_email returns the email pwned count when email is pwned" do
      assert {:pwned_email, pwned_count} = Pwned.check_email(@test_pwned_email)
      assert pwned_count > 0
    end

    test "check_email pwned count is an integer" do
      {:pwned_email, pwned_count} = Pwned.check_email(@test_pwned_email)

      assert is_integer(pwned_count)
    end

    test "check_email returns the :safe_email message when email is not pwned" do
      # This may fail if this test email appears in a future databreach.
      assert {:safe_email, "email not pwned"} = Pwned.check_email(@test_safe_email)
    end
  end
end
