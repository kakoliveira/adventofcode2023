defmodule Day1 do
  @moduledoc """
  Day 1 puzzle solutions
  """

  @spec solve(binary() | list(), keyword()) :: number()
  def solve(file_path_or_list, opts \\ [])

  def solve(file_path_or_list, opts) when is_binary(file_path_or_list) do
    values = read_calibration_values(file_path_or_list)

    solve(values, opts)
  end

  def solve(values, _opts) do
    values
    |> Enum.map(&extract_number/1)
    |> Enum.sum()
  end

  defp read_calibration_values(file_path) do
    file_path
    |> FileReader.read()
    |> FileReader.clean_content()
  end

  defp extract_number(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reduce(%{first_number: nil, last_number: nil}, fn char, acc ->
      char
      |> Util.safe_to_integer()
      |> case do
        nil -> acc
        _integer -> update_acc(acc, char)
      end
    end)
    |> construct_integer()
  end

  defp update_acc(%{first_number: nil} = acc, number_char) do
    acc
    |> Map.put(:first_number, number_char)
    |> Map.put(:last_number, number_char)
  end

  defp update_acc(acc, number_char) do
    Map.put(acc, :last_number, number_char)
  end

  defp construct_integer(%{first_number: first_number, last_number: last_number}) do
    "#{first_number}#{last_number}"
    |> Util.safe_to_integer()
  end
end
