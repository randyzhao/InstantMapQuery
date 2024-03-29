<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
html {
	height: 100%
}

body {
	height: 100%;
	margin: 0;
	padding: 0
}

#map_canvas {
	height: 100%
}
</style>
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCLz5L6gaajpguQn4uXQ4FX6MPh7k72Z24&sensor=false">
	
</script>
<script type="text/javascript">
	var center_marker = null;
	function setCenterMarker(position, map) {
		if (center_marker == null) {
			center_marker = new google.maps.Marker({
				position : position,
				map : map,
				title : "You Are Here"
			});
		} else {
			center_marker.setPosition(position);
		}
	}
	function initialize() {
		var mapOptions = {
			center : new google.maps.LatLng(-34.397, 150.644),
			zoom : 8,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		var map = new google.maps.Map(document.getElementById("map_canvas"),
				mapOptions);
		google.maps.event.addListener(map, 'click', function(e) {
			//alert('fuck');
			setCenterMarker(e.latLng, map);
			//alert(e.latLng.toString());
			//alert(center_marker.getPosition().toString());
		});

	}
	function makeHttpObject() {
		try {
			return new XMLHttpRequest();
		} catch (error) {
		}
		try {
			return new ActiveXObject("Msxml2.XMLHTTP");
		} catch (error) {
		}
		try {
			return new ActiveXObject("Microsoft.XMLHTTP");
		} catch (error) {
		}

		return null;
	}
	function query(option) {
		var httpObj = makeHttpObject();
		if (httpObj == null) {
			return null;
		}
		var post_data = JSON.stringify(option);
		httpObj.open("POST", "QueryServlet", true);
		httpObj.onreadystatechange = function() {//Call a function when the state changes.
			if (httpObj.readyState == 4 && httpObj.status == 200) {
				alert(httpObj.responseText);
			}
		};
		httpObj.send(post_data);
	}

	function handleSearchContentChange(value) {
		if (center_marker != null) {
			query({
				lat : center_marker.getPosition().lat(),
				lng : center_marker.getPosition().lng(),
				scale : document.getElementById("scale_select").options[document
						.getElementById("scale_select").selectedIndex].value,
				content : value
			});
		}
	}
</script>
</head>
<body onload="initialize()">
	<div id="search_div" style="width: 100%; height: auto">
		<table border="0" style="width: 100%">
			<tr style="width: 100%">
				<td>
					<div id="content_div"
						style="width: 50%; margin-left: auto; margin-right: 0">
						<input id="search_content" type="text"
							style="height: auto; width: 100%"
							onkeyup="handleSearchContentChange(this.value)" />
					</div>
				</td>
				<td>
					<div id="scale_div" style="margin-left: 0; margin-right: auto">
						<select id="scale_select">
							<option value="100m">100m</option>
							<option value="1000m">1000m</option>
						</select>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div id="map_canvas" style="width: 100%; height: 100%"></div>
</body>
</html>