// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery3
//= require popper
//= require bootstrap-sprockets

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

// viewでjquery
window.$ = jQuery;

