package kabam.rotmg.servers.control
{
   import com.company.assembleegameclient.parameters.Parameters;
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.servers.api.ServerModel;
   
   public class ParseServerDataCommand
   {
       
      
      [Inject]
      public var servers:ServerModel;
      
      [Inject]
      public var data:Object;
      
      public function ParseServerDataCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.servers.setServers(this.makeListOfServers());
      }
      
      private function makeListOfServers() : Vector.<Server>
      {
         var serverList:Array = this.data.data;
         var list:Vector.<Server> = new Vector.<Server>(0);
         for each(var server: Object in serverList)
         {
            list.push(this.makeServer(server));
         }
         return list;
      }
      
      private function makeServer(obj:Object) : Server
      {
         return new Server().setName(obj.name).setAddress(obj.dns).setPort(obj.port).setLatLong(Number(obj.lat),Number(obj.long)).setUsage(obj.usage).setIsAdminOnly(obj.adminOnly);
      }
   }
}
