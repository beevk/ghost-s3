# Ghost S3 Storage Adapter

This image contains Ghost:6.10 with S3 as storage adapter and Cloudfront as CDN. It also supports other S3 compatible storages. Read more [here](https://github.com/laosb/ghos3).

### To configure S3 and Cloudfront, you need to pass following environment variables:
```yaml
  storage__active: s3
  storage__s3__accessKeyId: <AWS IAM User>
  storage__s3__secretAccessKey: <IAM Secret Key>
  storage__s3__region: <S3 region>
  storage__s3__bucket: <S3 bucket name>
  storage__s3__assetHost: <Cloudfront URL> # https://<Cloudfront URL>
  storage__s3__pathPrefix: images # Optional, Set this if you want all images to be stored in a subfolder
  storage__s3__forcePathStyle: true
  storage__s3__acl: private
```

Need help setting up IAM user, S3 bucket and Cloudfront? See [this guide for S3](https://youtu.be/eQAIojcArRY?si=zfGmxBu7J18vcijD&t=529) and [this for Cloudfront](https://youtu.be/kbI7kRWAU-w?si=hAtwkz-lZNF-Volz&t=129)


### To configure Cloudflare R2, you need to pass following environment variables:
```yaml
  storage__active: s3
  storage__media__adapter: s3
  storage__files__adapter: s3
  storage__s3__accessKeyId: <R2 Access ID>
  storage__s3__secretAccessKey: <R2 Access Key>
  storage__s3__region: auto
  storage__s3__bucket: <bucket name>
  storage__s3__assetHost: <R2 custom URL> # https://<URL>
  storage__s3__pathPrefix: images # Optional, Set this if you want all images to be stored in a subfolder
  storage__s3__endpoint: https://xxx.r2.cloudflarestorage.com
  storage__s3__forcePathStyle: true
  storage__s3__acl: ""
```


## How to Use?
This will start a Ghost development instance listening on the default Ghost port of 2368.

```shell
docker run -d --name ghost-app -e NODE_ENV=development beevk/ghost-s3:latest
```

### To start using docker compose:

```yaml
version: '3.1'

services:

  ghost:
    image: beevk/ghost-s3:latest
    restart: always
    ports:
      - 80:2368
    environment:
      # see https://ghost.org/docs/config/#configuration-options
      database__client: mysql
      database__connection__host: db
      database__connection__user: userOne
      database__connection__password: secretPassword
      database__connection__database: ghost
      # this url value is just an example, and is likely wrong for your environment!
      url: http://example.com
      # This image defaults to NODE_ENV=production (so development mode needs to be explicitly specified if desired)
      # NODE_ENV: development
      storage__active: s3
      storage__s3__accessKeyId: <AWS IAM User>
      storage__s3__secretAccessKey: <IAM Secret Key>
      storage__s3__region: <S3 region>
      storage__s3__bucket: <S3 bucket name>
      storage__s3__assetHost: <Cloudfront URL> # https://<Cloudfront URL>
      storage__s3__pathPrefix: images # Optional, Set this if you want all images to be stored in a subfolder
      storage__s3__forcePathStyle: true
      storage__s3__acl: private
    volumes:
      - ghost:/var/lib/ghost/content

  db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_DATABASE: ghost
      MYSQL_USER: userOne
      MYSQL_PASSWORD: secretPassword
      MYSQL_ROOT_PASSWORD: anotherSecretPassword
    volumes:
      - db:/var/lib/mysql

volumes:
  ghost:
  db:
```
