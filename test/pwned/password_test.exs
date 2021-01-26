defmodule Pwned.PasswordTest do
  use ExUnit.Case, async: true
  alias Pwned

  describe "verify check_password/1 returns an {:ok, count} tuple" do
    test "check_password returns the password pwned count" do
      assert {:ok, _} = Pwned.check_password("P@ssw0rd")
    end

    test "check_password pwned count is an integer" do
      {:ok, count} = Pwned.check_password("P@ssw0rd")

      assert is_integer(count)
    end
  end
end
