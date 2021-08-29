# URL shorter

Yet another URL-shorter service like bit.ly, etc.

## Setup and run
Change db-connection settings:
```bash
cp .env.development.sample .env.development
cp .env.test.sample .env.test

rails db:create && rails db:migrate
rails s
```

Run tests:
```
rspec spec
```

## Usage

Get short-link:
```json
curl -H "Content-Type: application/json" -X POST \
  -d '{"url":"https://api.rubyonrails.org/"}' \
  http://localhost:3000/urls

{"data":{"short_url":"http://localhost:3000/urls/YPkoxZg"}}
```

Redirect by short-link (try in browser or via shell):
```json
curl -i http://localhost:3000/urls/YPkoxZg

HTTP/1.1 302 Found
Location: https://api.rubyonrails.org/
...
```

Get stats:
```json
curl http://localhost:3000/urls/YPkoxZg/stats

{"data":{"count_uniq_redirections":1}}
```
