defmodule Bowling do
  defstruct frame: 1, throw_in_frame: 0, frames: %{}, frame_bonuses: %{}, last_roll: 0, ended: false

  @doc """
  Creates a new game of bowling that can be used to store the results of
  the game
  """

  @spec start() :: any
  def start, do: %Bowling{}

  @doc """
  Records the number of pins knocked down on a single roll. Returns `:ok`
  unless there is something wrong with the given number of pins, in which
  case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t
  def roll({ :error, _ } = error), do: error
  def roll(_, roll) when not roll in 0..10, do: { :error, "Pins must have a value from 0 to 10" }
  def roll(%Bowling{throw_in_frame: 0} = game, 10) do
    %Bowling{ game |
      frame: game.frame + 1,
      frames: game.frames |> apply_frame_bonuses(game.frame_bonuses, 10) |> Map.put(game.frame, 10),
      frame_bonuses: game.frame_bonuses |> decrement_bonuses |> Map.put(game.frame, 2),
      last_roll: 0
    }
  end

  def roll(%Bowling{throw_in_frame: 0} = game, roll) do
    %Bowling{ game |
      throw_in_frame: 1,
      last_roll: roll,
      frames: game.frames |> apply_frame_bonuses(game.frame_bonuses, roll) |> Map.put(game.frame, roll),
      frame_bonuses: game.frame_bonuses |> decrement_bonuses
    }
  end

  def roll(%Bowling{ throw_in_frame: 1, last_roll: last_roll }, roll) when roll + last_roll > 10, do: { :error, "Pin count exceeds pins on the lane" }
  def roll(%Bowling{ throw_in_frame: 1, last_roll: last_roll } = game, roll) when roll + last_roll == 10 do
    %Bowling{ game |
      throw_in_frame: 0,
      frame: game.frame + 1,
      frames: game.frames |> apply_frame_bonuses(game.frame_bonuses, roll) |> Map.put(game.frame, 10),
      frame_bonuses: game.frame_bonuses |> decrement_bonuses |> Map.put(game.frame, 1),
      last_roll: 0
    }
  end
  def roll(%Bowling{ throw_in_frame: 1, last_roll: last_roll } = game, roll) do
    %Bowling{ game |
      throw_in_frame: 0,
      frame: game.frame + 1,
      frames: game.frames |> apply_frame_bonuses(game.frame_bonuses, roll) |> Map.update(game.frame, roll + last_roll, &(&1 + roll)),
      frame_bonuses: game.frame_bonuses |> decrement_bonuses,
      last_roll: 0
    }
  end

  @doc """
  Returns the score of a given game of bowling if the game is complete.
  If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t
  def score(%Bowling{ frames: frames }) do
    do_score(frames |> Enum.filter(fn {frame, _score} -> frame <= 10 end) |> Enum.map(&(elem(&1, 1))))
  end

  defp do_score(frame_scores) when length(frame_scores) < 10, do: { :error, "Score cannot be taken until the end of the game" }
  defp do_score(frame_scores), do: frame_scores |> Enum.sum

  defp apply_frame_bonuses(frames, bonuses, roll) do
    bonuses
    |> Map.keys
    |> Enum.reduce(frames, fn(key, acc) -> Map.update(acc, key, roll, &(&1 + roll)) end)
  end

  defp decrement_bonuses(bonuses) do
    bonuses
    |> Map.keys
    |> Enum.reduce(bonuses, fn(key, acc) -> Map.update(acc, key, 0, &(&1 - 1)) end)
    |> Enum.filter(fn {_, v} -> v > 0 end)
    |> Enum.into(%{})
  end
end
