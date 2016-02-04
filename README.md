# CommandButler

It is a gem that will continue to run the command that was written to a file interactively

## Installation

Gemfileに以下を追加

```
    gem 'command_butler'
```
gemのインストール

```
$ bundle install
```

もしくは直接インストールする。

```
$ gem install command_butler
```

## Usage 
コマンドを記述したymlファイルを、executeの引数として渡し実行します。
### コマンド実行のみ
```
$ command_butler execute sample/simple_commands.yml
```

![Alt Text](https://raw.githubusercontent.com/motsat/command_butler/master/images/command_butler_simple.gif)

### コマンド実行の戻り値で、実行コマンドの置換を行う時
    $ command_butler execute sample/set_val.yml

![Alt Text](https://raw.githubusercontent.com/motsat/command_butler/master/images/command_butler_set_val.gif)

### 設定ファイルで実行コマンドの置換を行う時

    $ command_butler execute sample/replace_with_valfile.yml 
    $                           --val_file=sample/val_file/station.yml

![Alt Text](https://raw.githubusercontent.com/motsat/command_butler/master/images/command_butler_replace_val.gif)

## 設定ファイル
format  : yaml

YAMLファイルに、下記のように配列形式で記述します。

    [yml]
      - pwd
      - echo 'Hellow World'
      - ls -al

注）cdコマンドについては下記の方法で記述します。

    [yml]
      - pwd
      -
        chdir: /Users
      - pwd

コマンドの出力結果で後のコマンドで置換するには、set_valコマンドを使います。
    [yml]

      -
       command: date
       set_val: $DATE_VALUE
      - echo $DATE_VALUE


## Contributing

1. Fork it ( https://github.com/motsat/command_butler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
