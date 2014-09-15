function AreaMap() {
};

AreaMap.markers = {};

AreaMap.map = null;

AreaMap.creating = false;

AreaMap.load_map = function() {
	console.log("load called");

    var link = $('#edit_poi_link');
    link.hide();
	
	$("#selectable").selectable({
		stop : function() {
			var result = $("#select-result").empty();
			$(".ui-selected", this).each(function() {
				var selected_li = $("#selectable li");
				var index = selected_li.index(this);
				poi_id = $(".ui-selected").attr('data-visage-edit-poi');
				result.append(" #" + (index + 1 ));
				result.attr("data-visage-edit-poi", index);
				var link = $('#edit_poi_link');
                link.show();
				var strings = link.attr('data-visage-edit-poi-link').split("/");
				strings[strings.length - 2] = poi_id;
				link.attr("href", strings.join("/"));
				// set the selected marker draggable only
				marker = AreaMap.markers[poi_id];
				if(marker) {
					$.each(AreaMap.markers, function(index, entry){
						if (index == poi_id) {
							entry.setDraggable(true);
							entry.setAnimation(google.maps.Animation.DROP);
						} else {
							entry.setDraggable(false);
						};
					});
				}
			});
		}
	});
	
	if ($("#map").length <= 0)
		return;
		
	if(AreaMap.creating)
		return;
		
	AreaMap.creating = true;
		
	if (Object.keys(AreaMap.markers).length > 0) {
		$.each(AreaMap.markers, function(index, entry) {
			entry.setMap(null);
		});
		AreaMap.markers = {};
	}

	handler = Gmaps.build('Google');
	handler.buildMap({
		provider : {},
		internal : {
			id : 'map'
		}
	}, function() {

		AreaMap.map = handler.getMap();
        AreaMap.handleNoGeolocation
		
		var input = (document.getElementById('pac-input'));
	    AreaMap.map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
	
	    var searchBox = new google.maps.places.SearchBox((input));
	    
	    google.maps.event.addListener(searchBox, 'places_changed', function() {
    		var places = searchBox.getPlaces();
    		var bounds = new google.maps.LatLngBounds();
    		$(places).each(function(i,place){
    			bounds.extend(place.geometry.location);
    		});
    		AreaMap.map.fitBounds(bounds);
    	});
		
		google.maps.event.addListener(handler.getMap(), 'click', function(event) {
			AreaMap.place_marker(event.latLng);
		});

		// set the markers for the POI's

		AjaxFunctions.getPoiList(area_id, function(pois) {
			$.each(pois, function(index, value) {
				if (value.lat) {
					var latlng = new google.maps.LatLng(value.lat, value.lng);
					var marker = new google.maps.Marker({
						position : latlng,
						map : AreaMap.map,
						draggable : false
					});
					google.maps.event.addListener(marker, 'dragend', function() {
						AreaMap.updatePoiLocation(marker.getPosition());
					});
					AreaMap.markers[value.id] = marker;
				}
			});
			
			if(Object.keys(AreaMap.markers).length > 0) {
				// set center to contain all the markers
				var bounds = new google.maps.LatLngBounds();
				$.each(AreaMap.markers, function(i,m){
					bounds.extend(m.getPosition());
				});
				AreaMap.map.fitBounds(bounds);
				AreaMap.map.setCenter(bounds.getCenter());
			} else if(navigator.geolocation) {
				// fall back to user location
				navigator.geolocation.getCurrentPosition(function(position) {
					initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
					AreaMap.map.setCenter(initialLocation);
				}, function() {
					AreaMap.handleNoGeolocation();
				});
			} else {
				AreaMap.handleNoGeolocation();
			}
		
		});
		
		console.log("map created");
		AreaMap.creating = false;

	});

};

// fall back to London
AreaMap.handleNoGeolocation = function() {
	initialLocation = new google.maps.LatLng(51.507351, -0.127758);
	AreaMap.map.setCenter(initialLocation);
};

AreaMap.updatePoiLocation = function(location) {
	// call ajax update
	AjaxFunctions.setPoiLocation(area_id, poi_id, location.lat(), location.lng());
};

AreaMap.place_marker = function(location) {
	if (poi_id < 0 || AreaMap.markers[poi_id])
		return;
	AreaMap.markers[poi_id] = new google.maps.Marker({
		position : location,
		map : AreaMap.map,
		draggable : true
	});
	AreaMap.updatePoiLocation(location);
};
