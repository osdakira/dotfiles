// .slate.js
var util = {
  // alt + ..
  key: function(k, mod) {
    return k + ':cmd' + (mod ? ',' + mod : '');
  },
  focusWindow: function(f) {
    var hit = false;
    slate.eachApp(function(app) {
      if (hit) return;
      app.eachWindow(function(win) {
        if (hit) return;
        if (f(win)) {
          win.focus();
          hit = true;
        }
      });
    });
  },
  nextScreen: function(screen) {
    return slate.screenForRef(String( (screen.id()+1)%slate.screenCount() ));
  }
};

// m          .. 最大化
slate.bind(util.key("f", "ctrl"), function(win) {
  if (!win) return;
  var bounds = win.screen().visibleRect();
  win.doOperation('move', bounds);
});


// u+shift    .. 左右に飛ばす
slate.bind(util.key('l', 'ctrl'), slate.operation('chain', {
  operations: _.map(['left', 'right'], function(d) {
    return slate.operation('push', {
      direction: d,
      style: 'bar-resize:screenSizeX/2'
    });
  })
}));
 
// i+shift    .. 上下に飛ばす
slate.bind(util.key('j', 'ctrl'), slate.operation('chain', {
  operations: _.map(['top', 'bottom'], function(d) {
    return slate.operation('push', {
      direction: d,
      style: 'bar-resize:screenSizeY/2'
    });
  })
}));
