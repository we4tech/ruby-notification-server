Notification Server ruby integration
====================================

![Travis status](https://secure.travis-ci.org/we4tech/ruby-notification-server.png)

Ruby integration with nodejs based &quot;notification-server&quot;
You can get details information about notification server from 
[here](http://search.npmjs.org/#/notification-server)

In brief
--------
Notification server is an implementation of nowjs based messaging service, 
Using this you can easily publish messages to all web based subscribers. 

FYI, 

[Nowjs](http://nowjs.com/) is a wrapper around socket.io which has implemented HTML5 Websocket based API, also for fallback it supports wide rage of other choices. (ie. flash socket, json-polling etc..)

We've built this service so that we could send out live server changes to all running clients 
(which are built on flash or html5)

How To Use This Gem ?
======================

Set on Gemfile
---------------
> gem 'notification_server'

Generate configuration file
---------------------------
> rails generate notification_server:config

This should generate "config/notification_server.yml"

Run Notification Server
-----------------------
> rake notification_server:start

If you want to stop server
--------------------------
> rake notification_server:stop 

Restart server
--------------
> rake notification_server:restart

Integrate notification server nowjs script
-------------------------------------------
> <%= javascript_include_notification_server %> # This will produce <script src='..../nowjs.js'.../>

Integrate asynchronously  
-----------------------
> <%= javascript_include_async_notification_server %>

`Important`: If you use this method remember you can't get "now" variable immediately 
you have to wait for "now" variable.

Example Usages
---------------
> now.receive = function(info, message) { alert(message); }

> now.register({name: 'hasan'})

> now.publish('hi')

> now.publish({data: {tilte: 'abc}})

- nhm tanveer hossain khan (hasan)
