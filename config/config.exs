use Mix.Config

config :zendex, :http_client, HTTPoison

import_config "#{Mix.env}.exs"
