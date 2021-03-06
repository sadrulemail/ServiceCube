﻿// Code By: Ashik Iqbal
// www.ashik.info

var editor, myLayout, myLayout1, ckeditorToolbar, LastMsg, EMPID, ONEDIT = false, CSS_FILTER = '', UnreadCount = 0, request, timeout, teamdata;
ONEDIT = false;
ckeditorToolbar = [
	    ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo'],
        ['Find', 'Replace', '-', 'SelectAll'],
	    ['Bold', 'Italic', 'Underline', 'Strike', '-', 'RemoveFormat'], ['Subscript', 'Superscript'], ['Source'], ['Maximize'], '/',
	    ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent',
	    '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
	    ['Link', 'Unlink'],
	    ['Table', 'HorizontalRule', 'Smiley'],
        ['Styles', 'TextColor', 'BGColor']];
ckeditorRemovePlugins = 'bidi,font,forms,flash,horizontalrule,iframe,scayt,wsc';

function htmlEscape(str) {
    //return str.text();
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/\\/g, '&#92;')
        ;
}

function getLightBoxImageSizeText() {
    return '&W=' + (Math.round($(window).width() / 100) * 100 + 100) + '&H=' + (Math.round($(window).height() / 100) * 100 + 100);
}

function getReadableFileSizeString(fileSizeInBytes) {
    var i = -1;
    var byteUnits = [' KB', ' MB', ' GB', ' TB', 'PB', 'EB', 'ZB', 'YB'];
    do {
        fileSizeInBytes = fileSizeInBytes / 1024;
        i++;
    } while (fileSizeInBytes > 1024);
    return Math.max(fileSizeInBytes, 0.1).toFixed(2) + byteUnits[i];
}

function replaceURLWithHTMLLinks(text) {
    var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
    return text.replace(exp, "<a href='$1' target='_blank'>$1</a>");
}

function showLoadingDialog(titleText) {
    $("#loading").dialog({
        modal: true,
        height: 210,
        width: 240,
        resizable: false,
        draggable: false,
        title: titleText,
        closeOnEscape: false,
        disabled: true
    });
    $(".ui-dialog-titlebar-close").hide();
}

function hideLoadingDialog() {
    $("#loading").dialog("close");
    $("#loading").dialog("destroy");
}

function RefreshAttachments() {
    $('#ctl00_ContentPlaceHolder2_hidFileIds').val('');
    $('#attachmentFileList input[type="checkbox"]:checked').each(function () {
        $('#ctl00_ContentPlaceHolder2_hidFileIds').val($('#ctl00_ContentPlaceHolder2_hidFileIds').val() + $(this).val() + ',');
    });
  
}

function buildTeamSelectorCheckbox() {
    $('#my-team-assign').jstree({ 'core': {
        'multiple': true,
        'data': teamdata        
    },
     "checkbox" : {
         "keep_selected_style": true
    },
  "plugins": ["checkbox"]
    }).on('loaded.jstree', function () {
        $(".jstree").jstree('open_all');
        $(".jstree").jstree('select_node', $('#hidAssignedTeamID').val());
    }).on('changed.jstree', function (e, data) {
        var i, j, r = [];
        for (i = 0, j = data.selected.length; i < j; i++) {
            r.push(data.instance.get_node(data.selected[i]).id);
        }
        $('#hidAssignedTeamID').val(r.join(','));
//        jAlert($('#hidAssignedTeamID').val());
    })
}

function buildTeamSelector() {
    $('#team-assign').jstree({ 'core': {
        'multiple': false,
        'data': teamdata
    }
    }).on('loaded.jstree', function () {
        $(".jstree").jstree('open_all');
        $(".jstree").jstree('select_node', $('#hidAssignedTeamID').val());
    }).on('changed.jstree', function (e, data) {
        var i, j, r = [];
        for (i = 0, j = data.selected.length; i < j; i++) {
            r.push(data.instance.get_node(data.selected[i]).id);
        }
        $('#hidAssignedTeamID').val(r.join(','));
        //jAlert($('#hidAssignedTeamID').val());
    })
}

