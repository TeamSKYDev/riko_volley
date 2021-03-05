// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap';
import '../stylesheets/application';
import toastr from 'toastr';
window.toastr = toastr;

require('jquery')
import "cocoon";

// viewでjquery
window.$ = jQuery;

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// 並び替え用
require("jquery-ui/ui/widget")
require("jquery-ui/ui/widgets/sortable")

$(document).on("turbolinks:load", () => {
  $("#places").sortable({
    handle: '.handle',
    update: function(e, ui) {
      Rails.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      });
    }
  });
})



window.Cookies = require("js-cookie")

$(document).on('turbolinks:load', function() {
  $(function() {
    if(Cookies.get("openTag")){
    //一旦すべての active を外す
    $('a[data-toggle="tab"]').parent().removeClass('active');
    $('a[href="#' + Cookies.get("openTag") +'"]').click();
    }

    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
    var tabName = e.target.href;
    var items = tabName.split("#");
    //クッキーに選択されたタブを記憶
    Cookies.set("openTag",items[1], { expires: 700 });
    });
  });
});
