package
{
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.AssetLoader;
   import com.company.assembleegameclient.util.StageProxy;

   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.system.Capabilities;
   import kabam.lib.net.NetConfig;
   import kabam.rotmg.account.AccountConfig;
   import kabam.rotmg.appengine.AppEngineConfig;
   import kabam.rotmg.application.ApplicationConfig;
   import kabam.rotmg.assets.AssetsConfig;
   import kabam.rotmg.characters.CharactersConfig;
   import kabam.rotmg.classes.ClassesConfig;
   import kabam.rotmg.core.CoreConfig;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.death.DeathConfig;
   import kabam.rotmg.dialogs.DialogsConfig;
   import kabam.rotmg.errors.ErrorConfig;
   import kabam.rotmg.fame.FameConfig;
   import kabam.rotmg.game.GameConfig;
   import kabam.rotmg.hud.HUDConfig;
   import kabam.rotmg.legends.LegendsConfig;
   import kabam.rotmg.maploading.MapLoadingConfig;
   import kabam.rotmg.minimap.MiniMapConfig;
   import kabam.rotmg.news.NewsConfig;
   import kabam.rotmg.servers.ServersConfig;
   import kabam.rotmg.stage3D.Stage3DConfig;
   import kabam.rotmg.startup.StartupConfig;
   import kabam.rotmg.startup.control.StartupSignal;
   import kabam.rotmg.tooltips.TooltipsConfig;
   import kabam.rotmg.ui.UIConfig;
   import robotlegs.bender.bundles.mvcs.MVCSBundle;
   import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
   import robotlegs.bender.framework.api.IContext;
   import robotlegs.bender.framework.api.LogLevel;
   
   [SWF(frameRate="60",backgroundColor="#000000",width="800",height="600")]
   public class WebMain extends Sprite
   {
      public static var STAGE:Stage;

      protected var context:IContext;
   
      public function WebMain()
      {
         super();
         if(stage)
         {
            this.setup();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
      }
      
      private function onAddedToStage(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.setup();
      }
      
      private function setup() : void
      {
         this.hackParameters();
         this.createContext();
         new AssetLoader().load();
         stage.scaleMode = StageScaleMode.EXACT_FIT;
         var startup:StartupSignal = this.context.injector.getInstance(StartupSignal);
         startup.dispatch();
         STAGE = stage;
      }
      
      private function hackParameters() : void
      {
         Parameters.root = stage.root;
      }
      
      private function createContext() : void
      {
         var stageProxy:StageProxy = new StageProxy(this);
         this.context = new StaticInjectorContext();
         this.context.injector.map(LoaderInfo).toValue(root.stage.root.loaderInfo);
         this.context.injector.map(StageProxy).toValue(stageProxy);
         this.context
                 .extend(MVCSBundle)
                 .extend(SignalCommandMapExtension)
                 .configure(StartupConfig)
                 .configure(NetConfig)
                 .configure(AssetsConfig)
                 .configure(DialogsConfig)
                 .configure(ApplicationConfig)
                 .configure(AppEngineConfig)
                 .configure(AccountConfig)
                 .configure(ErrorConfig)
                 .configure(CoreConfig)
                 .configure(DeathConfig)
                 .configure(CharactersConfig)
                 .configure(ServersConfig)
                 .configure(GameConfig)
                 .configure(UIConfig)
                 .configure(MiniMapConfig)
                 .configure(LegendsConfig)
                 .configure(NewsConfig)
                 .configure(FameConfig)
                 .configure(TooltipsConfig)
                 .configure(MapLoadingConfig)
                 .configure(ClassesConfig)
                 .configure(Stage3DConfig)
                 .configure(HUDConfig)
                 .configure(this);
         this.context.logLevel = LogLevel.DEBUG;
      }
   }
}
