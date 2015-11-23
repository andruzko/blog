var Post = {
  init: function(){
    this.add_rate();
    this.unrate();
  },
  add_rate: function(){
    $('.add_rate').on('click', function(){
      var tthis = $(this);
      $.ajax({
        url: "post/rates",
        method: 'POST', 
        data: {id: tthis.parents('tr').attr('post_id'), value: 1},
      }).done(function(result) {
        tthis.next().html(result.data);
      });
      return false;
    });
  },
  unrate: function(){
    $('.unrate').on('click', function(){
      var tthis = $(this);
      $.ajax({
        url: "post/rates",
        method: 'POST', 
        data: {id: tthis.parents('tr').attr('post_id'), value: -1},
      }).done(function(result) {
        tthis.prev().html(result.data);
      });
      return false;
    });
  }
}