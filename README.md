# Rails ERD Viewer

Rails ERD Viewer automatically generates Entity-Relationship Diagrams from your ActiveRecord and displays them
using [erd-editor](https://github.com/dineug/erd-editor).

---

### Install

Add this to the development group in your `Gemfile`:

```ruby
group :development do
  gem 'rails_erd_viewer', '~> 0.1.0'
end
```

---

### Usage

Run `rails erd:generate`.

Then visit `/erd-viewer`


---

### Automatic ERD Generation

The ERD generation will happen automatically in the following situations:

- **After running migrations**: Every time you execute `rails db:migrate`, `rails db:reset`, or `rails db:redo`, the ERD diagram will be automatically generated, reflecting changes in the database.
- **After a rollback**: Whenever you run `rails db:rollback`, the ERD diagram will be regenerated to reflect the current state of the database.

This ensures that the ERD diagram is always up-to-date, reflecting changes in the database structure without the need for additional commands.

---

### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wptussolini/rails_erd_viewer.
