/**
 * 
 */








    changeMapStyle('midnight')
    sel.value = 'midnight';

    function changeMapStyle(style){
        map.setMapStyle({style:style});
        $('#desc').html(mapstyles[style].desc);
    }
    
	var sel = document.getElementById('stylelist');
	for(var key in mapstyles){
	    var style = mapstyles[key];
	    var item = new  Option(style.title,key);
	    sel.options.add(item);
	}