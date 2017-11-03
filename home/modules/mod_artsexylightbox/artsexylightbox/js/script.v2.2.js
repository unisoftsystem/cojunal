/**
 * Sexy LightBox - for asljQuery 1.3
 * @name sexylightbox.v2.2.js
 * @author Eduardo D. Sada - http://www.coders.me/web-html-js-css/javascript/sexy-lightbox-2
 * @version 2.2
 * @date 1-Jun-2009
 * @copyright (c) 2009 Eduardo D. Sada (www.coders.me)
 * @license MIT - http://es.wikipedia.org/wiki/Licencia_MIT
 * @example http://www.coders.me/ejemplos/sexy-lightbox-2/
*/
if (typeof (asljQuery) == 'undefined') {
	asljQuery = jQuery;
}

asljQuery.bind=function(object,method){var args=Array.prototype.slice.call(arguments,2);return function(){var args2=[this].concat(args,asljQuery.makeArray(arguments));return method.apply(object,args2);};};(function(asljQuery){SexyLightbox={getOptions:function(){return{name:'SLB',zIndex:65555,color:'black',find:'sexylightbox',imagesdir:'sexyimages',background:'bgSexy.png',backgroundIE:'bgSexy.gif',closeButton:'SexyClose.png',displayed:0,modal:0,showDuration:200,showEffect:'linear',closeDuration:400,closeEffect:'linear',moveDuration:800,moveEffect:'easeOutBack',resizeDuration:800,resizeEffect:'easeOutBack',shake:{distance:10,duration:100,transition:'easeInOutBack',loops:2},BoxStyles:{'width':486,'height':320},Skin:{'white':{'hexcolor':'#FFFFFF','captionColor':'#000000','background-color':'#000','opacity':0.6},'black':{'hexcolor':'#000000','captionColor':'#FFFFFF','background-color':'#fff','opacity':0.6}}};},initialize:function(options){this.options=asljQuery.extend(this.getOptions(),options);this.options.OverlayStyles=asljQuery.extend(this.options.Skin[this.options.color],this.options.OverlayStyles||{});var strBG=this.options.imagesdir+'/'+this.options.color+'/'+((((window.XMLHttpRequest==undefined)&&(ActiveXObject!=undefined)))?this.options.backgroundIE:this.options.background);var name=this.options.name;
if (this.options.slideshow) {
	asljQuery('body').append('<div id="'+name+'-Overlay"></div><div id="'+name+'-Wrapper"><div id="'+name+'-Background"></div><div id="'+name+'-Contenedor"><div id="'+name+'-Top" style="background-image: url('+strBG+')"><span style=\"float: right; display: block; position: absolute;top: 7px; right: 90px;\"><a style=\"cursor:pointer;display:none\" onclick="\startSlideshow(' + this.options.slideshow + ')\" id="\playbutton\"><img src=\"' + this.options.imagesdir + '/play.png\" alt=\"play\" /></a><a style=\"cursor:pointer;\" onclick=\"stopSlideshow(true)\" id="\pausebutton\"><img src=\"' + this.options.imagesdir + '/pause.png\" alt=\"play\" /></a></span><a id="'+name+'-CloseButton" href="#"><img src="'+this.options.imagesdir+'/'+this.options.color+'/'+this.options.closeButton+'" alt="Close"></a><div id="'+name+'-TopLeft" style="background-image: url('+strBG+')"></div></div><div id="'+name+'-Contenido"></div><div id="'+name+'-Bottom" style="background-image: url('+strBG+')"><div id="'+name+'-BottomRight" style="background-image: url('+strBG+')"><div id="'+name+'-Navegador"><strong id="'+name+'-Caption"></strong></div></div></div></div></div>');
} else {
  asljQuery('body').append('<div id="'+name+'-Overlay"></div><div id="'+name+'-Wrapper"><div id="'+name+'-Background"></div><div id="'+name+'-Contenedor"><div id="'+name+'-Top" style="background-image: url('+strBG+')"><a id="'+name+'-CloseButton" href="#"><img src="'+this.options.imagesdir+'/'+this.options.color+'/'+this.options.closeButton+'" alt="Close"></a><div id="'+name+'-TopLeft" style="background-image: url('+strBG+')"></div></div><div id="'+name+'-Contenido"></div><div id="'+name+'-Bottom" style="background-image: url('+strBG+')"><div id="'+name+'-BottomRight" style="background-image: url('+strBG+')"><div id="'+name+'-Navegador"><strong id="'+name+'-Caption"></strong></div></div></div></div></div>');
}
this.Overlay=asljQuery('#'+name+'-Overlay');this.Wrapper=asljQuery('#'+name+'-Wrapper');this.Background=asljQuery('#'+name+'-Background');this.Contenedor=asljQuery('#'+name+'-Contenedor');this.Top=asljQuery('#'+name+'-Top');this.CloseButton=asljQuery('#'+name+'-CloseButton');this.Contenido=asljQuery('#'+name+'-Contenido');this.bb=asljQuery('#'+name+'-Bottom');this.innerbb=asljQuery('#'+name+'-BottomRight');this.Nav=asljQuery('#'+name+'-Navegador');this.Descripcion=asljQuery('#'+name+'-Caption');this.Overlay.css({'position':'absolute','top':0,'left':0,'opacity':this.options.OverlayStyles['opacity'],'height':asljQuery(document).height(),'width':asljQuery(document).width(),'z-index':this.options.zIndex,'background-color':this.options.OverlayStyles['background-color']}).hide();this.Wrapper.css({'z-index':this.options.zIndex,'top':(-this.options.BoxStyles['height']-280)+'px','left':((asljQuery(document).width()-this.options.BoxStyles['width'])/2)}).hide();this.Background.css({'z-index':this.options.zIndex+1});this.Contenedor.css({'position':'absolute','width':this.options.BoxStyles['width']+'px','z-index':this.options.zIndex+2});this.Contenido.css({'height':this.options.BoxStyles['height']+'px','border-left-color':this.options.Skin[this.options.color].hexcolor,'border-right-color':this.options.Skin[this.options.color].hexcolor});this.Nav.css({'color':this.options.Skin[this.options.color].captionColor});this.Descripcion.css({'color':this.options.Skin[this.options.color].captionColor});this.CloseButton.bind('click',asljQuery.bind(this,function(){this.close();
if (window.slideshowElm) {
  stopSlideshow();
  clearInterval(window.slideshowElm);
  window.slideshowElm = null;
}
return false;}));this.Overlay.bind('click',asljQuery.bind(this,function(){if(!this.options.modal){
if (window.slideshowElm) {
  stopSlideshow();
  clearInterval(window.slideshowElm);
  window.slideshowElm = null;
}
this.close();}}));asljQuery(document).bind('keydown',asljQuery.bind(this,function(obj,event){if(this.options.displayed==1){if(event.keyCode==27){this.close();}
if(event.keyCode==37){if(this.prev){this.prev.trigger('click',event);}}
if(event.keyCode==39){if(this.next){this.next.trigger('click',event);}}}}));asljQuery(window).bind('resize',asljQuery.bind(this,function(){if(this.options.displayed==1){this.replaceBox();}else{this.Overlay.css({'height':'0px','width':'0px'});}}));asljQuery(window).bind('scroll',asljQuery.bind(this,function(){if(this.options.displayed==1){this.replaceBox();}}));this.refresh();

},hook:function(enlace){enlace=asljQuery(enlace);enlace.blur();this.show((enlace.attr("title")||enlace.attr("name")||""),enlace.attr("href"),(enlace.attr('data-rel')||false));
if (this.options.slideshow && this.next && !window.slideshowElm) {
	window.slideshowElm = setInterval('goNext()', this.options.slideshow);
} else {
	//clearInterval(window.slideshowElm);
	//window.slideshowElm = null;
}
if (document.getElementById('playbutton')) {
  document.getElementById('playbutton').style.display = 'none';
}
if (document.getElementById('pausebutton')) {
  document.getElementById('pausebutton').style.display = '';
}
},close:function(){this.display(0);this.modal=0;},refresh:function(){var self=this;this.anchors=[];asljQuery("a, area").each(function(){if(asljQuery(this).attr('data-rel')&&new RegExp("^"+self.options.find).test(asljQuery(this).attr('data-rel'))){asljQuery(this).click(function(event){event.preventDefault();event.stopImmediatePropagation();self.hook(this);});if(!(asljQuery(this).attr('id')==self.options.name+"Left"||asljQuery(this).attr('id')==self.options.name+"Right")){self.anchors.push(this);}}});},display:function(option){if(this.options.displayed==0&&option!=0||option==1){asljQuery('embed, object, select').css({'visibility':'hidden'});if(this.options.displayed==0){this.Wrapper.css({'top':(-this.options.BoxStyles['height']-280)+'px','height':(this.options.BoxStyles['height']-80)+'px','width':this.options.BoxStyles['width']+'px'}).hide();}
this.options.displayed=1;this.Overlay.stop();this.Overlay.fadeIn(this.options.showDuration,asljQuery.bind(this,function(){this.Wrapper.show();this.Overlay.css({'opacity':this.options.OverlayStyles['opacity']});}));}
else
{asljQuery('embed, object, select').css({'visibility':'visible'});this.Wrapper.css({'top':(-this.options.BoxStyles['height']-280)+'px','height':(this.options.BoxStyles['height']-80)+'px','width':this.options.BoxStyles['width']+'px'}).hide();this.options.displayed=0;this.Overlay.stop();this.Overlay.fadeOut(this.options.closeDuration,asljQuery.bind(this,function(){if(this.Image)
this.Image.remove();this.Overlay.css({'height':0,'width':0});}));}},replaceBox:function(data){data=asljQuery.extend({'width':this.ajustarWidth,'height':this.ajustarHeight,'resize':0},data||{});if(this.MoveBox)
this.MoveBox.stop();
if (this.options.moveEffect == 'fade') {
  this.MoveBox=this.Wrapper.animate({left:(asljQuery(window).scrollLeft()+((asljQuery(window).width()-data.width)/2)),top:(asljQuery(window).scrollTop()+(asljQuery(window).height()-(data.height+((this.MostrarNav)?80:48)))/2)},{duration:this.options.moveDuration,easing:'linear'});
  asljQuery('#SLB-Background').fadeOut("slow", function () {
    jQuery(this).css({left:(asljQuery(window).scrollLeft()+((asljQuery(window).width()-data.width)/2)),top:(asljQuery(window).scrollTop()+(asljQuery(window).height()-(data.height+((this.MostrarNav)?80:48)))/2)});
    asljQuery('#SLB-Background').fadeIn("slow");
  });
} else {
  this.MoveBox=this.Wrapper.animate({left:(asljQuery(window).scrollLeft()+((asljQuery(window).width()-data.width)/2)),top:(asljQuery(window).scrollTop()+(asljQuery(window).height()-(data.height+((this.MostrarNav)?80:48)))/2)},{duration:this.options.moveDuration,easing:this.options.moveEffect});
}
if(data.resize){if(this.ResizeBox2)
this.ResizeBox2.stop();this.ResizeBox2=this.Contenido.animate({height:data.height},{duration:this.options.resizeDuration,easing:this.options.resizeEffect});if(this.ResizeBox)
this.ResizeBox.stop();this.ResizeBox=this.Contenedor.animate({width:data.width},{duration:this.options.resizeDuration,easing:this.options.resizeEffect,complete:asljQuery.bind(this,function(){this.Wrapper.css({'width':data.width});this.ResizeBox.trigger('onComplete');})});}
if(window.opera){this.Overlay.css({'height':0,'width':0});}
this.Overlay.css({'height':asljQuery(document).height(),'width':asljQuery(window).width()});},getInfo:function(image,id){image=asljQuery(image);IEuta=asljQuery('<a id="'+this.options.name+id+'" title="'+image.attr('title')+'" data-rel="'+image.attr('data-rel')+'"><img class="bt'+id+'" src="'+this.options.imagesdir+'/'+this.options.color+'/SexyBt'+id+'.png'+'" /></a>');IEuta.attr('href',image.attr('href'));return IEuta;},show:function(caption,url,rel){this.MostrarNav=false;this.showLoading();var baseURL=url.match(/(.+)?/)[1]||url;var imageURL=/\.(jpe?g|png|gif|bmp)/gi;if(this.ResizeBox){this.ResizeBox.unbind('onComplete');}
if(caption){this.MostrarNav=true;}
if(baseURL.match(imageURL)){this.imgPreloader=new Image();this.imgPreloader.onload=asljQuery.bind(this,function(){this.imgPreloader.onload=function(){};var x=asljQuery(window).width()-100;var y=asljQuery(window).height()-100;var imageWidth=this.imgPreloader.width;var imageHeight=this.imgPreloader.height;if(imageWidth>x)
{imageHeight=imageHeight*(x/imageWidth);imageWidth=x;if(imageHeight>y)
{imageWidth=imageWidth*(y/imageHeight);imageHeight=y;}}
else if(imageHeight>y)
{imageWidth=imageWidth*(y/imageHeight);imageHeight=y;if(imageWidth>x)
{imageHeight=imageHeight*(x/imageWidth);imageWidth=x;}}
if(this.MostrarNav||caption){this.ajustarHeight=(imageHeight-21);}else{this.ajustarHeight=(imageHeight-35);};this.ajustarWidth=(imageWidth+14);this.replaceBox({'width':this.ajustarWidth,'height':this.ajustarHeight,'resize':1});this.ResizeBox.bind('onComplete',asljQuery.bind(this,function(){this.showImage(this.imgPreloader.src,{'width':imageWidth,'height':imageHeight});}));});this.imgPreloader.onerror=asljQuery.bind(this,function(){this.show('',this.options.imagesdir+'/'+this.options.color+'/404.png',this.options.find);});this.imgPreloader.src=url;}else{var queryString=url.match(/\?(.+)/)[1];var params=this.parseQuery(queryString);
if (params['width'].toString().indexOf('%')!=-1) {
	params['width'] = parseInt(parseInt(params['width'])*asljQuery(window).width()/100);
	this.ajustarWidth=(params['width']+14);
} else {
	params['width'] = parseInt(params['width']);
}
if (params['height'].toString().indexOf('%')!=-1) {
	params['height'] = parseInt(parseInt(params['height'])*asljQuery(window).height()/100);
	this.ajustarHeight=parseInt(params['height'])+(window.opera?2:0);
} else {
	params['height'] = parseInt(params['height']);
}
params['modal']=params['modal'];this.options.modal=params['modal'];this.ajustarHeight=parseInt(params['height'])+(window.opera?2:0);this.ajustarWidth=parseInt(params['width'])+14;this.replaceBox({'width':this.ajustarWidth,'height':this.ajustarHeight,'resize':1});if(url.indexOf('TB_inline')!=-1)
{this.ResizeBox.bind('onComplete',asljQuery.bind(this,function(){this.showContent(asljQuery('#'+params['inlineId']).html(),{'width':params['width']+14,'height':this.ajustarHeight},params['background']);}));}
else if(url.indexOf('TB_iframe')!=-1)
{var urlNoQuery=url.split('TB_');this.ResizeBox.bind('onComplete',asljQuery.bind(this,function(){this.showIframe(urlNoQuery[0],{'width':params['width']+14,'height':params['height']},params['background']);}));}
else
{this.ResizeBox.bind('onComplete',asljQuery.bind(this,function(){asljQuery.ajax({url:url,type:"GET",cache:false,error:asljQuery.bind(this,function(){this.show('',this.options.imagesdir+'/'+this.options.color+'/404html.png',this.options.find)}),success:asljQuery.bind(this,this.handlerFunc)});}));}}
this.next=false;this.prev=false;if(rel.length>this.options.find.length)
{this.MostrarNav=true;var foundSelf=false;var exit=false;var self=this;asljQuery.each(this.anchors,function(index){if(asljQuery(this).attr('data-rel')==rel&&!exit){if(asljQuery(this).attr('href')==url){foundSelf=true;}else{if(foundSelf){self.next=self.getInfo(this,"Right");exit=true;}else{self.prev=self.getInfo(this,"Left");}}}});}
this.addButtons();this.showNav(caption, url);this.display(1);},handlerFunc:function(obj,html){this.showContent(html,{'width':this.ajustarWidth,'height':this.ajustarHeight});},showLoading:function(){this.Background.empty().removeAttr('style').css({'width':'auto','height':'auto'});this.Contenido.empty().css({'background-color':'transparent','padding':'0px','width':'auto'});this.Contenedor.css({'background':'url('+this.options.imagesdir+'/'+this.options.color+'/loading.gif) no-repeat 50% 50%'});this.Contenido.empty().css({'background-color':'transparent','padding':'0px','width':'auto'});this.replaceBox({'width':this.options.BoxStyles.width,'height':this.options.BoxStyles.height,'resize':1});},addButtons:function(){if(this.prev)this.prev.bind('click',asljQuery.bind(this,function(obj,event){event.preventDefault();this.hook(this.prev);}));if(this.next)this.next.bind('click',asljQuery.bind(this,function(obj,event){event.preventDefault();this.hook(this.next);}));},showNav:function(caption, url){if(this.MostrarNav||caption){this.bb.addClass("SLB-bbnav");this.Nav.empty();this.innerbb.empty();this.innerbb.append(this.Nav);
if (this.options.downloadLink && url) {
		var finalUrl = url;
		if(this.options.largeImagePath) {
			finalUrl = url.replace(this.options.path, this.options.largeImagePath);
		}
            this.Descripcion.html('<a class="sexylightbox_download" href="' + finalUrl + '">download</a>&nbsp;' + caption);
          } else if (this.options.print) {
            this.Descripcion.html('<span class="sexylightbox_print"><img src="plugins/content/artsexylightbox/artsexylightbox/images/print.png" onclick="printimage(event,\'' + url + '\')" /></span>' + caption);
          } else {
		    if (caption != 'undefined') {
              this.Descripcion.html(caption);
			}
          }

this.Nav.append(this.prev);this.Nav.append(this.next);this.Nav.append(this.Descripcion);}
else
{this.bb.removeClass("SLB-bbnav");this.innerbb.empty();}},showImage:function(image,size){this.Background.empty().removeAttr('style').css({'width':'auto','height':'auto'}).append('<img id="'+this.options.name+'-Image"/>');this.Image=asljQuery('#'+this.options.name+'-Image');this.Image.attr('src',image).css({'width':size['width'],'height':size['height']});this.Contenedor.css({'background':'none'});this.Contenido.empty().css({'background-color':'transparent','padding':'0px','width':'auto'});},showContent:function(html,size,bg){this.Background.empty().css({'width':size['width']-14,'height':size['height']+35,'background-color':bg||'#ffffff'});this.Contenido.empty().css({'width':size['width']-14,'background-color':bg||'#ffffff'}).append('<div id="'+this.options.name+'-Image"/>');this.Image=asljQuery('#'+this.options.name+'-Image');this.Image.css({'width':size['width']-14,'height':size['height'],'overflow':'auto','background':bg||'#ffffff'}).append(html);this.Contenedor.css({'background':'none'});var wId=asljQuery(this.Wrapper).attr('id');asljQuery('#'+wId+' select, #'+wId+' object, #'+wId+' embed').css({'visibility':'visible'});},showIframe:function(src,size,bg){this.Background.empty().css({'width':size['width']-14,'height':size['height']+35,'background-color':bg||'#ffffff'});var id="if_"+new Date().getTime()+"-Image";this.Contenido.empty().css({'width':size['width']-14,'background-color':bg||'#ffffff','padding':'0px'}).append('<iframe id="'+id+'" frameborder="0"></iframe>');this.Image=asljQuery('#'+id);this.Image.css({'width':size['width']-14,'height':size['height'],'background':bg||'#ffffff'}).attr('src',src);this.Contenedor.css({'background':'none'});      this.Descripcion.html(this.Image.attr('title'));},parseQuery:function(query){if(!query)
return{};var params={};var pairs=query.split(/[;&]/);for(var i=0;i<pairs.length;i++){var pair=pairs[i].split('=');if(!pair||pair.length!=2)
continue;params[unescape(pair[0])]=unescape(pair[1]).replace(/\+/g,' ');}
return params;},shake:function(){var d=this.options.shake.distance;var l=this.Wrapper.position();l=l.left;for(x=0;x<this.options.shake.loops;x++){this.Wrapper.animate({left:l+d},this.options.shake.duration,this.options.shake.transition).animate({left:l-d},this.options.shake.duration,this.options.shake.transition);}
this.Wrapper.animate({"left":l+d},this.options.shake.duration,this.options.shake.transition).animate({"left":l},this.options.shake.duration,this.options.shake.transition);}}})(asljQuery);

