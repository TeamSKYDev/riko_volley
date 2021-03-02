# README

## Rubocop airbnb 使用方法(Ruby3.0非対応)
- gemの導入
- .rubocop.yml, .rubocop_airbnb.ymlの作成
- 違反箇所の確認
  - 自動修正を行う場合には最後に ```-a``` のオプション付与
  - 解析対象フォルダ・ファイルを設定したい場合には末尾にパス入力
  - origin/developと差分があるファイルに対して実行したい場合には、末尾に ```$(git diff $(git merge-base origin/master HEAD) --diff-filter=d --name-only)``` を記入
```
bundle exec rubocop --require rubocop-airbnb
```

## cronを使ったバッヂ処理(docker非対応)
- gemのインストール
```
gem 'whenever', require: false
bundle install
```
- config/schedule.rbの作成
```
bundle exec wheneverize
```
- config/schedule.rbの編集
  - 定期的に行いたい処理が書かれているファイルの指定
  - 実行間隔　　　　　　　　　　　　　　　　　　　　など
- crontabへの反映
```
bundle exec whenever --update-crontab
```
- crontabへの反映確認
```
crontab -l
```

## heroku schedulerを使ったバッヂ処理
[参考](https://qiita.com/isotai/items/44735d9e7d9ceaef9c48)


