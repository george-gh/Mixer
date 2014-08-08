// After selecting channel it starts automatically jwplayer
function startPreview(stream){
    if (stream.value != ''){
        var url = stream.value;
        jwplayer("myElement").setup({
            file: url,
      	    height: 360,
      	    width: 640,
      	    autostart: true
        });
    }
}
