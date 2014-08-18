// After selecting channel it starts automatically jwplayer
function startPreview(stream){
    if (stream.value != ''){
        var url = stream.value;
        jwplayer("myElement").setup({
            file: url,
      	    height: 300,
      	    width: 400,
      	    autostart: true
        });
    }
}