function split(val) {
    return val.split(/,\s*/);
}
function extractLast(term) {
    return split(term).pop();
}
function highlight(value, term) {
    if (term.length > 0)
        return value.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + term.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\])/gi, "\\$1") + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<span class='highlight'>$1</span>");
    return value;
}

$(document).ready(function () {
    jQueryInit();
});

//function pageLoad() {
//    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(jQueryInit);
//}

function pageLoad(sender, args) {
    if (args.get_isPartialLoad()) jQueryInit();
}

function jQueryInit() {
    $(document).ready(function () {

        // Prevent the backspace key from navigating back.
        $(document).unbind('keydown').bind('keydown', function (event) {
            var doPrevent = false;
            if (event.keyCode === 8) {

                var d = event.srcElement || event.target;
                //alert();
                if ((d.tagName.toUpperCase() === 'INPUT' && (
                    d.type.toUpperCase() === 'TEXT'
                    || d.type.toUpperCase() === 'PASSWORD'))
                    || d.tagName.toUpperCase() === 'TEXTAREA'
                    || $(d).hasClass("editable")
                    ) {
                    doPrevent = d.readOnly
                    || d.disabled;
                }
                else {
                    doPrevent = true;
                }
            }
            if (doPrevent) {
                event.preventDefault();
            }
        });
    });


    try {
        editor = CKEDITOR.replace('txtComment', {
            //extraPlugins: 'autogrow',
            //autoGrow_maxHeight: 400,
            //removePlugins: 'resize',
            width: 730,
            extraPlugins: 'tableresize',
            toolbarCanCollapse: true,
            disableNativeSpellChecker: false,
            scayt_autoStartup: false,
            removePlugins: ckeditorRemovePlugins,
            toolbar: ckeditorToolbar,
            smiley_path: 'smileys/'
            //removePlugins: 'contextmenu'
        });
        ONEDIT = false;
    }
    catch (E) { }
    ////try {
    //    $(".intra-search-box").autocomplete("https://intraweb.tblbd.com/EmpInfo/Search_CS.ashx", {
    //        width: 300,
    //        minChars: 1,
    //        cacheLength: 10,
    //        scrollHeight: 500,
    //        delay: 400,
    //        scroll: true,
    //        formatItem: function (data, i, n, value) {
    //            return "<table width='100%'><tr><td valign='top'><img src='"
    //            + value.split(",")[1] + "' width='50' height='50' title='"
    //            + value.split(",")[2] + "' /></td><td width='100%'>"
    //            + value.split(",")[0] + "</td>" + (ONEDIT == true ? "<td class='add-link'>+</td>" : "") + "</tr></table>";
    //            //+ value.split(",")[0] + "</td>" + (ONEDIT == true ? "<td class='add-link'><input type='button' text='+'>+</td>" : "") + "</tr></table>";
    //        },
    //        formatResult: function (data, value) {
    //            return value.split(",")[2];
    //        }
    //    });
    ////} catch (e) { }

    //try {
    //    $(".intra-search-box").result(function findValueCallback(event, data, formatted) {
    //        if (data && !ONEDIT) {
    //            window.open(data[0].split(",")[3], '_blank');
    //            return false;
    //        }
    //        else if (data && ONEDIT) {
    //            var regexBR = /<br\s*[\/]?>/gi;
    //            var url = data[0].split(",")[3];
    //            var name = data[0].split(",")[0].replace(regexBR, ', ');
    //            var type = data[0].split(",")[4];
    //            var empid = data[0].split(",")[2];
    //            if (editor != null)
    //                editor.insertHtml('<a href="' + url + '" class="emp-profile" type="' + type + '" id="' + empid + '" >' + name + '</a>');

    //            //alert(name);
    //        }
    //    });
    //}
    //catch (e) { }

    try {
    $('.intra-search-box').autocomplete({
        source: function (request, response) {
            $.getJSON("https://intraweb.tblbd.com/EmpInfo/SearchBox.ashx", {
                term: extractLast(request.term)
            }, response);
        },
        search: function () {
            // custom minLength
            var term = extractLast(this.value);
            if (term.length < 1) {
                return false;
            }
        },
        focus: function () {
            // prevent value inserted on focus
            return false;
        },
        autoFocus: true,
        //response:function( event, ui ) { return false; },
        select: function (event, ui) {
            $('.intra-search-box').val(ui.item.id);
            window.open(ui.item.profile);
            return false;
        },
        open: function () {
            $('#ui-id-1').css("position", "fixed");
        },
        close: function () {
            
        }
    }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li class=''>")
              .append("<a title='" + item.id + "'><table><tr><td valign='top'><img src='" + item.img + "' width='50' height='50' /></td><td valign='top'>" + highlight(item.result, $('#searchkey').val()) + "</td></tr></table></a>")
              .appendTo(ul);
        };
    } catch (e) { }

    $('.empid-pick').each(function () {
        var SearchKey;
        $(this)
        .attr('placeholder','emp info')
        .autocomplete({
            source: function (request, response) {
                $.getJSON("SearchBox.ashx", {
                    term: extractLast(request.term)
                }, response);
            },
            search: function () {
                // custom minLength
                var term = extractLast(this.value);
                SearchKey = term;
                if (term.length < 1) {
                    return false;
                }
            },
            focus: function () {
                // prevent value inserted on focus
                return false;
            },
            autoFocus: true,
            //response:function( event, ui ) { return false; },
            select: function (event, ui) {
                $(this).val(ui.item.id);
                return false;
            }
        })
        .data("ui-autocomplete")._renderItem = function (ul, item) {
            //alert($(this).id);
            return $("<li>")
                .attr("data-value", item.id)
                .append("<a title='" + item.id + "'><table><tr><td valign='top'><img src='" + item.img + "' width='50' height='50' /></td><td valign='top'>"
                    + highlight(item.result, SearchKey) + "</td></tr></table></a>")
                .appendTo(ul);
        };
    });

    try {
        $('#txtSubject,#txtCommentDtl').autosize();
    }
    catch (E) { }

    try {
        $('a.lightbox').each(function () {
            $(this).attr('href', $(this).attr('href') + getLightBoxImageSizeText());
            $(this).lightBox({
                imageLoading: 'Images/wait_fb.gif',
                fitToWindow: true
            });
        });
    } catch (E) { }


    $('.div-preview a').each(function () {
        $(this).attr("target", "_blank");
        $(this).addClass('link');
    });


    $("div[class^='w-'],div[class*=' w-']").each(function () {
        var patt1 = /w[-][0-9]+/;
        var w = (' ' + $(this).attr('class')).match(patt1);
        w = ('' + w).substr(2, 10) + 'px';
        $(this).width(w);
    });

    $('input:text[Watermark]').each(function () {
        $(this).attr('placeholder',$(this).attr('Watermark'));
    });

    $('.attachmentAdd').click(function () {
        $('#uploadDialog').dialog({
            width: 650,
            height: 400,
            modal: true,
            show: "Slow",
            hide: "Slow",
            buttons: [{
                text: "Close",
                click: function () {
                    $(this).dialog("close");
                }
            }]
        });
        $('.ajax__fileupload_fileItemInfo').hide();
    });

    $(".ajax__fileupload").bind("change", function () {
        setTimeout(function () {
            $('.ajax__fileupload_uploadbutton').trigger('click');
        }, 100);
    });
    $(".ajax__fileupload_dropzone").bind("drop", function () {
        setTimeout(function () {
            $('.ajax__fileupload_uploadbutton').trigger('click');
        }, 100);
    });

    //$("#attachmentFileList").sortable({
    //    handle: ".MoveIcon",
    //    update: function (event, ui) {
    //        RefreshAttachments();
    //    }
    //}).disableSelection();

    $('img[loadimg]').each(function () {
        var imgurl = $(this).attr('loadimg');
        if (imgurl === "") { return }
        $(this).attr('src', imgurl);
        $(this).attr('onerror', 'this.src=\'Images/Error.jpg\'');
        $(this).removeAttr('loadimg');
    });

    //    $('#attachmentFileList input[type="checkbox"]:checked').each(function () {
    //        alert($(this).val());
    //    });


    $('#team-assign').each(function () {
        if (teamdata == null) {
            $.getJSON('getTeams.ashx?deptid=0', function (data) {
                teamdata = data;
                buildTeamSelector();
            });
        }
        else
            buildTeamSelector();
    });

    $('#my-team-assign').each(function () {
        $.getJSON('getDefaultService.ashx?deptid=' + $('#hidDeptID').val() + '&empid=' + $('#hidEmpID').val(), function (data) {
            teamdata = data;
            buildTeamSelectorCheckbox();
        });        
    });

    //var data = [{ 'id': 'ajson1', 'parent': '#', 'text': 'Simple root node', 'state': { 'opened': true} }, { 'id': 'ajson2', 'parent': '#', 'text': 'Root node 2', 'state': { 'opened': true} }, { 'id': 'ajson3', 'parent': 'ajson2', 'text': 'Child 1', 'state': { 'opened': true} }, { 'id': 'ajson4', 'parent': 'ajson2', 'text': 'Child 2', 'state': { 'opened': true}}];
    //alert(data);    


    $('.attach-del-btn').click(function () {
        $(this).parent().hide('slow', function () {
            $(this).remove();
            RefreshAttachments();
        });
    });

    //Refresh Challenge Key
    $('#ImgChallengeReload,#ImgChallenge').click(function () {
        $('#ImgChallenge').attr('src', 'Images/loading1.gif');
        $('#ctl00_ContentPlaceHolder2_txtCaptcha').val('').focus();
        setTimeout(function () {
            $('#ImgChallenge').attr('src', 'captcha.ashx?rand=' + Math.random());
        }, 100);
    });
    $('#ImgChallenge').attr('src', 'captcha.ashx?rand=' + Math.random());
    $('#ctl00_ContentPlaceHolder2_txtCaptcha').val('');


    $("time.timeago").timeago().addClass('no-print');
    $('#ctl00_ContentPlaceHolder2_GridView1_ctl02_txtPassportUpdateReason').val('');

    $('#ContentPlaceHolder2_DetailsView3_cboClientStatusName').buttonset();

    //Disable All Combo
    $("select option[value='']").attr('disabled', true);

    $('.Date').datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'dd/mm/yy',
        showAnim: 'show',
        todayHighlight: true
    });

