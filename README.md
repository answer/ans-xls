# Ans::Xls

xls mime type を追加、 xml spreadsheet を出力する layout と helper を提供

## Installation

Add this line to your application's Gemfile:

    gem 'ans-xls'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ans-xls

## Usage

    # config/initializers/ans-xls.rb
    Ans::Xls.configure do |config|
      config.author = "Default Author"
    end

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Ans::Xls::Helper
    end

    # app/controllers/items_controller.rb
    def index
      respond_to do |format|
        format.html
        format.xls{render layout: "ans/xls/application"}
      end
    end

    # app/views/items/index.xls.erb
    <%= content_for :filename do %>ファイル名<% end %>
    <%-
    columns = [
      [:id,   type: "Number", width: 70, header: "ID"],
      [:name, type: "String", width: 80, header: "名前"],
    ]
    -%>
    <Worksheet ss:Name="シート名">
      <Table ss:ExpandedColumnCount="<%= columns.size %>" ss:ExpandedRowCount="<%= @items_search.count+1 %>">
        <% columns.each do |column,style,width| %>
          <%= xls_column style[:type], width: style[:width] %>
        <% end %>
        <Row ss:AutoFitHeight="0">
          <% columns.each do |column,style| %>
            <Cell><%= xls_data "String", style[:header] %></Cell>
          <% end %>
        </Row>
        <% @items_search.each do |item| %>
          <Row ss:AutoFitHeight="1">
            <% columns.each do |column,style| %>
              <Cell><%= xls_data style[:type], item.send(column) %></Cell>
            <% end %>
          </Row>
        <% end %>
      </Table>
    </Worksheet>

### ヘルパー

* xls_column(スタイル, width: 幅)  
  Column タグを出力する  
  `"s#{スタイル}"` の Style が使用される(定義済スタイルは下記)  
  `width` を指定するとカラムの幅が指定される
* xls_data(スタイル, コンテンツ)  
  Data タグを出力する  
  `"#{スタイル}"` の Type が指定される  
  xls_column に渡すハッシュをそのまま使用可能なように、 Text は String に変換して指定する

### content_for

* filename: ファイル名を指定  
  日本語を、全てのブラウザで文字化けさせない方法はない  
  使用されるブラウザを指定できない場合、アルファベットのみにするほうが無難
* author: 指定すると、 initializer で設定したデフォルトの author を上書きする
* style: 追加の Style タグを記述可能

### 定義済 Style

* sText: テキストエリア用スタイル
* sNumber: 数値用スタイル
* sString: 文字列用スタイル

それぞれ `s` が prefix されているが、 `xls_column`, `xls_data` では、 `s` を取り除いた部分の名前を指定する  
カスタムスタイルを定義する場合、 `s` を接頭辞として付けないと `xls_column`, `xls_data` で使用できないので注意

* なぜか？ → xml spreadsheet 形式で保存した際、スタイルの先頭に `s` がついていたから
* 単に Text とかだとエラーになった、ような気がする(だけかもしれないが)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
