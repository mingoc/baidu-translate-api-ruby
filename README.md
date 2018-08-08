# Baidu translate api client for Ruby

- https://api.fanyi.baidu.com/api/trans/product/apidoc
- http://api.fanyi.baidu.com/api/trans/product/prodinfo

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'baidu-translate-api'
```

## Usage

```
appid = '2018nnnnnn'
secret_key = 'foobarbaz'

bta = BaiduTranslateApi.new(appid: appid, secret_key: secret_key)
puts bta.translate("hello\nWhere are you from?")
puts '---'
puts bta.translate("こんにちは\nあなたはどこから来ましたか?")
puts '---'
puts bta.translate("早上好", from: :zh, to: :jp)
```

```
你好
你从哪里来的？
---
你好
你从哪里来的？
---
おはよう
```