//    $('#Date').datepicker({
//    autoclose: true,
//    todayHighlight: true
//});

    $('.Date').attr('placeholder','dd/mm/yyyy');



    //        Datepicker Today Problem Resolve
    $.datepicker._gotoToday = function (id) {
        var target = $(id);
        var inst = this._getInst(target[0]);
        if (this._get(inst, 'gotoCurrent') && inst.currentDay) {
            inst.selectedDay = inst.currentDay;
            inst.drawMonth = inst.selectedMonth = inst.currentMonth;
            inst.drawYear = inst.selectedYear = inst.currentYear;
        }
        else {
            var date = new Date();
            inst.selectedDay = date.getDate();
            inst.drawMonth = inst.selectedMonth = date.getMonth();
            inst.drawYear = inst.selectedYear = date.getFullYear();
            this._setDateDatepicker(target, date);
            this._selectDate(id, this._getDateDatepicker(target));
        }
        this._notifyChange(inst);
        this._adjustDate(target);
        this.removeClass('ui-priority-secondary');
    }
    //--------------------------------------------------------------

    //        $('.ui-datepicker-current').live('click', function() {
    //            var associatedInputSelector = $(this).attr('onclick').replace(/^.*'(#[^']+)'.*/gi, '$1');
    //            var $associatedInput = $(associatedInputSelector).datepicker("setDate", new Date());
    //            $associatedInput.datepicker("hide");
    //        });


    $('.number').filter_input({ regex: '[0-9]' });
    $('.lowercase').filter_input({ regex: '[a-z]' });
    $('.alphanumeric').filter_input({ regex: '[a-zA-Z0-9]' });
    $('.safe').filter_input({ regex: '[a-zA-Z0-9_]' });

    //$('input').iCheck({
    //    checkboxClass: 'icheckbox_square-green',
    //    radioClass: 'iradio_square-blue',
    //    increaseArea: '20%' // optional
    //});

    $('#cmdPrint').click(function () {
        var options = { mode: 'popup', popClose: '', extraCss: 'CSS/StyleSheetPrint.css' };
        $Div_PrintArea = $('#print-div');
        $("input[type='text']", $Div_PrintArea).each(function () {
            this.setAttribute('value', $(this).val());
            $(this).replaceWith("<b>" + this.value + "</b>");
        });
        $('#print-div').printArea(options);
    });

    $('.cmd-Attachment-show').click(function () {
        $('.cmd-Attachment-show').hide();
        $('.div-Attachment-Add').show('Slow');
    });
    $('.cmd-Attachment-hide').click(function () {
        $('.div-Attachment-Add').hide('Slow');
        $('.cmd-Attachment-show').show();
    });



    setTimeout(function () {
        $('.ms-drop').html('');

        $('select[multiple=multiple]').multipleSelect({
            placeholder: 'please select',
            filter: true,
            single: false
        });

        $('select.multi').multipleSelect({
            placeholder: 'please select',
            filter: true,
            single: true
        });
    }, 200);

    

    $('.trustclick').trustclick();
    $('.trustclick').each(function () {
        if ($(this).text().trim() === "") $(this).hide();
    });

    $('#cmdViewEmp').click(function () {
        var BranchID = $('#ddlBranch').val();
        var DeptID = $('#ddlDept').val();
        var Url = 'https://intraweb.tblbd.com/EmpBranch.aspx?branch=';

        if (BranchID < 1 || DeptID.trim() == '')
            jAlert('Please select Branch/Department to view.');
        else {
            if (DeptID == 0)
                Url += BranchID;
            else
                Url += BranchID + '&dept=' + DeptID
            window.open(Url);
        }
    });

    $('.autohyperlink').each(function () {
        $(this).html(replaceURLWithHTMLLinks($(this).html()));
    });

    //SIgnalR
    try {
        if ($('#hidChatHub').val() == "1") {
            var chat = $.connection.chatHub;
            
            $(window).focus(function () {
                //console.log("Focus");
                $.connection.hub.start().done(function () {
                    chat.server.registerConId($('#hidEmpID').val(), $('#hidTicketID').val());
                    console.log("Connected.");
                    //var notif = $.connection.notificationHub;
                    //console.log("notificationHub: " + notif);
                }).fail(function () {
                    console.log('Could not Connect to the Hub!');
                });

                $.connection.hub.connectionSlow(function () {
                    console.log('We are currently experiencing difficulties with the connection.')
                });

                $.connection.hub.error(function (error) {
                    console.log("" + error)
                });

                $.connection.hub.reconnecting(function () {
                    console.log('Reconnecting...')
                });

                $.connection.hub.reconnected(function () {
                    chat.server.registerConId($('#hidEmpID').val(), $('#hidTicketID').val());
                    console.log('Reconnected.')
                });

                chat.client.broadcastMessage = function (empid, ticketid, message, reload) {
                    //playSound('audio/msg.mp3');
                    if (reload == "1")
                        $('#cmdPost').click();

                };
            });

            $(window).blur(function () {
                chat.server.disconnectConId($('#hidEmpID').val(), $('#hidTicketID').val());
                console.log("Disconnected.");
            });
        }
    }
    catch (e) { }

    
}