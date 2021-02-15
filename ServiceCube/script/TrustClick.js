(function ($) {
    var ajaxtooltip = {
        fadeeffect: [true, 300], //enable Fade? [true/false, duration_milliseconds]
        useroffset: [-20, -20], //additional x and y offset of tooltip from mouse cursor, respectively
        loadingHTML: '<div><img src="Images/waiting.gif" width="16" height="16" /> Loading...</div>',

        positiontip: function ($tooltip, e) {
            var docwidth = (window.innerWidth) ? window.innerWidth - 15 : ajaxtooltip.iebody.clientWidth - 15
            var docheight = (window.innerHeight) ? window.innerHeight - 18 : ajaxtooltip.iebody.clientHeight - 15
            var twidth = $tooltip.get(0).offsetWidth
            var theight = $tooltip.get(0).offsetHeight
            var tipx = e.pageX + this.useroffset[0]
            var tipy = e.pageY + this.useroffset[1]
            tipx = (e.clientX + twidth > docwidth) ? tipx - twidth - (2 * this.useroffset[0]) : tipx //account for right edge
            tipy = (e.clientY + theight > docheight) ? tipy - theight - (2 * this.useroffset[0]) : tipy //account for bottom edge
            $tooltip.css({ left: tipx, top: tipy })
        },
        showtip: function ($tooltip, e) {
            if (this.fadeeffect[0])
                $tooltip.hide().fadeIn(this.fadeeffect[1])
            else
                $tooltip.show()
        },
        hidetip: function ($tooltip, e) {
            if (this.fadeeffect[0])
                $tooltip.fadeOut(this.fadeeffect[1])
            else
                $tooltip.hide()
        }
    }

    $.fn.trustclick = function () {
        ajaxtooltip.iebody = (document.compatMode && document.compatMode != "BackCompat") ? document.documentElement : document.body
        var tooltips = [] //array to contain references to all tooltip DIVs on the page
        this.each(function (index) { //find all links with "title=ajax:" declaration
            this.titleurl = jQuery.trim($(this).attr('url')); //get URL of external file
            this.titleposition = index + ' pos' //remember this tooltip DIV's position relative to its peers
            tooltips.push($('<div class="ajaxtooltip"></div>').appendTo('body'))
            var $target = $(this)
            $target.removeAttr('title')
            $target.onMouseover(
			    function (e) { //onMouseover element
			        var $tooltip = tooltips[parseInt(this.titleposition)]
			        if (!$tooltip.get(0).loadsuccess) { //first time fetching Ajax content for this tooltip?
			            $tooltip.html(ajaxtooltip.loadingHTML).show()
			            $tooltip.load(this.titleurl, '', function () {
			                popuptitle = $('<div class="ajaxtooltip-title">' + $target.text().trim() + '</div>')
			                //$tooltip = $tooltip.wrap('<div style="padding:10px"></div>');
			                $tooltip.html('<div style="padding:7px">' + $tooltip.html() + '</div>');
			                $tooltip.prepend(popuptitle);
			                ajaxtooltip.positiontip($tooltip, e)
			                ajaxtooltip.showtip($tooltip, e)
			                $tooltip.get(0).loadsuccess = true
			                //$tooltip.mouseout(function () { $tooltip.hide() })
			                $tooltip.draggable({ handle: popuptitle })
			                btn = $('<img />', {
			                    title: 'Close',
			                    src: 'http://172.22.1.26/cdn/Images/close.png',
			                    style: 'float:right;cursor:pointer',
			                    on: {
			                        click: function () {
			                            $tooltip.hide();
			                        }
			                    }
			                });
			                //$closebtn.click(function () { $tooltip.hide() })
			                popuptitle.append(btn)
			            })
			        }
			        else {
			            ajaxtooltip.positiontip($tooltip, e)
			            ajaxtooltip.showtip($tooltip, e)
			        }
			    }
		    )
        });
    };
} (jQuery));