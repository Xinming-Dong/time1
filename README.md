# Time1

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

# Design Choice

User Interface:

  * Workers and managers have their own login page, and have different view once login
  * Users can go back to home page at any time
  * An error page if a worker creates a timesheet which working hour adds up to more than 8 hours.

Database:

  * Manager and Worker are wtored in different table
  * All timesheets are wtored in one table
  * All tasks are stored in one table.

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
