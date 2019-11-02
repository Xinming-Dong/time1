use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :time1, Time1Web.Endpoint,
  secret_key_base: "mLR/G0bzq2JrynBac6VWK/G8pIEsubzUBGA2u83zzKExyWb/P75ftFIW1SDcvF5/"

# Configure your database
config :time1, Time1.Repo,
  username: "postgres",
  password: "postgres",
  database: "time1_prod",
  pool_size: 15

  config :time1, Time1Web.Endpoint, server: true
