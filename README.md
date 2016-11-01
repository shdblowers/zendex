# Zendex
[![Build Status](https://travis-ci.org/shdblowers/zendex.svg?branch=master)](https://travis-ci.org/shdblowers/zendex)
[![Coverage Status](https://coveralls.io/repos/github/shdblowers/zendex/badge.svg?branch=master)](https://coveralls.io/github/shdblowers/zendex?branch=master)
[![Hex.pm version](http://img.shields.io/hexpm/v/zendex.svg?style=flat)](https://hex.pm/packages/zendex)
[![Hex.pm downloads](https://img.shields.io/hexpm/dt/zendex.svg?style=flat)](https://hex.pm/packages/zendex)
[![Hex.pm license](https://img.shields.io/hexpm/l/zendex.svg?style=flat)](https://github.com/shdblowers/zendex/blob/master/LICENSE)
[![Libraries.io dependencies](https://img.shields.io/librariesio/release/hex/zendex.svg?style=flat)](https://libraries.io/hex/zendex)

An Elixir wrapper for the Zendesk API.

## Installation

  1. Add `zendex` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:zendex, "~> 0.7.0"}]
    end
    ```

  2. Ensure `zendex` is started before your application:

    ```elixir
    def application do
      [applications: [:zendex]]
    end
    ```

## Usage

  1. Setup a `Zendex.Connection` map, that will store your Zendesk details. It requires the URL of your Zendesk instance, your username and your password.

  ```elixir
  iex> conn = Zendex.Connection.setup("http://test.zendesk.com", "User1", "pass")
  %{authentication: "VXNlcjE6cGFzcw==", base_url: "http://test.zendesk.com"}
  ```

  2. Make use of the other modules to do various actions on your Zendesk. Example of showing a user:

  ```elixir
  iex> Zendex.User.show(conn, 1)
  %{"user": %{"id": 87, "name": "Quim Stroud", ...}}
  ```

  3. Using pipes:

  ```elixir
  "http://test.zendesk.com"
  |> Zendex.Connection.setup("Username1", "password123")
  |> Zendex.User.show(101)
  ```

## Completeness and Contributions

This package far from complete in terms of utilising all of the Zendesk API, any contributions will be welcome. Please keep the code consistent with what I have already written here.
