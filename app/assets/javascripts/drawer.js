;(function($){
  var touch = false;
  $('#humberger').on('click touchstart',function(e){

      switch (e.type) {
          case 'touchstart':
              drawerToggle();
              touch = true;
              return false;
          break;
          case 'click':
              if(!touch)
                   drawerToggle();
              return false;
          break;
       }
      function drawerToggle(){
          $('body').toggleClass('drawer-opened');
          touch = false;
      }
  })
  $('#overlay').on('click touchstart',function(){
      $('body').removeClass('drawer-opened');
  })
})(jQuery);
