# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('.status').hover (event) -> #grabbing the status, calling the hover method, and passing it a function that defines what we want to do every time with hover over or hover leaves
		$(this).toggleClass("hover") #represent the specific status element, toggle class= every time is it called if hover exist it removes it, otherwise it removes it (the links).
