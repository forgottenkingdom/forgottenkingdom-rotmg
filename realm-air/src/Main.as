package {
    import flash.display.Sprite;
    import flash.events.Event;

    public class Main extends Sprite {
        public function Main() {
            super();
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(e:Event = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            // Définis la couleur de fond à bleu
            graphics.beginFill(0x0000FF); // Bleu
            graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            graphics.endFill();
        }
    }
}