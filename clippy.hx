import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.display.SimpleButton;

class Clippy {

  static function call_js(fn: String, options: Dynamic): Void {
    if (ExternalInterface.available && fn != '') {
      try {
        ExternalInterface.call(fn, options);
      } catch(e: Dynamic) {
        trace("Exception: " + Std.string(e));
      }
    }
    else {
      trace("Error: ExternalInterface is not available!");
    }
  }

  static function main() {
    var text:String = flash.Lib.current.loaderInfo.parameters.text;
    var fnc:String = flash.Lib.current.loaderInfo.parameters.fnc;
    var id:String = flash.Lib.current.loaderInfo.parameters.id;

    var button:SimpleButton = new SimpleButton();
    button.useHandCursor = true;
    button.upState = flash.Lib.attach("button_up");
    button.overState = flash.Lib.attach("button_over");
    button.downState = flash.Lib.attach("button_down");
    button.hitTestState = flash.Lib.attach("button_down");

    button.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent) {
      call_js(fnc, { action: e.type, id: id });
    });

    button.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent) {
      call_js(fnc, { action: e.type, id: id });
    });

    button.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
      flash.system.System.setClipboard(text);
      call_js(fnc, { action: e.type, text: text, id: id });
    });

    flash.Lib.current.addChild(button);
  }

}