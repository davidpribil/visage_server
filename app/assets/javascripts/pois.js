$(function() {
	
	var locationMap = {};
	
	var tabArray = [];
	
	$('form').submit(function(){
		$('#poi_datas_location').attr('value', JSON.stringify(locationMap));
		$('#poi_tab_data').attr('value', JSON.stringify(tabArray));
		locationMap = {};
	});

	$('poi_data_locations').append('test');

	$("#assets").accordion({
		collapsible : true,
		active : false
	});

	// audio
	
	function setAudio(element) {
	   $(element).button({
	      text: false,
	      icons: {
	        primary: "ui-icon-play"
	      }
	   }).click(function() {
	   	  $("#" + $(this).attr('source_id')).trigger($(this).text());
		  var options;
		  if ( $( this ).text() === "play" ) {
		    options = {
		      label: "pause",
		      icons: {
		        primary: "ui-icon-pause"
		      }
		    };
		  } else {
		    options = {
		      label: "play",
		      icons: {
		        primary: "ui-icon-play"
		      }
		    };
		  }
  		  $( this ).button( "option", options );
	    });
	    $(element).css("position", "absolute");
	};
	
	setAudio(".audio_dnd");
	
	var currentTab = -1;
	
	var tabs = $("#tabs").tabs({
		activate: function( event, ui ) {
			currentTab = ui.newPanel.attr('id').substring(5);
			console.log("Current tab: " + currentTab);
		}
	});
	
	var getDropOptions = function(dropTextId) {
		return {
			helper : 'clone',
			containment : tabs,
			cancel : false,
			stack: ".draggable",
			
			start : function(event, ui) {
				$(this).find("#" + dropTextId).focus();
			},
			stop : function(event, ui) {
				$(this).find("#" + dropTextId).focus();
			}
		};
	};

	$('.draggable').draggable(getDropOptions("dragText"));
	
	var counter = 0;

	var tabTitle = $("#tab_title"), tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>", tabCounter = 0;

	// modal dialog init: custom buttons and a "close" callback resetting the form inside
	var dialog = $("#dialog_new_era").dialog({
		autoOpen : false,
		modal : true,
		buttons : {
			Add : function() {
				addTab();
				$(this).dialog("close");
                // submit info to the server
                $('#form_submission_button').click();
			},
			Cancel : function() {
				$(this).dialog("close");
			}
		},
		close : function() {
			form[0].reset();
		}
	});
	
	var marker_dialog = $("#dialog_set_marker").dialog({
		autoOpen : false,
		modal : true,
		buttons : {
			Add : function() {
				$(this).dialog("close");
			},
			Cancel : function() {
				$(this).dialog("close");
                window.history.back();
			}
		},
		close : function() {
			form[0].reset();
            window.history.back();
        }
	});

	// addTab form: calls addTab function on submit and closes the dialog
	var form = dialog.find("form").submit(function(event) {
		addTab();
		dialog.dialog("close");
		event.preventDefault();
	});
	
	function setPoiDataPosition(element, tabId){
		if(!locationMap[element.attr('id')]) {
			locationMap[element.attr('id')] = new Object();
			locationMap[element.attr('id')].poi_data_id = $(element[0]).attr('poi_data_id');
			locationMap[element.attr('id')].poi_data_location_id = $(element[0]).attr('poi_data_location_id');
			locationMap[element.attr('id')].tab_id = tabId;
		}
		locationMap[element.attr('id')].x = element.position().left;
		locationMap[element.attr('id')].y = element.position().top;
		locationMap[element.attr('id')].w = element.width();
		locationMap[element.attr('id')].h = element.height();
		locationMap[element.attr('id')].source = element.attr('source');
	};
	
	function removePoiDataPosition(element) {
		delete locationMap[element.attr('id')];
	};
	
	addNewElement = function(element, x, y, w, h, poi_data_location_id, tabId, source) {
		element.attr("poi_data_location_id",poi_data_location_id);
		element.attr("tabId", tabId);
		element.attr("clone", "true");
		element.attr("source", source);
		element.offset({
				top: y,
				left: x
			});
		element.css({
			position: 'absolute',
			width: w,
			height: h
		});
		element.uniqueId();
		var jsId = "#tabs-" + tabId;
		tabs.tabs( "option", "active", $(jsId).index() - 1 );
		dropElement(element, false, $(jsId));
	};

	// actual addTab function: adds new tab using the input from the form above
	addTab = function(tabLabel, counter) {
		if(!counter) {
			counter = tabCounter;
		} else if(counter > tabCounter) {
			tabCounter = counter;
		}
		tabCounter++;
		var label = tabLabel || tabTitle.val() || "Tab " + counter,
		id = "tabs-" + counter, li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label));
		var tabContent;
		if($("#droppable").find("#set_marker").length > 0) {
			tabContent = $("#droppable");		
		} else {
			tabContent = $("#droppable").clone().empty().addClass('droppable');
			tabContent.droppable({
				drop:function(e,ui) {
					if(ui.helper.attr("clone")) {
						setPoiDataPosition($(ui.helper), currentTab);
						return;
					}

					var clone = $(ui.helper).clone();
					
					clone.attr("clone", "true");
					clone.uniqueId();
					
					dropElement(clone, true, $(this));
					//clone.css("margin-left", "10px");
                	//clone.css("margin-top", e.clientY - $(e.target).offset().top);
					$(ui.helper).remove();
					//console.log(clone);
					
				}
			});
		}
		tabs.find(".ui-tabs-nav").append(li);
		var newDiv = $("<div id='" + id + "'></div>");
		newDiv.css("width", "100%")
			.css("height", "100%");
		newDiv.append(tabContent.css("display","block"));
		tabs.append(newDiv);
		console.log(id);
		//if(id == "tabs-3")
			//newDiv.append("<p>Test test test</p>");
		tabs.tabs("refresh");
		tabs.tabs( "option", "active", counter );
		tabArray.push({
			id: counter,
			name: label
		});
	};
	
	var resizeParams = {
		stop: function(){
			setPoiDataPosition($(this), currentTab);
		}
	};
	
	var dropElement = function(clone, userDropped, container){
		
		if($(clone).find("textarea[id^='dragText']").length > 0) {
			console.log("textarea");
			var textArea = $(clone).find("textarea[id^='dragText']");
			if (userDropped) {
				textArea.val("");
			} else {
				textArea.val(clone.attr('source'));
			};
			textArea.bind('input propertychange', function() {
				$(this).parent().attr('source', $(this).val());		
				setPoiDataPosition($(this).parent(), currentTab);	      
			});
			
			var textAreaId = $(clone).find("textarea[id^='dragText']").attr('id');
			
			if (textAreaId == "dragText")
				textAreaId = textAreaId + ++counter;
				
			
			$(clone).find("textarea[id^='dragText']").attr('id', textAreaId);
			$(clone).find("textarea[id^='dragText']").click(function () {
			    $(this).focus();
			});
			
			$(clone).resizable(resizeParams);
		} else if($($(clone)[0]).hasClass("image_dnd")) {
			console.log("image");
		} else if($($(clone)[0]).hasClass("button_wrapper")) {
			console.log("audio");
			setAudio(clone.find('.audio_dnd'));
			clone.resizable(resizeParams);
			
		}
		clone.removeClass('ui-draggable-dragging');
		clone.draggable(getDropOptions(textAreaId));
        clone.draggable('option', 'helper', "original");
        var off = tabs.offset();
        var cloneOff = clone.offset();;
        if(userDropped) {
	        cloneOff.left -= off.left;
	        cloneOff.top -= off.top;
        } else {
        	//cloneOff.left += off.left;
	        //cloneOff.top += off.top;
        }
        clone.offset(cloneOff);
        //add resizable AFtER draggable
        if($($(clone)[0]).hasClass("image_dnd")) {
        	clone.find('.ui-resizable-handle').remove();
        	//clone.find('img').uniqueId();
			//clone.resizable({ alsoResize: "#" + clone.find('img').attr('id') });
			clone.resizable(resizeParams);
		}
		var closeDiv = $("<div class=close-image></div>");
		$(closeDiv).button({
		      text: false,
		      icons: {
		        primary: "ui-icon-close"
		      }
		   }).click(function(){
		   	removePoiDataPosition($(this).parent());
		   	$(this).parent().remove();
		   });
		clone.prepend(closeDiv);
		container.append(clone);
		if(userDropped) {
			setPoiDataPosition(clone, currentTab);
		} else {
			setPoiDataPosition(clone, clone.attr("tabId"));
		}
	};

	// addTab button: just opens the dialog
	$("#add_tab").button().click(function() {
		dialog.dialog("open");
	});

	$("#set_marker").button().click(function(){
		marker_dialog.dialog("open");
	});

	removeTab = function(tabId){
		$("#" + tabId).remove();
		var id = tabId.substring(5);
		tabArray = _.reject(tabArray, function(tab){ return tab.id == id; });
		
		locationMap = _.chain(locationMap)
			.map(function(val, id) {
			    val.innerId = id;
			    return val;
			}).reject(function(val){ 
			    return val.tab_id === id;
			}).reduce(function(context, val){ 
			    context[val.innerId] = val;
			    return context;
			},{}).value();

		console.log(tabId);
		console.log(locationMap);
		tabs.tabs("refresh");
	};

	// close icon: removing the tab on click
	tabs.delegate("span.ui-icon-close", "click", function() {
		var panelId = $(this).closest("li").remove().attr("aria-controls");
		removeTab(panelId);
		
	});

	tabs.bind("keyup", function(event) {
		if (event.altKey && event.keyCode === $.ui.keyCode.BACKSPACE) {
			var panelId = tabs.find(".ui-tabs-active").remove().attr("aria-controls");
			removeTab(panelId);
		}
	});
	
	$(window).unload(function(){
	  console.log("left the page");
	});

	
});
