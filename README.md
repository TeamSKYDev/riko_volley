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

