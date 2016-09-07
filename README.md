# Zendex [![Build Status](https://travis-ci.org/shdblowers/zendex.svg?branch=master)](https://travis-ci.org/shdblowers/zendex) [![Hex pm](http://img.shields.io/hexpm/v/zendex.svg?style=flat)](https://hex.pm/packages/zendex) [![hex.pm downloads](https://img.shields.io/hexpm/dt/zendex.svg?style=flat)](https://hex.pm/packages/zendex)

An Elixir wrapper for the Zendesk API.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `zendex` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:zendex, "~> 0.1.0"}]
    end
    ```

  2. Ensure `zendex` is started before your application:

    ```elixir
    def application do
      [applications: [:zendex]]
    end
    ```

