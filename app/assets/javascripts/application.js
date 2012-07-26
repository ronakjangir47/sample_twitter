// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


$(document).ready(function(){
  $(".microposts li a.tweet_opr").click(function() {
     target_id = this.id.split('_');
     $('#retweet_micropost_id').val(target_id[1])
     $('#'+target_id[0]+'_form #micropost_content').html($('.microposts li#'+target_id[1]+' span.content').html())
     $('#'+target_id[0]+'_form').css('display','block') ;
     return false
  });
  $("#retweet_cancel").click(function(){
    //alert('#'+this.id.split('_')[0]+'_form')
    $('#retweet_form').css('display','none');
  })
});

