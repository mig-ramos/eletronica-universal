{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Data.FileEmbed (embedFile)
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getAssinanteR :: Handler Html
getAssinanteR = do 
    defaultLayout $ do 
        addScript (StaticR js_gtag_js)
        setTitle "Eletrônica Universal"
        addStylesheetRemote "https://fonts.googleapis.com/css?family=Sail|Roboto+Condensed:300,400,400i,700"
        addStylesheetRemote "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
        addStylesheet (StaticR css_w3_css)
        addStylesheet (StaticR css_mystyle_css)
  
        toWidgetHead
            [hamlet|
            <meta charset="UTF-8">
            <meta name="google-site-verification" content="a7H32sTci5dQttMhgXtyAkX4yi75NJhvnaBCiXMwpHo">
            <meta name=keywords content="eletronica, hobby eletrônica, arduino, projetos eletrônicos">
            <meta name=description content="Fundamentos da Eletrônica Universal, suas ramificações, IOT e projetos.">
            <meta name=author content="Miguel Arcanjo - Luiz Sorbello - Gustavo">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">            
            <meta name="viewport" content="width=device-width, initial-scale=1">
            |] 

        toWidget $(juliusFile "templates/mobile.julius")
        $(whamletFile "templates/assinante_menu.hamlet")
        $(whamletFile "templates/assinante.hamlet")

        $(whamletFile "templates/rodape.hamlet")

getAdsR :: Handler TypedContent
getAdsR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/ads.txt")

getSitemapR :: Handler TypedContent
getSitemapR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/sitemap.xml")    

getHomeR :: Handler Html
getHomeR = do
    sess <- lookupSession "_NOME" 
    defaultLayout $ do 
        setTitle "Eletrônica Universal"
        addStylesheetRemote "https://fonts.googleapis.com/css?family=Sail|Roboto+Condensed:300,400,400i,700"
        addStylesheetRemote "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
        addStylesheet (StaticR css_w3_css)
        addStylesheet (StaticR css_mystyle_css)
        addScript(StaticR js_gtag_js)
   
        toWidgetHead
            [hamlet|
                <meta charset="UTF-8">
                -- <script data-ad-client="ca-pub-4957039376509185" async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js">
                <meta name="google-site-verification" content="a7H32sTci5dQttMhgXtyAkX4yi75NJhvnaBCiXMwpHo">
                <meta name=keywords content="eletronica, hobby eletrônica, arduino">
                <meta name=description content="Fundamentos da Eletrônica Universal, suas ramificações, IOT e projetos.">
                <meta name=author content="Miguel Arcanjo - Luiz Sorbello - Gustavo">
                <meta name="viewport" content="width=device-width, initial-scale=1">
            |] 
        toWidgetHead    
            [julius|
                <script type="text/javascript" async="async" >
                    var elem = document.createElement('script');
                    elem.src = 'https://quantcast.mgr.consensu.org/cmp.js';
                    elem.async = true;
                    elem.type = "text/javascript";
                    var scpt = document.getElementsByTagName('script')[0];
                    scpt.parentNode.insertBefore(elem, scpt);
                    (function() {
                    var gdprAppliesGlobally = false;
                    function addFrame() {
                        if (!window.frames['__cmpLocator']) {
                        if (document.body) {
                            var body = document.body,
                                iframe = document.createElement('iframe');
                            iframe.style = 'display:none';
                            iframe.name = '__cmpLocator';
                            body.appendChild(iframe);
                        } else {
                            setTimeout(addFrame, 5);
                        }
                        }
                    }
                    addFrame();
                    function cmpMsgHandler(event) {
                        var msgIsString = typeof event.data === "string";
                        var json;
                        if(msgIsString) {
                        json = event.data.indexOf("__cmpCall") != -1 ? JSON.parse(event.data) : {};
                        } else {
                        json = event.data;
                        }
                        if (json.__cmpCall) {
                        var i = json.__cmpCall;
                        window.__cmp(i.command, i.parameter, function(retValue, success) {
                            var returnMsg = {"__cmpReturn": {
                            "returnValue": retValue,
                            "success": success,
                            "callId": i.callId
                            }};
                            event.source.postMessage(msgIsString ?
                            JSON.stringify(returnMsg) : returnMsg, '*');
                        });
                        }
                    }
                    window.__cmp = function (c) {
                        var b = arguments;
                        if (!b.length) {
                        return __cmp.a;
                        }
                        else if (b[0] === 'ping') {
                        b[2]({"gdprAppliesGlobally": gdprAppliesGlobally,
                            "cmpLoaded": false}, true);
                        } else if (c == '__cmp')
                        return false;
                        else {
                        if (typeof __cmp.a === 'undefined') {
                            __cmp.a = [];
                        }
                        __cmp.a.push([].slice.apply(b));
                        }
                    }
                    window.__cmp.gdprAppliesGlobally = gdprAppliesGlobally;
                    window.__cmp.msgHandler = cmpMsgHandler;
                    if (window.addEventListener) {
                        window.addEventListener('message', cmpMsgHandler, false);
                    }
                    else {
                        window.attachEvent('onmessage', cmpMsgHandler);
                    }
                    })();
                    window.__cmp('init', {
                            'Language': 'pt',
                        'Initial Screen Body Text Option': 1,
                        'Publisher Name': 'Moneytizer',
                        'Default Value for Toggles': 'off',
                        'UI Layout': 'banner',
                        'No Option': false,
                    });
                </script>
                <style>
                    .qc-cmp-button,
                    .qc-cmp-button.qc-cmp-secondary-button:hover {
                        background-color: #000000 !important;
                        border-color: #000000 !important;
                    }
                    .qc-cmp-button:hover,
                    .qc-cmp-button.qc-cmp-secondary-button {
                        background-color: transparent !important;
                        border-color: #000000 !important;
                    }
                    .qc-cmp-alt-action,
                    .qc-cmp-link {
                        color: #000000 !important;
                    }
                    .qc-cmp-button,
                    .qc-cmp-button.qc-cmp-secondary-button:hover {
                        color: #ffffff !important;
                    }
                    .qc-cmp-button:hover,
                    .qc-cmp-button.qc-cmp-secondary-button {
                        color: #000000 !important;
                    }
                    .qc-cmp-small-toggle,
                    .qc-cmp-toggle {
                        background-color: #000000 !important;
                        border-color: #000000 !important;
                    }
                    .qc-cmp-main-messaging,
                    .qc-cmp-messaging,
                    .qc-cmp-sub-title,
                    .qc-cmp-privacy-settings-title,
                    .qc-cmp-purpose-list,
                    .qc-cmp-tab,
                    .qc-cmp-title,
                    .qc-cmp-vendor-list,
                    .qc-cmp-vendor-list-title,
                    .qc-cmp-enabled-cell,
                    .qc-cmp-toggle-status,
                    .qc-cmp-table,
                    .qc-cmp-table-header {
                        color: #000000 !important;
                    }
                    
                    .qc-cmp-ui {
                        background-color: #ffffff !important;
                    }
            
                    .qc-cmp-table,
                    .qc-cmp-table-row {
                        border: 1px solid !important;
                        border-color: #000000 !important;
                    } 
                    #qcCmpButtons a {
                            text-decoration: none !important;
                
                    }
                    
                    #qcCmpButtons button {
                        margin-top: 65px;
                    }
                    .qc-cmp-qc-link-container{
                        display:none;
                    }
                </style>
        
            |]

        toWidget $(juliusFile "templates/index.julius")
        $(whamletFile "templates/index_menu.hamlet")
        $(whamletFile "templates/index.hamlet")
        $(whamletFile "templates/rodape.hamlet")

