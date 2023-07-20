## gem の追加、インストール等

```sh
docker-compose run --rm app bundle install
docker-compose run --rm app yarn install
docker-compose run --rm app ./bin/rails webpacker:compile
```
