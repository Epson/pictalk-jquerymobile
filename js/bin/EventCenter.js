(function(){
  var EventCenter;
  /**
   * @author 																赵剑
   * @description 													事件中心控制器，负责shell和core模块之间事件的托管和分发 
   * @namespace															EventCenter
   */
  EventCenter = {
    /**
      * @member 
      * @public						
     * @description													事件队列，为每一个事件维护一个回调函数列表
      */
    eventList: null
    /**
     * @method		
     * @public				
     * @description													触发相应的事件
     * @param				{String}eventType				要触发的事件类型
     * @param   		{Array}paramArray				传入事件回调函数的参数
     * @throws															事件列表尚未初始化
     * @throws															要触发的事件类型不存在
     */,
    trigger: function(eventType, paramArray){
      var events, i$, to$, i, eventHandler;
      if (!this.eventList) {
        throw new Error("The eventList was undefined");
      }
      if (!this.eventList[eventType]) {
        throw new Error("The event type " + eventType + " was not found");
      }
      events = this.eventList[eventType];
      for (i$ = 0, to$ = events.length; i$ < to$; ++i$) {
        i = i$;
        eventHandler = events[i];
        eventHandler.callback.apply(eventHandler.context, paramArray);
      }
    }
    /**
     * @method	
     * @public					
     * @description													绑定回调函数到事件
     * @param				{String}eventType				要绑定的事件类型
     * @param   		{Function}callback			要绑定监听事件的回调函数
     * @param 			{Object}context					为回调函数指定的上下文
     */,
    bind: function(eventType, callback, context){
      var eventHandler;
      if (!this.eventList) {
        this.init();
      }
      if (!this.eventList[eventType]) {
        this.eventList[eventType] = [];
      }
      if (context === void 8) {
        context = this;
      }
      eventHandler = {
        callback: callback,
        context: context
      };
      this.eventList[eventType].push(eventHandler);
    }
    /**
     * @method		
     * @public				
     * @description													将事件的回调函数从事件中心中移除
     * @param				{String}eventType				要移除回调函数的事件类型
     * @param  			{Function}callback			要移除的回调函数
     * @throws															事件列表尚未初始化
     * @throws 															要移除回调函数的事件不存在
     */,
    unbind: function(eventType, callback){
      var events, i$, to$, i;
      if (!this.eventList) {
        throw new Error("The eventList was undefined");
      }
      if (!this.eventList[eventType]) {
        throw new Error("The event type " + eventType + " was not found");
      }
      if (callback === void 8) {
        this.eventList[eventType] = [];
      } else {
        events = this.eventList[eventType];
        for (i$ = 0, to$ = events.length; i$ < to$; ++i$) {
          i = i$;
          if (events[i] === callback) {
            events.splice(i, 1);
            break;
          }
        }
      }
    }
    /**
     * @method		
     * @public				
     * @description													事件中心初始化函数，初始化事件列表
     */,
    init: function(){
      this.eventList = [];
    }
  };
  module.exports = EventCenter;
}).call(this);