function goNext(elm) {
	if (SexyLightbox.next) {
		SexyLightbox.next.trigger('click');
	} else {
		clearInterval(window.slideshowElm);
		window.slideshowElm = null;
	}
}

function stopSlideshow(arg1) {
	if (window.slideshowElm) {
    if (arg1) {
      if (document.getElementById('playbutton')) {
        document.getElementById('playbutton').style.display = '';
      }
      if (document.getElementById('pausebutton')) {
        document.getElementById('pausebutton').style.display = 'none';
      }
    }
		clearInterval(window.slideshowElm);
		window.slideshowElm = null;
	}
}

function startSlideshow(intVal) {
	window.slideshowElm = setInterval('goNext()', intVal);
  if (document.getElementById('playbutton')) {
    document.getElementById('playbutton').style.display = 'none';
  }
  if (document.getElementById('pausebutton')) {
    document.getElementById('pausebutton').style.display = '';
  }
}

function printimage(evt, src)
{
  if (!evt) {
    // Old IE
    evt = window.event;
  }    
  var image = evt.target;
  if (!image) {
    // Old IE
    image = window.event.srcElement;
  }
  link = "about:blank";
  var pw = window.open(link, "_new");
  pw.document.open();
  pw.document.write(makepage(src));
  pw.document.close();
}


function makepage(src)
{
  // We break the closing script tag in half to prevent
  // the HTML parser from seeing it as a part of
  // the *main* page.

  return "<html>\n" +
    "<head>\n" +
    "<title>Temporary Printing Window</title>\n" +
    "<script>\n" +
    "function step1() {\n" +
    "  setTimeout('step2()', 10);\n" +
    "}\n" +
    "function step2() {\n" +
    "  window.print();\n" +
    "  window.close();\n" +
    "}\n" +
    "</scr" + "ipt>\n" +
    "</head>\n" +
    "<body onLoad='step1()'>\n" +
    "<img src='" + src + "'/>\n" +
    "</body>\n" +
    "</html>\n";
}