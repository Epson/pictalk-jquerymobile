require! []

/**
 * @author 																赵剑
 * @description 													事件中心控制器，负责shell和core模块之间事件的托管和分发 
 * @namespace															EventCenter
 */
EventCenter = 

	/**
   * @member 
   * @public						
	 * @description													事件队列，为每一个事件维护一个回调函数列表
   */
	event-list: null,

	/**
	 * @method		
	 * @public				
	 * @description													触发相应的事件
	 * @param				{String}eventType				要触发的事件类型
	 * @param   		{Array}paramArray				传入事件回调函数的参数
	 * @throws															事件列表尚未初始化
	 * @throws															要触发的事件类型不存在
	 */	
	trigger: !(event-type, param-array) ->
		if !@event-list
			throw new Error "The eventList was undefined"

		if !@event-list[event-type]
			throw new Error "The event type " + event-type + " was not found" 

		events = @event-list[event-type]

		for i til events.length
			event-handler = events[i]
			event-handler.callback.apply event-handler.context, param-array

	/**
	 * @method	
	 * @public					
	 * @description													绑定回调函数到事件
	 * @param				{String}eventType				要绑定的事件类型
	 * @param   		{Function}callback			要绑定监听事件的回调函数
	 * @param 			{Object}context					为回调函数指定的上下文
	 */	
	bind: !(event-type, callback, context) ->
		if !@event-list
			@init!

		if !@event-list[event-type]
			@event-list[event-type] = [];

		if context == void
			context = @

		event-handler = 
			callback: callback,
			context: context

		@event-list[event-type].push event-handler

	/**
	 * @method		
	 * @public				
	 * @description													将事件的回调函数从事件中心中移除
	 * @param				{String}eventType				要移除回调函数的事件类型
	 * @param  			{Function}callback			要移除的回调函数
	 * @throws															事件列表尚未初始化
	 * @throws 															要移除回调函数的事件不存在
	 */	
	unbind: !(event-type, callback) ->
		if !@.event-list 
			throw new Error "The eventList was undefined"
		
		if !@.event-list[event-type] 
			throw new Error "The event type " + event-type + " was not found"
		
		if callback == void
			@event-list[event-type] = []
		else
			events = @event-list[event-type];
			for i til events.length
				if events[i] == callback
					events.splice i, 1
					break

	/**
	 * @method		
	 * @public				
	 * @description													事件中心初始化函数，初始化事件列表
	 */	
	init: !->
		@event-list = []

module.exports = EventCenter
