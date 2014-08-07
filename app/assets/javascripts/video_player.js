// After selecting channel it starts automatically jwplayer
function startPreview(stream){
    if (stream.value != ''){
        var url = stream.value.split("|")[1];
        jwplayer("myElement").setup({
            file: url,
      	    image: "/uniretv.jpg",
      	    height: 360,
      	    width: 640,
      	    autostart: true
        });
    }
}
